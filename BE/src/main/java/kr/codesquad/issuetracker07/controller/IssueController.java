package kr.codesquad.issuetracker07.controller;

import kr.codesquad.issuetracker07.entity.Issue;
import kr.codesquad.issuetracker07.entity.User;
import kr.codesquad.issuetracker07.dto.IssueForUpdatingVO;
import kr.codesquad.issuetracker07.dto.IssueRequestVO;
import kr.codesquad.issuetracker07.response.CommonResponse;
import kr.codesquad.issuetracker07.response.IssueListResponse;
import kr.codesquad.issuetracker07.response.IssueResponse;
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
public class IssueController {

    private final IssueService issueService;

    private final UserService userService;

    private final JwtService jwtService;

    public IssueController(IssueService issueService, UserService userService, JwtService jwtService) {
        this.issueService = issueService;
        this.userService = userService;
        this.jwtService = jwtService;
    }

    @PostMapping("/issues")
    public ResponseEntity<CommonResponse> makeIssue(HttpServletRequest request,
                                                    @RequestBody IssueRequestVO issueRequestVO) {
        String jwtToken = JwtUtils.getJwtTokenFromHeader(request);
        String userName = jwtService.getUserNameFromJwtToken(jwtToken);
        User user = userService.findUserByName(userName);
        issueService.makeNewIssue(user, issueRequestVO.getTitle(), issueRequestVO.getDescription());
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @GetMapping("/issues")
    public ResponseEntity<IssueListResponse> getAllIssueList() {
        List<Issue> issueList = issueService.findAllIssue();
        IssueListResponse issueListResponse = issueService.makeIssueListSummary(issueList);
        return new ResponseEntity<>(issueListResponse, HttpStatus.OK);
    }

    @GetMapping("/issues/{issueId}")
    public ResponseEntity<IssueResponse> getAllIssueList(@PathVariable Long issueId) {
        Issue issue = issueService.findIssueByIssueId(issueId);
        IssueResponse issueResponse = issueService.makeIssueResponse(issue);
        return new ResponseEntity<>(issueResponse, HttpStatus.OK);
    }

    @PutMapping("/issues/{issueId}")
    public ResponseEntity<CommonResponse> modifyIssue(HttpServletRequest request,
                                                      @PathVariable Long issueId,
                                                      @RequestBody IssueRequestVO issueRequestVO) {
        String jwtToken = JwtUtils.getJwtTokenFromHeader(request);
        String userName = jwtService.getUserNameFromJwtToken(jwtToken);
        User user = userService.findUserByName(userName);
        issueService.modifyIssue(user, issueId, issueRequestVO);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @PatchMapping("/issues")
    public ResponseEntity<CommonResponse> closeOrOpenSelectedIssues(@RequestBody @Valid IssueForUpdatingVO issueForUpdatingVO) {
        issueService.closeOrOpenSelectedIssues(issueForUpdatingVO.getIssueIdList(), issueForUpdatingVO.getState());
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @DeleteMapping("issues/{issueId}")
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
}
