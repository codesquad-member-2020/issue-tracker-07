package kr.codesquad.issuetracker07.repository;

import kr.codesquad.issuetracker07.entity.AttachmentMilestone;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AttachmentMilestoneRepository extends JpaRepository<AttachmentMilestone, Long> {

    AttachmentMilestone findByIssueIdAndMilestoneId(Long issueId, Long milestoneId);
}
