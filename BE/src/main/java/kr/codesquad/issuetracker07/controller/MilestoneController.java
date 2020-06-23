package kr.codesquad.issuetracker07.controller;

import kr.codesquad.issuetracker07.dto.MilestoneVO;
import kr.codesquad.issuetracker07.entity.User;
import kr.codesquad.issuetracker07.response.CommonResponse;
import kr.codesquad.issuetracker07.response.MilestoneDetailResponse;
import kr.codesquad.issuetracker07.response.MilestoneListResponse;
import kr.codesquad.issuetracker07.service.JwtService;
import kr.codesquad.issuetracker07.service.MilestoneService;
import kr.codesquad.issuetracker07.service.UserService;
import kr.codesquad.issuetracker07.util.JwtUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/issues/{issueId}/milestones")
public class MilestoneController {

    private final UserService userService;

    private final MilestoneService milestoneService;

    private final JwtService jwtService;

    public MilestoneController(UserService userService, MilestoneService milestoneService, JwtService jwtService) {
        this.userService = userService;
        this.milestoneService = milestoneService;
        this.jwtService = jwtService;
    }

    @PostMapping("")
    public ResponseEntity<CommonResponse> makeNewMilestone(HttpServletRequest request,
                                                           @PathVariable Long issueId,
                                                           @RequestBody MilestoneVO milestoneVO) {
        String jwtToken = JwtUtils.getJwtTokenFromHeader(request);
        String userName = jwtService.getUserNameFromJwtToken(jwtToken);
        User user = userService.findUserByName(userName);
        milestoneService.makeNewMilestone(user, issueId, milestoneVO);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @GetMapping("")
    public ResponseEntity<MilestoneListResponse> getAllMilestoneList(@PathVariable Long issueId) {
        MilestoneListResponse milestoneListResponse = milestoneService.makeMilestoneList(issueId);
        return new ResponseEntity<>(milestoneListResponse, HttpStatus.OK);
    }

    @GetMapping("/{milestoneId}")
    public ResponseEntity<MilestoneDetailResponse> getMilestoneDetail(@PathVariable Long issueId,
                                                                      @PathVariable Long milestoneId) {
        MilestoneDetailResponse milestoneDetailResponse = milestoneService.makeMilestoneDetail(issueId, milestoneId);
        return new ResponseEntity<>(milestoneDetailResponse, HttpStatus.OK);
    }

    @PutMapping("/{milestoneId}")
    public ResponseEntity<CommonResponse> modifyMilestone(HttpServletRequest request,
                                                          @PathVariable Long issueId,
                                                          @PathVariable Long milestoneId,
                                                          @RequestBody MilestoneVO milestoneVO) {
        String jwtToken = JwtUtils.getJwtTokenFromHeader(request);
        String userName = jwtService.getUserNameFromJwtToken(jwtToken);
        User user = userService.findUserByName(userName);
        milestoneService.modifyMilestone(user, issueId, milestoneId, milestoneVO);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }


    @PatchMapping("/{milestoneId}")
    public ResponseEntity<CommonResponse> attachMilestoneToIssue(@PathVariable Long issueId,
                                                                 @PathVariable Long milestoneId) {
        milestoneService.attachMilestone(issueId, milestoneId);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @DeleteMapping("/{milestoneId}")
    public ResponseEntity<CommonResponse> deleteMilestone(@PathVariable Long issueId,
                                                          @PathVariable Long milestoneId) {
        milestoneService.deleteMilestone(issueId, milestoneId);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }
}
