package kr.codesquad.issuetracker07.service;

import kr.codesquad.issuetracker07.dto.MilestoneDetailVO;
import kr.codesquad.issuetracker07.dto.MilestoneVO;
import kr.codesquad.issuetracker07.entity.Milestone;
import kr.codesquad.issuetracker07.entity.User;
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

    public MilestoneService(MilestoneRepository milestoneRepository) {
        this.milestoneRepository = milestoneRepository;
    }

    public void makeNewMilestone(User user, MilestoneVO milestoneVO) {
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
    }

    public MilestoneListResponse makeMilestoneList() {
        List<Milestone> milestoneList = milestoneRepository.findAll();
        List<MilestoneDetailVO> milestoneDetailVOList = milestoneList.stream()
                                                                     .map(this::makeMilestoneDetailVO)
                                                                     .collect(Collectors.toList());
        return MilestoneListResponse.builder()
                                    .status(true)
                                    .milestone(milestoneDetailVOList)
                                    .build();
    }

    public MilestoneDetailResponse makeMilestoneDetail(Long milestoneId) {
        Milestone milestone = milestoneRepository.findById(milestoneId).orElseThrow(NoSuchElementException::new);
        return MilestoneDetailResponse.builder()
                                      .status(true)
                                      .milestone(milestone)
                                      .build();
    }

    public void modifyMilestone(User user, Long milestoneId, MilestoneVO milestoneVO) {
        Milestone milestone = milestoneRepository.findById(milestoneId).orElseThrow(NoSuchElementException::new);
        update(milestone, milestoneVO, user.getName());
    }

    public void deleteMilestone(Long milestoneId) {
        Milestone milestone = milestoneRepository.findById(milestoneId).orElseThrow(NoSuchElementException::new);
        milestoneRepository.delete(milestone);
    }

    private MilestoneDetailVO makeMilestoneDetailVO(Milestone milestone) {
        return MilestoneDetailVO.builder()
                                .id(milestone.getId())
                                .title(milestone.getTitle())
                                .description(milestone.getDescription())
                                .dueDate(milestone.getDueDate())
                                .progress(0)
                                .openedIssueCount(0)
                                .closedIssueCount(0)
                                .build();
    }

    private void update(Milestone milestone, MilestoneVO milestoneVO, String userName) {
        milestone.setTitle(milestoneVO.getTitle());
        milestone.setDueDate(milestoneVO.getDueDate());
        milestone.setDescription(milestoneVO.getDescription());
        milestone.setModifiedBy(userName);
        milestone.setModifiedAt(LocalDateTime.now());
        milestoneRepository.save(milestone);
    }
}
