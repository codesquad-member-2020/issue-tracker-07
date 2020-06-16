package kr.codesquad.issuetracker07.repository;

import kr.codesquad.issuetracker07.domain.Assignee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AssigneeRepository extends JpaRepository<Assignee, Long> {

}
