package kr.codesquad.issuetracker07.repository;

import kr.codesquad.issuetracker07.entity.Label;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LabelRepository extends JpaRepository<Label, Long> {

}
