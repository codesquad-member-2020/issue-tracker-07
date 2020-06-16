package kr.codesquad.issuetracker07.repository;

import kr.codesquad.issuetracker07.domain.Issue;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface IssueRepository extends CrudRepository<Issue, Long> {

    Optional<Issue> findById(Long id);

    List<Issue> findAll();
}
