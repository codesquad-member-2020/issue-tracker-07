package kr.codesquad.issuetracker07.service;

import kr.codesquad.issuetracker07.domain.*;
import kr.codesquad.issuetracker07.dto.IssueSummaryVO;
import kr.codesquad.issuetracker07.dto.LabelSummaryVO;
import kr.codesquad.issuetracker07.dto.LabelVO;
import kr.codesquad.issuetracker07.dto.MilestoneSummaryVO;
import kr.codesquad.issuetracker07.repository.AttachmentRepository;
import kr.codesquad.issuetracker07.repository.IssueRepository;
import kr.codesquad.issuetracker07.repository.LabelRepository;
import kr.codesquad.issuetracker07.repository.MilestoneRepository;
import kr.codesquad.issuetracker07.response.IssueListResponse;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Service
public class IssueService {

    private final IssueRepository issueRepository;

    private final MilestoneRepository milestoneRepository;

    private final LabelRepository labelRepository;

    private final AttachmentRepository attachmentRepository;

    public IssueService(IssueRepository issueRepository,
                        MilestoneRepository milestoneRepository,
                        LabelRepository labelRepository,
                        AttachmentRepository attachmentRepository) {
        this.issueRepository = issueRepository;
        this.milestoneRepository = milestoneRepository;
        this.labelRepository = labelRepository;
        this.attachmentRepository = attachmentRepository;
    }

    public void makeNewIssue(User user, String title, String description) {
        Milestone milestone = new Milestone().builder()
                                             .title("스프린트")
                                             .description("마일스톤 내용")
                                             .dueDate(LocalDate.of(2020, 6, 25))
                                             .build();
        milestoneRepository.save(milestone);

        Issue issue = new Issue().builder()
                                 .user(user)
                                 .title(title)
                                 .description(description)
                                 .isOpen(true)
                                 .createdAt(LocalDate.now())
                                 .modifiedAt(LocalDate.now())
                                 .milestone(milestone)
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
        List<IssueSummaryVO> issueSummaryVO =
                issueList.stream()
                         .map(issue -> new IssueSummaryVO().builder()
                                                  .id(issue.getId())
                                                  .title(issue.getTitle())
                                                  .description(issue.getDescription())
                                                  .isOpen(issue.isOpen())
                                                  .createdAt(issue.getCreatedAt())
                                                  .milestone(new MilestoneSummaryVO().builder()
                                                                                     .id(issue.getMilestone().getId())
                                                                                     .title(issue.getMilestone().getTitle())
                                                                                     .build())
                                                  .label(issue.getAttachmentList().stream()
                                                            .filter(Attachment::isAttached)
                                                            .map(attachment -> new LabelSummaryVO().builder()
                                                                                                   .id(attachment.getLabel().getId())
                                                                                                   .title(attachment.getLabel().getTitle())
                                                                                                   .backgroundColor(attachment.getLabel().getBackgroundColor())
                                                                                                   .build())
                                                            .collect(Collectors.toList()))
                                                  .build())
                         .collect(Collectors.toList());
        return new IssueListResponse().builder()
                                      .status(true)
                                      .issue(issueSummaryVO)
                                      .build();
    }

    public Issue findIssueByIssueId(Long issueId) {
        return issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);
    }

    public void makeNewLabel(User user, Issue issue, LabelVO labelVO) {
        if (user.getName().equals(issue.getUser().getName())) {
            Label label = new Label().builder()
                                     .title(labelVO.getTitle())
                                     .description(labelVO.getDescription())
                                     .backgroundColor(labelVO.getBackgroundColor())
                                     .build();
            labelRepository.save(label);
            Attachment attachment = new Attachment().builder()
                                                    .issue(issue)
                                                    .label(label)
                                                    .isAttached(false)
                                                    .build();
            attachmentRepository.save(attachment);
            issueRepository.save(issue);
        }
    }

    public void attachLabel(Long issueId, Long labelId) {
        Attachment attachment = attachmentRepository.findByIssue_IdAndLabel_Id(issueId, labelId)
                                                    .orElseThrow(NoSuchElementException::new);
        attachment.setAttached(true);
        attachmentRepository.save(attachment);
    }
}
