package kr.codesquad.issuetracker07.controller;

import kr.codesquad.issuetracker07.dto.CommentVO;
import kr.codesquad.issuetracker07.entity.User;
import kr.codesquad.issuetracker07.response.CommonResponse;
import kr.codesquad.issuetracker07.service.CommentService;
import kr.codesquad.issuetracker07.service.JwtService;
import kr.codesquad.issuetracker07.service.UserService;
import kr.codesquad.issuetracker07.util.JwtUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/comments")
public class CommentController {

    private final CommentService commentService;

    private final JwtService jwtService;

    private final UserService userService;

    public CommentController(CommentService commentService,
                             JwtService jwtService,
                             UserService userService) {
        this.commentService = commentService;
        this.jwtService = jwtService;
        this.userService = userService;
    }

    @PutMapping("/{commentId}")
    public ResponseEntity<CommonResponse> modifyComment(HttpServletRequest request,
                                                        @PathVariable Long commentId,
                                                        @RequestBody CommentVO commentVO) {
        String jwtToken = JwtUtils.getJwtTokenFromHeader(request);
        String userName = jwtService.getUserNameFromJwtToken(jwtToken);
        User user = userService.findUserByName(userName);
        commentService.modifyComment(user, commentId, commentVO);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @DeleteMapping("/{commentId}")
    public ResponseEntity<CommonResponse> deleteComment(HttpServletRequest request,
                                                        @PathVariable Long commentId) {
        String jwtToken = JwtUtils.getJwtTokenFromHeader(request);
        String userName = jwtService.getUserNameFromJwtToken(jwtToken);
        User user = userService.findUserByName(userName);
        commentService.deleteComment(user, commentId);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }
}
