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
@RequestMapping("/milestones")
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
                                                           @RequestBody MilestoneVO milestoneVO) {
        String jwtToken = JwtUtils.getJwtTokenFromHeader(request);
        String userName = jwtService.getUserNameFromJwtToken(jwtToken);
        User user = userService.findUserByName(userName);
        milestoneService.makeNewMilestone(user, milestoneVO);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @GetMapping("")
    public ResponseEntity<MilestoneListResponse> getAllMilestoneList() {
        MilestoneListResponse milestoneListResponse = milestoneService.makeMilestoneList();
        return new ResponseEntity<>(milestoneListResponse, HttpStatus.OK);
    }

    @GetMapping("/{milestoneId}")
    public ResponseEntity<MilestoneDetailResponse> getMilestoneDetail(@PathVariable Long milestoneId) {
        MilestoneDetailResponse milestoneDetailResponse = milestoneService.makeMilestoneDetail(milestoneId);
        return new ResponseEntity<>(milestoneDetailResponse, HttpStatus.OK);
    }

    @PutMapping("/{milestoneId}")
    public ResponseEntity<CommonResponse> modifyMilestone(HttpServletRequest request,
                                                          @PathVariable Long milestoneId,
                                                          @RequestBody MilestoneVO milestoneVO) {
        String jwtToken = JwtUtils.getJwtTokenFromHeader(request);
        String userName = jwtService.getUserNameFromJwtToken(jwtToken);
        User user = userService.findUserByName(userName);
        milestoneService.modifyMilestone(user, milestoneId, milestoneVO);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @DeleteMapping("/{milestoneId}")
    public ResponseEntity<CommonResponse> deleteMilestone(@PathVariable Long milestoneId) {
        milestoneService.deleteMilestone(milestoneId);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }
}
