package kr.codesquad.issuetracker07.repository;

import kr.codesquad.issuetracker07.domain.Attachment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AttachmentRepository extends JpaRepository<Attachment, Long> {

    Optional<Attachment> findByIssue_IdAndLabel_Id(@Param(value = "issueId") Long issueId,
                                                   @Param(value = "labelId") Long labelId);

}
