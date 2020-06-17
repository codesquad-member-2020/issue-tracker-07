package kr.codesquad.issuetracker07.controller;

import kr.codesquad.issuetracker07.domain.Issue;
import kr.codesquad.issuetracker07.domain.User;
import kr.codesquad.issuetracker07.dto.LabelVO;
import kr.codesquad.issuetracker07.service.IssueService;
import kr.codesquad.issuetracker07.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.NoSuchElementException;

@RestController
public class LabelController {

    private final UserService userService;

    private final IssueService issueService;

    public LabelController(UserService userService, IssueService issueService) {
        this.userService = userService;
        this.issueService = issueService;
    }

    @PostMapping("/issues/{issueId}/labels")
    public ResponseEntity<HttpStatus> makeLabel(@PathVariable Long issueId, @RequestBody LabelVO labelVO) {
        User user = userService.findUserByName("mocha").orElseThrow(NoSuchElementException::new);
        Issue issue = issueService.findIssueByIssueId(issueId);

        issueService.makeNewLabel(user, issue, labelVO);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PutMapping("/issues/{issueId}/labels/{labelId}")
    public ResponseEntity<HttpStatus> attachLabelToIssue(@PathVariable Long issueId,
                                                         @PathVariable Long labelId) {
        issueService.attachLabel(issueId, labelId);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
