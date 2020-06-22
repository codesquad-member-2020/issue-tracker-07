package kr.codesquad.issuetracker07.controller;

import kr.codesquad.issuetracker07.domain.Issue;
import kr.codesquad.issuetracker07.domain.User;
import kr.codesquad.issuetracker07.dto.LabelVO;
import kr.codesquad.issuetracker07.response.CommonResponse;
import kr.codesquad.issuetracker07.service.IssueService;
import kr.codesquad.issuetracker07.service.JwtService;
import kr.codesquad.issuetracker07.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.NoSuchElementException;

@RestController
public class LabelController {

    private final UserService userService;

    private final IssueService issueService;

    private final JwtService jwtService;

    public LabelController(UserService userService, IssueService issueService, JwtService jwtService) {
        this.userService = userService;
        this.issueService = issueService;
        this.jwtService = jwtService;
    }

    @PostMapping("/issues/{issueId}/labels")
    public ResponseEntity<CommonResponse> makeLabel(HttpServletRequest request,
                                                    @PathVariable Long issueId,
                                                    @RequestBody LabelVO labelVO) {
        String jwtToken = request.getHeader("Authorization").replace("Bearer ", "");
        String userName = jwtService.getUserNameFromJwtToken(jwtToken);
        User user = userService.findUserByName(userName).orElseThrow(NoSuchElementException::new);
        Issue issue = issueService.findIssueByIssueId(issueId);

        issueService.makeNewLabel(user, issue, labelVO);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @PutMapping("/issues/{issueId}/labels/{labelId}")
    public ResponseEntity<CommonResponse> attachLabelToIssue(@PathVariable Long issueId,
                                                             @PathVariable Long labelId) {
        issueService.attachLabel(issueId, labelId);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @DeleteMapping("/issues/{issueId}/labels/{labelId}")
    public ResponseEntity<CommonResponse> deleteLabel(@PathVariable Long issueId,
                                                      @PathVariable Long labelId) {
        issueService.deleteLabel(issueId, labelId);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }
}
