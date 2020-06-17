package kr.codesquad.issuetracker07.controller;

import kr.codesquad.issuetracker07.domain.Issue;
import kr.codesquad.issuetracker07.domain.User;
import kr.codesquad.issuetracker07.dto.IssueForUpdatingVO;
import kr.codesquad.issuetracker07.dto.IssueVO;
import kr.codesquad.issuetracker07.dto.LabelVO;
import kr.codesquad.issuetracker07.response.IssueListResponse;
import kr.codesquad.issuetracker07.response.IssueResponse;
import kr.codesquad.issuetracker07.service.IssueService;
import kr.codesquad.issuetracker07.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.NoSuchElementException;

@RestController
public class IssueController {

    private final IssueService issueService;

    private final UserService userService;

    public IssueController(IssueService issueService, UserService userService) {
        this.issueService = issueService;
        this.userService = userService;
    }

    @GetMapping("/issues")
    public ResponseEntity<IssueListResponse> getAllIssueList() {
        List<Issue> issueList = issueService.findAllIssue();
        IssueListResponse issueListResponse = issueService.makeIssueListSummary(issueList);
        return new ResponseEntity<>(issueListResponse, HttpStatus.OK);
    }

    @PostMapping("/issues")
    public ResponseEntity<IssueResponse> makeIssue(@RequestBody IssueVO issueVO) {
        User user = userService.findUserByName("mocha").orElseThrow(NoSuchElementException::new);
        issueService.makeNewIssue(user, issueVO.getTitle(), issueVO.getDescription());
        return new ResponseEntity<>(new IssueResponse(true), HttpStatus.OK);
    }

    @PatchMapping("/issues")
    public ResponseEntity<IssueResponse> closeOrOpenSelectedIssues(@RequestBody @Valid IssueForUpdatingVO issueForUpdatingVO) {
        issueService.closeOrOpenSelectedIssues(issueForUpdatingVO.getIssueIdList(), issueForUpdatingVO.getState());
        return new ResponseEntity<>(new IssueResponse(true), HttpStatus.OK);
    }

    @DeleteMapping("issues/{issueId}")
    public ResponseEntity<IssueResponse> deleteIssue(@PathVariable("issueId") Long issueId) {
        issueService.deleteIssue(issueId);
        return new ResponseEntity<>(new IssueResponse(true), HttpStatus.OK);
    }

    @PostMapping("/issues/{issueId}/labels")
    public ResponseEntity<HttpStatus> makeLabel(@PathVariable("issueId") Long issueId, @RequestBody LabelVO labelVO) {
        User user = userService.findUserByName("mocha").orElseThrow(NoSuchElementException::new);
        Issue issue = issueService.findIssueByIssueId(issueId);

        issueService.makeNewLabel(user, issue, labelVO);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PutMapping("/issues/{issueId}/labels/{labelId}")
    public ResponseEntity<HttpStatus> attachLabelToIssue(@PathVariable("issueId") Long issueId,
                                                         @PathVariable("labelId") Long labelId) {
        issueService.attachLabel(issueId, labelId);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
