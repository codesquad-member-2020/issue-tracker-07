package kr.codesquad.issuetracker07.controller;

import kr.codesquad.issuetracker07.dto.CommentVO;
import kr.codesquad.issuetracker07.response.IssueDetailResponse;
import kr.codesquad.issuetracker07.entity.Issue;
import kr.codesquad.issuetracker07.entity.User;
import kr.codesquad.issuetracker07.dto.IssueForUpdatingVO;
import kr.codesquad.issuetracker07.dto.IssueRequestVO;
import kr.codesquad.issuetracker07.response.CommonResponse;
import kr.codesquad.issuetracker07.response.IssueListResponse;
import kr.codesquad.issuetracker07.service.IssueService;
import kr.codesquad.issuetracker07.service.JwtService;
import kr.codesquad.issuetracker07.service.UserService;
import kr.codesquad.issuetracker07.util.JwtUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/issues")
public class IssueController {

    private final IssueService issueService;

    private final UserService userService;

    private final JwtService jwtService;

    public IssueController(IssueService issueService, UserService userService, JwtService jwtService) {
        this.issueService = issueService;
        this.userService = userService;
        this.jwtService = jwtService;
    }

    @PostMapping("")
    public ResponseEntity<CommonResponse> makeNewIssue(HttpServletRequest request,
                                                    @RequestBody IssueRequestVO issueRequestVO) {
        String jwtToken = JwtUtils.getJwtTokenFromHeader(request);
        String userName = jwtService.getUserNameFromJwtToken(jwtToken);
        User user = userService.findUserByName(userName);
        issueService.makeNewIssue(user, issueRequestVO.getTitle(), issueRequestVO.getDescription());
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @GetMapping("")
    public ResponseEntity<IssueListResponse> getAllIssueList() {
        List<Issue> issueList = issueService.findAllIssue();
        IssueListResponse issueListResponse = issueService.makeIssueList(issueList);
        return new ResponseEntity<>(issueListResponse, HttpStatus.OK);
    }

    @GetMapping("/{issueId}")
    public ResponseEntity<IssueDetailResponse> getIssueDetail(@PathVariable Long issueId) {
        Issue issue = issueService.findIssueByIssueId(issueId);
        IssueDetailResponse issueDetailResponse = issueService.makeIssueDetail(issue);
        return new ResponseEntity<>(issueDetailResponse, HttpStatus.OK);
    }

    @PutMapping("/{issueId}")
    public ResponseEntity<CommonResponse> modifyIssue(HttpServletRequest request,
                                                      @PathVariable Long issueId,
                                                      @RequestBody IssueRequestVO issueRequestVO) {
        String jwtToken = JwtUtils.getJwtTokenFromHeader(request);
        String userName = jwtService.getUserNameFromJwtToken(jwtToken);
        User user = userService.findUserByName(userName);
        issueService.modifyIssue(user, issueId, issueRequestVO);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @PatchMapping("")
    public ResponseEntity<CommonResponse> closeOrOpenSelectedIssues(@RequestBody @Valid IssueForUpdatingVO issueForUpdatingVO) {
        issueService.closeOrOpenSelectedIssues(issueForUpdatingVO.getIssueIdList(), issueForUpdatingVO.getState());
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @PatchMapping("/{issueId}/labels/{labelId}")
    public ResponseEntity<CommonResponse> attachLabelToIssue(@PathVariable Long issueId,
                                                             @PathVariable Long labelId) {
        issueService.attachLabel(issueId, labelId);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @PatchMapping("/{issueId}/milestones/{milestoneId}")
    public ResponseEntity<CommonResponse> attachMilestoneToIssue(@PathVariable Long issueId,
                                                                 @PathVariable Long milestoneId) {
        issueService.attachMilestone(issueId, milestoneId);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @PatchMapping("/{issueId}/assignees/{assigneeId}")
    public ResponseEntity<CommonResponse> assignAssigneeToIssue(@PathVariable Long issueId,
                                                                 @PathVariable Long assigneeId) {
        User user = userService.findUserById(assigneeId);
        issueService.assignAssignee(user, issueId);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @DeleteMapping("/{issueId}")
    public ResponseEntity<CommonResponse> deleteIssue(HttpServletRequest request,
                                                      @PathVariable Long issueId) {
        String jwtToken = JwtUtils.getJwtTokenFromHeader(request);
        String userName = jwtService.getUserNameFromJwtToken(jwtToken);
        User user = userService.findUserByName(userName);
        log.info("{}", userName);
        if (issueService.deleteIssue(user, issueId)) {
            return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
        }
        return new ResponseEntity<>(new CommonResponse(false), HttpStatus.OK);
    }

    @PostMapping("/{issueId}/comments")
    public ResponseEntity<CommonResponse> makeComment(HttpServletRequest request,
                                                      @PathVariable Long issueId,
                                                      @RequestBody CommentVO commentVO) {
        String jwtToken = JwtUtils.getJwtTokenFromHeader(request);
        String userName = jwtService.getUserNameFromJwtToken(jwtToken);
        User user = userService.findUserByName(userName);
        issueService.makeNewComment(user, issueId, commentVO);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }
}
