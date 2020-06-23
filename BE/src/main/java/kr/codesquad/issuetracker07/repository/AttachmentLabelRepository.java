package kr.codesquad.issuetracker07.repository;

import kr.codesquad.issuetracker07.entity.AttachmentLabel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AttachmentLabelRepository extends JpaRepository<AttachmentLabel, Long> {

    AttachmentLabel findByIssueIdAndLabelId(Long issueId, Long labelId);
}
