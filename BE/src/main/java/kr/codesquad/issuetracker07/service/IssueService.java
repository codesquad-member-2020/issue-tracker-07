package kr.codesquad.issuetracker07.service;

import kr.codesquad.issuetracker07.dto.*;
import kr.codesquad.issuetracker07.entity.Attachment;
import kr.codesquad.issuetracker07.entity.Issue;
import kr.codesquad.issuetracker07.entity.User;
import kr.codesquad.issuetracker07.repository.IssueRepository;
import kr.codesquad.issuetracker07.response.IssueDetailResponse;
import kr.codesquad.issuetracker07.response.IssueListResponse;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Service
public class IssueService {

    private final IssueRepository issueRepository;

    public IssueService(IssueRepository issueRepository) {
        this.issueRepository = issueRepository;
    }

    public void makeNewIssue(User user, String title, String description) {
        Issue issue = new Issue().builder()
                                 .user(user)
                                 .title(title)
                                 .description(description)
                                 .isOpen(true)
                                 .createdBy(user.getName())
                                 .createdAt(LocalDateTime.now())
                                 .modifiedBy(user.getName())
                                 .modifiedAt(LocalDateTime.now())
                                 .milestone(null)
                                 .commentList(new ArrayList<>())
                                 .assigneeList(new ArrayList<>())
                                 .attachmentList(new ArrayList<>())
                                 .build();
        user.addIssue(issue);
        issueRepository.save(issue);
    }

    public List<Issue> findAllIssue() {
        return issueRepository.findAll();
    }

    public IssueListResponse makeIssueListSummary(List<Issue> issueList) {
        List<IssueSummaryVO> issueSummaryVO = issueList.stream().map(this::makeIssueSummaryVO)
                                                                .collect(Collectors.toList());
        return new IssueListResponse().builder()
                                      .status(true)
                                      .issue(issueSummaryVO)
                                      .build();
    }

    public IssueDetailResponse makeIssueResponse(Issue issue) {
        IssueVO issueVO = IssueVO.builder()
                                 .id(issue.getId())
                                 .title(issue.getTitle())
                                 .authorName(issue.getUser().getName())
                                 .imageUrl(issue.getUser().getImageUrl())
                                 .isOpen(issue.isOpen())
                                 .createdAt(issue.getCreatedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
                                 .comment(issue.getCommentList().stream().map(comment -> {
                                     return new CommentSummaryVO().builder()
                                             .id(comment.getId())
                                             .name(comment.getWriter())
                                             .imageUrl(comment.getImageUrl())
                                             .content(comment.getContent())
                                             .createdAt(comment.getCreatedAt())
                                             .modifiedAt(comment.getModifiedAt())
                                             .emoji(comment.getAddingList().stream().map(adding -> {
                                                 return new EmojiSummaryVO().builder()
                                                                            .id(adding.getEmoji().getId())
                                                                            .unicode(adding.getEmoji().getUnicode())
                                                                            .build();
                                             }).collect(Collectors.toList()))
                                             .build();
                                 }).collect(Collectors.toList()))
                                 .milestone(makeMilestoneSummaryVOList(issue))
                                 .label(issue.getAttachmentList().stream()
                                                                 .filter(Attachment::isAttached)
                                                                 .map(this::makeLabelSummaryVO)
                                                                 .collect(Collectors.toList()))
                                 .assignee(issue.getAssigneeList().stream().map(assignee -> {
                                     return new AssigneeSummaryVO().builder()
                                                                   .id(assignee.getId())
                                                                   .name(assignee.getName())
                                                                   .imageUrl(assignee.getImageUrl())
                                                                   .build();
                                 }).collect(Collectors.toList()))
                                 .build();

        return new IssueDetailResponse().builder()
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
        return new IssueSummaryVO().builder()
                                   .id(issue.getId())
                                   .title(issue.getTitle())
                                   .description(issue.getDescription())
                                   .isOpen(issue.isOpen())
                                   .createdAt(issue.getCreatedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
                                   .milestone(makeMilestoneSummaryVOList(issue))
                                   .label(issue.getAttachmentList().stream()
                                                                   .filter(Attachment::isAttached)
                                                                   .map(this::makeLabelSummaryVO)
                                                                   .collect(Collectors.toList()))
                                   .build();
    }

    private List<MilestoneSummaryVO> makeMilestoneSummaryVOList(Issue issue) {
        if (issue.getMilestone() == null) {
            return Collections.emptyList();
        }
        if (!issue.getMilestone().isAttached()) {
            return Collections.emptyList();
        }
        return Collections.singletonList(new MilestoneSummaryVO().builder()
                                                                 .id(issue.getMilestone().getId())
                                                                 .title(issue.getMilestone().getTitle())
                                                                 .build());
    }

    private LabelSummaryVO makeLabelSummaryVO(Attachment attachment) {
        return new LabelSummaryVO().builder()
                                   .id(attachment.getLabel().getId())
                                   .title(attachment.getLabel().getTitle())
                                   .backgroundColor(attachment.getLabel().getBackgroundColor())
                                   .build();
    }

    private void setIssueOpen(String state, Issue issue) {
        issue.setOpen(true);
        if (state.equals("close")) {
            issue.setOpen(false);
        }
    }
}
