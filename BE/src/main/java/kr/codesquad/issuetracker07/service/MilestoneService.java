package kr.codesquad.issuetracker07.service;

import kr.codesquad.issuetracker07.domain.Issue;
import kr.codesquad.issuetracker07.domain.Milestone;
import kr.codesquad.issuetracker07.dto.MilestoneVO;
import kr.codesquad.issuetracker07.repository.MilestoneRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.NoSuchElementException;

@Service
public class MilestoneService {

    private final MilestoneRepository milestoneRepository;

    public MilestoneService(MilestoneRepository milestoneRepository) {
        this.milestoneRepository = milestoneRepository;
    }

    public void makeNewMilestone(Issue issue, MilestoneVO milestoneVO) {
        Milestone milestone = Milestone.builder()
                                       .title(milestoneVO.getTitle())
                                       .dueDate(milestoneVO.getDueDate())
                                       .description(milestoneVO.getDescription())
                                       .isAttached(false)
                                       .issue(new ArrayList<>())
                                       .build();
        milestone.addIssue(issue);
        milestoneRepository.save(milestone);
    }

    public Milestone findMilestoneByMilestoneId(Long milestoneId) {
        return milestoneRepository.findById(milestoneId).orElseThrow(NoSuchElementException::new);
    }

    public void attachMilestone(Issue issue, Milestone milestone) {
        milestone.setAttached(true);
        milestone.modifyIssue(issue);
        milestoneRepository.save(milestone);
    }
}
