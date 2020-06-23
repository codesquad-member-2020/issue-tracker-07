package kr.codesquad.issuetracker07.service;

import kr.codesquad.issuetracker07.dto.MilestoneDetailVO;
import kr.codesquad.issuetracker07.dto.MilestoneVO;
import kr.codesquad.issuetracker07.entity.AttachmentMilestone;
import kr.codesquad.issuetracker07.entity.Issue;
import kr.codesquad.issuetracker07.entity.Milestone;
import kr.codesquad.issuetracker07.entity.User;
import kr.codesquad.issuetracker07.repository.AttachmentMilestoneRepository;
import kr.codesquad.issuetracker07.repository.IssueRepository;
import kr.codesquad.issuetracker07.repository.MilestoneRepository;
import kr.codesquad.issuetracker07.response.MilestoneDetailResponse;
import kr.codesquad.issuetracker07.response.MilestoneListResponse;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Service
public class MilestoneService {

    private final MilestoneRepository milestoneRepository;

    private final AttachmentMilestoneRepository attachmentMilestoneRepository;

    private final IssueRepository issueRepository;

    public MilestoneService(MilestoneRepository milestoneRepository,
                            AttachmentMilestoneRepository attachmentMilestoneRepository,
                            IssueRepository issueRepository) {
        this.milestoneRepository = milestoneRepository;
        this.attachmentMilestoneRepository = attachmentMilestoneRepository;
        this.issueRepository = issueRepository;
    }

    public void makeNewMilestone(User user, Long issueId, MilestoneVO milestoneVO) {
        Issue issue = issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);
        Milestone milestone = Milestone.builder()
                                       .title(milestoneVO.getTitle())
                                       .dueDate(milestoneVO.getDueDate())
                                       .description(milestoneVO.getDescription())
                                       .createdBy(user.getName())
                                       .createdAt(LocalDateTime.now())
                                       .modifiedBy(user.getName())
                                       .modifiedAt(LocalDateTime.now())
                                       .build();
        milestoneRepository.save(milestone);
        AttachmentMilestone attachmentMilestone = AttachmentMilestone.builder()
                                                                     .issue(issue)
                                                                     .milestone(milestone)
                                                                     .isAttached(false)
                                                                     .build();
        attachmentMilestoneRepository.save(attachmentMilestone);
    }

    public MilestoneListResponse makeMilestoneList(Long issueId) {
        Issue issue = issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);
        List<Milestone> milestoneList = issue.getAttachmentMilestoneList().stream()
                                                                          .map(AttachmentMilestone::getMilestone)
                                                                          .collect(Collectors.toList());
        List<MilestoneDetailVO> milestoneDetailVOList = milestoneList.stream()
                                                                     .map(milestone -> makeMilestoneDetailVO(issue, milestone))
                                                                     .collect(Collectors.toList());
        return MilestoneListResponse.builder()
                                    .status(true)
                                    .milestone(milestoneDetailVOList)
                                    .build();
    }

    public MilestoneDetailResponse makeMilestoneDetail(Long issueId, Long milestoneId) {
        Issue issue = issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);
        Milestone milestone = issue.getAttachmentMilestoneList().stream()
                                                                .filter(attachmentMilestone -> attachmentMilestone.getMilestone().getId().equals(milestoneId))
                                                                .findFirst()
                                                                .orElseThrow(NoSuchElementException::new)
                                                                .getMilestone();
        return MilestoneDetailResponse.builder()
                                      .status(true)
                                      .milestone(milestone)
                                      .build();
    }

    public void modifyMilestone(User user, Long issueId, Long milestoneId, MilestoneVO milestoneVO) {
        Milestone milestone = milestoneRepository.findById(milestoneId).orElseThrow(NoSuchElementException::new);
        AttachmentMilestone attachmentMilestone = attachmentMilestoneRepository.findByIssueIdAndMilestoneId(issueId, milestoneId);
        update(milestone, attachmentMilestone, milestoneVO, user.getName());
    }

    public void attachMilestone(Long issueId, Long milestoneId) {
        AttachmentMilestone attachmentMilestone = attachmentMilestoneRepository.findByIssueIdAndMilestoneId(issueId, milestoneId);
        attachmentMilestone.setAttached(true);
        attachmentMilestoneRepository.save(attachmentMilestone);
    }

    public void deleteMilestone(Long issueId, Long milestoneId) {
        Milestone milestone = milestoneRepository.findById(milestoneId).orElseThrow(NoSuchElementException::new);
        AttachmentMilestone attachmentMilestone = attachmentMilestoneRepository.findByIssueIdAndMilestoneId(issueId, milestoneId);
        attachmentMilestoneRepository.delete(attachmentMilestone);
        milestoneRepository.delete(milestone);
    }

    private MilestoneDetailVO makeMilestoneDetailVO(Issue issue, Milestone milestone) {
        AttachmentMilestone attachmentMilestone = attachmentMilestoneRepository.findByIssueIdAndMilestoneId(issue.getId(), milestone.getId());
        return MilestoneDetailVO.builder()
                                .id(milestone.getId())
                                .title(milestone.getTitle())
                                .description(milestone.getDescription())
                                .dueDate(milestone.getDueDate())
                                .progress(attachmentMilestone.getProgress())
                                .openedIssueCount(attachmentMilestone.getOpenedIssueCount())
                                .closedIssueCount(attachmentMilestone.getClosedIssueCount())
                                .build();
    }

    private void update(Milestone milestone, AttachmentMilestone attachmentMilestone, MilestoneVO milestoneVO, String userName) {
        milestone.setTitle(milestoneVO.getTitle());
        milestone.setDueDate(milestoneVO.getDueDate());
        milestone.setDescription(milestoneVO.getDescription());
        milestone.setModifiedBy(userName);
        milestone.setModifiedAt(LocalDateTime.now());
        milestoneRepository.save(milestone);
        attachmentMilestone.setMilestone(milestone);
        attachmentMilestoneRepository.save(attachmentMilestone);
    }
}
