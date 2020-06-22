package kr.codesquad.issuetracker07.repository;

import kr.codesquad.issuetracker07.entity.Milestone;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MilestoneRepository extends JpaRepository<Milestone, Long> {

}
