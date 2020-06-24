package kr.codesquad.issuetracker07.service;

import kr.codesquad.issuetracker07.dto.CommentVO;
import kr.codesquad.issuetracker07.entity.Comment;
import kr.codesquad.issuetracker07.entity.User;
import kr.codesquad.issuetracker07.repository.CommentRepository;
import org.springframework.stereotype.Service;

import java.util.NoSuchElementException;

@Service
public class CommentService {

    private final CommentRepository commentRepository;

    public CommentService(CommentRepository commentRepository) {
        this.commentRepository = commentRepository;
    }

    public void modifyComment(User user, Long commentId, CommentVO commentVO) {
        Comment comment = commentRepository.findById(commentId).orElseThrow(NoSuchElementException::new);
        if (comment.getUser().getName().equals(user.getName())) {
            comment.setContent(commentVO.getContent());
            commentRepository.save(comment);
        }
    }

    public void deleteComment(User user, Long commentId) {
        Comment comment = commentRepository.findById(commentId).orElseThrow(NoSuchElementException::new);
        if (comment.getUser().getName().equals(user.getName())) {
            commentRepository.delete(comment);
        }
    }
}
