package kr.codesquad.issuetracker07.repository;

import kr.codesquad.issuetracker07.entity.Adding;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AddingRepository extends JpaRepository<Adding, Long> {

}
