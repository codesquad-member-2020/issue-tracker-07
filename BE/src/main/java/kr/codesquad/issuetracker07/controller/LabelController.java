package kr.codesquad.issuetracker07.controller;

import kr.codesquad.issuetracker07.dto.LabelVO;
import kr.codesquad.issuetracker07.entity.User;
import kr.codesquad.issuetracker07.response.CommonResponse;
import kr.codesquad.issuetracker07.response.LabelDetailResponse;
import kr.codesquad.issuetracker07.response.LabelListResponse;
import kr.codesquad.issuetracker07.service.JwtService;
import kr.codesquad.issuetracker07.service.LabelService;
import kr.codesquad.issuetracker07.service.UserService;
import kr.codesquad.issuetracker07.util.JwtUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/issues/{issueId}/labels")
public class LabelController {

    private final UserService userService;

    private final LabelService labelService;

    private final JwtService jwtService;

    public LabelController(UserService userService,
                           LabelService labelService,
                           JwtService jwtService) {
        this.userService = userService;
        this.labelService = labelService;
        this.jwtService = jwtService;
    }

    @PostMapping("")
    public ResponseEntity<CommonResponse> makeLabel(HttpServletRequest request,
                                                    @PathVariable Long issueId,
                                                    @RequestBody LabelVO labelVO) {
        String jwtToken = JwtUtils.getJwtTokenFromHeader(request);
        String userName = jwtService.getUserNameFromJwtToken(jwtToken);
        User user = userService.findUserByName(userName);
        labelService.makeNewLabel(user, issueId, labelVO);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @GetMapping("")
    public ResponseEntity<LabelListResponse> getAllLabelList(@PathVariable Long issueId) {
        LabelListResponse labelListResponse = labelService.makeLabelList(issueId);
        return new ResponseEntity<>(labelListResponse, HttpStatus.OK);
    }

    @GetMapping("/{labelId}")
    public ResponseEntity<LabelDetailResponse> getLabelDetail(@PathVariable Long issueId,
                                                               @PathVariable Long labelId) {
        LabelDetailResponse labelDetailResponse = labelService.makeLabelDetail(issueId, labelId);
        return new ResponseEntity<>(labelDetailResponse, HttpStatus.OK);
    }

    @PutMapping("/{labelId}")
    public ResponseEntity<CommonResponse> modifyLabel(HttpServletRequest request,
                                                      @PathVariable Long issueId,
                                                      @PathVariable Long labelId,
                                                      @RequestBody LabelVO labelVO) {
        String jwtToken = JwtUtils.getJwtTokenFromHeader(request);
        String userName = jwtService.getUserNameFromJwtToken(jwtToken);
        User user = userService.findUserByName(userName);
        labelService.modifyLabel(user, issueId, labelId, labelVO);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @PatchMapping("/{labelId}")
    public ResponseEntity<CommonResponse> attachLabelToIssue(@PathVariable Long issueId,
                                                             @PathVariable Long labelId) {
        labelService.attachLabel(issueId, labelId);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @DeleteMapping("/{labelId}")
    public ResponseEntity<CommonResponse> deleteLabel(@PathVariable Long issueId,
                                                      @PathVariable Long labelId) {
        labelService.deleteLabel(issueId, labelId);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }
}
