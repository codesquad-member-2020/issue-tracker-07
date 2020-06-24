package kr.codesquad.issuetracker07.service;

import kr.codesquad.issuetracker07.dto.*;
import kr.codesquad.issuetracker07.entity.*;
import kr.codesquad.issuetracker07.repository.*;
import kr.codesquad.issuetracker07.response.IssueDetailResponse;
import kr.codesquad.issuetracker07.response.IssueListResponse;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Service
public class IssueService {

    private final IssueRepository issueRepository;

    private final AttachmentLabelRepository attachmentLabelRepository;

    private final LabelRepository labelRepository;

    private final AttachmentMilestoneRepository attachmentMilestoneRepository;

    private final MilestoneRepository milestoneRepository;

    public IssueService(IssueRepository issueRepository,
                        AttachmentLabelRepository attachmentLabelRepository,
                        LabelRepository labelRepository,
                        AttachmentMilestoneRepository attachmentMilestoneRepository,
                        MilestoneRepository milestoneRepository) {
        this.issueRepository = issueRepository;
        this.attachmentLabelRepository = attachmentLabelRepository;
        this.labelRepository = labelRepository;
        this.attachmentMilestoneRepository = attachmentMilestoneRepository;
        this.milestoneRepository = milestoneRepository;
    }

    public void makeNewIssue(User user, String title, String description) {
        Issue issue = Issue.builder()
                           .user(user)
                           .title(title)
                           .description(description)
                           .isOpen(true)
                           .createdBy(user.getName())
                           .createdAt(LocalDateTime.now())
                           .modifiedBy(user.getName())
                           .modifiedAt(LocalDateTime.now())
                           .attachmentMilestoneList(new ArrayList<>())
                           .commentList(new ArrayList<>())
                           .assigneeList(new ArrayList<>())
                           .attachmentLabelList(new ArrayList<>())
                           .build();
        user.addIssue(issue);
        issueRepository.save(issue);
    }

    public List<Issue> findAllIssue() {
        return issueRepository.findAll();
    }

    public IssueListResponse makeIssueList(List<Issue> issueList) {
        List<IssueSummaryVO> issueSummaryVO = issueList.stream().map(this::makeIssueSummaryVO)
                                                                .collect(Collectors.toList());
        return IssueListResponse.builder()
                                .status(true)
                                .issue(issueSummaryVO)
                                .build();
    }

    public IssueDetailResponse makeIssueDetail(Issue issue) {
        IssueVO issueVO = IssueVO.builder()
                                 .id(issue.getId())
                                 .title(issue.getTitle())
                                 .authorName(issue.getUser().getName())
                                 .imageUrl(issue.getUser().getImageUrl())
                                 .isOpen(issue.isOpen())
                                 .createdAt(issue.getCreatedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
                                 .comment(issue.getCommentList().stream()
                                                                .map(comment -> CommentSummaryVO.builder()
                                                                                                .id(comment.getId())
                                                                                                .name(comment.getWriter())
                                                                                                .imageUrl(comment.getImageUrl())
                                                                                                .content(comment.getContent())
                                                                                                .createdAt(comment.getCreatedAt())
                                                                                                .modifiedAt(comment.getModifiedAt())
                                                                                                .emoji(getEmojiSummaryVOList(comment))
                                                                                                .build())
                                                                .collect(Collectors.toList()))
                                 .milestone(issue.getAttachmentMilestoneList().stream()
                                                                              .filter(AttachmentMilestone::isAttached)
                                                                              .map(this::makeMilestoneSummaryVO)
                                                                              .collect(Collectors.toList()))
                                 .label(issue.getAttachmentLabelList().stream()
                                                                      .filter(AttachmentLabel::isAttached)
                                                                      .map(this::makeLabelSummaryVO)
                                                                      .collect(Collectors.toList()))
                                 .assignee(issue.getAssigneeList().stream().map(assignee -> AssigneeSummaryVO.builder()
                                                                                                             .id(assignee.getId())
                                                                                                             .name(assignee.getName())
                                                                                                             .imageUrl(assignee.getImageUrl())
                                                                                                             .build()).collect(Collectors.toList()))
                                 .build();

        return IssueDetailResponse.builder()
                                  .status(true)
                                  .issue(issueVO)
                                  .build();
    }

    public Issue findIssueByIssueId(Long issueId) {
        return issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);
    }

    public void modifyIssue(User user, Long issueId, IssueRequestVO issueRequestVO) {
        Issue issue = issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);
        issue.setTitle(issueRequestVO.getTitle());
        issue.setDescription(issueRequestVO.getDescription());
        issue.setModifiedBy(user.getName());
        issue.setModifiedAt(LocalDateTime.now());
        issueRepository.save(issue);
    }

    public void closeOrOpenSelectedIssues(List<Long> issueIdList, String state) {
        issueIdList.forEach(issueId -> {
            Issue issue = issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);
            setIssueOpen(state, issue);
            issue.setModifiedAt(LocalDateTime.now());
            issueRepository.save(issue);
        });
    }

    public boolean deleteIssue(User user, Long issueId) {
        Issue issue = issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);
        if (user.getName().equals(issue.getUser().getName())) {
            issueRepository.delete(issue);
            return true;
        }
        return false;
    }

    private IssueSummaryVO makeIssueSummaryVO(Issue issue) {
        return IssueSummaryVO.builder()
                             .id(issue.getId())
                             .title(issue.getTitle())
                             .description(issue.getDescription())
                             .isOpen(issue.isOpen())
                             .createdAt(issue.getCreatedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
                             .milestone(issue.getAttachmentMilestoneList().stream()
                                                                          .filter(AttachmentMilestone::isAttached)
                                                                          .map(this::makeMilestoneSummaryVO)
                                                                          .collect(Collectors.toList()))
                             .label(issue.getAttachmentLabelList().stream()
                                                                  .filter(AttachmentLabel::isAttached)
                                                                  .map(this::makeLabelSummaryVO)
                                                                  .collect(Collectors.toList()))
                             .build();
    }

    private MilestoneSummaryVO makeMilestoneSummaryVO(AttachmentMilestone attachmentMilestone) {
        return MilestoneSummaryVO.builder()
                                 .id(attachmentMilestone.getMilestone().getId())
                                 .title(attachmentMilestone.getMilestone().getTitle())
                                 .build();
    }

    private LabelSummaryVO makeLabelSummaryVO(AttachmentLabel attachmentLabel) {
        return LabelSummaryVO.builder()
                             .id(attachmentLabel.getLabel().getId())
                             .title(attachmentLabel.getLabel().getTitle())
                             .backgroundColor(attachmentLabel.getLabel().getBackgroundColor())
                             .build();
    }

    private List<EmojiSummaryVO> getEmojiSummaryVOList(Comment comment) {
        return comment.getAddingList().stream()
                                       .map(adding -> EmojiSummaryVO.builder()
                                                                    .id(adding.getEmoji().getId())
                                                                    .unicode(adding.getEmoji().getUnicode())
                                                                    .build())
                                       .collect(Collectors.toList());
    }

    private void setIssueOpen(String state, Issue issue) {
        issue.setOpen(true);
        if (state.equals("close")) {
            issue.setOpen(false);
        }
    }

    public void attachLabel(Long issueId, Long labelId) {
        Issue issue = issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);
        Label label = labelRepository.findById(labelId).orElseThrow(NoSuchElementException::new);
        AttachmentLabel attachmentLabel = AttachmentLabel.builder()
                                                         .issue(issue)
                                                         .label(label)
                                                         .isAttached(true)
                                                         .build();
        attachmentLabelRepository.save(attachmentLabel);
    }

    public void attachMilestone(Long issueId, Long milestoneId) {
        Issue issue = issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);
        Milestone milestone = milestoneRepository.findById(milestoneId).orElseThrow(NoSuchElementException::new);
        AttachmentMilestone attachmentMilestone = AttachmentMilestone.builder()
                                                                     .issue(issue)
                                                                     .milestone(milestone)
                                                                     .isAttached(true)
                                                                     .build();
        attachmentMilestoneRepository.save(attachmentMilestone);
    }
}
