package kr.codesquad.issuetracker07.controller;

import kr.codesquad.issuetracker07.entity.Issue;
import kr.codesquad.issuetracker07.entity.Milestone;
import kr.codesquad.issuetracker07.dto.MilestoneVO;
import kr.codesquad.issuetracker07.response.MilestoneResponse;
import kr.codesquad.issuetracker07.service.IssueService;
import kr.codesquad.issuetracker07.service.MilestoneService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
public class MilestoneController {

    private final IssueService issueService;

    private final MilestoneService milestoneService;

    public MilestoneController(IssueService issueService, MilestoneService milestoneService) {
        this.issueService =issueService;
        this.milestoneService = milestoneService;
    }

    @PostMapping("/issues/{issueId}/milestone")
    public ResponseEntity<MilestoneResponse> makeNewMilestone(@PathVariable Long issueId, @RequestBody MilestoneVO milestoneVO) {
        Issue issue = issueService.findIssueByIssueId(issueId);
        milestoneService.makeNewMilestone(issue, milestoneVO);
        return new ResponseEntity<>(new MilestoneResponse(true), HttpStatus.OK);
    }

    @PutMapping("/issues/{issueId}/milestone/{milestoneId}")
    public ResponseEntity<MilestoneResponse> attachMilestoneToIssue(@PathVariable Long issueId,
                                                                    @PathVariable Long milestoneId) {
        Issue issue = issueService.findIssueByIssueId(issueId);
        Milestone milestone = milestoneService.findMilestoneByMilestoneId(milestoneId);
        milestoneService.attachMilestone(issue, milestone);
        return new ResponseEntity<>(new MilestoneResponse(true), HttpStatus.OK);
    }
}
