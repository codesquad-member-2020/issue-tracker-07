package kr.codesquad.issuetracker07.repository;

import kr.codesquad.issuetracker07.domain.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {

}