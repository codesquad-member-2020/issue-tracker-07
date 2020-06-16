package kr.codesquad.issuetracker07.repository;

import kr.codesquad.issuetracker07.domain.Adding;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AddingRepository extends JpaRepository<Adding, Long> {

}
