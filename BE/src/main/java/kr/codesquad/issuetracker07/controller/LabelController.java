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
@RequestMapping("/labels")
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
                                                    @RequestBody LabelVO labelVO) {
        String jwtToken = JwtUtils.getJwtTokenFromHeader(request);
        String userName = jwtService.getUserNameFromJwtToken(jwtToken);
        User user = userService.findUserByName(userName);
        labelService.makeNewLabel(user, labelVO);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @GetMapping("")
    public ResponseEntity<LabelListResponse> getAllLabelList() {
        LabelListResponse labelListResponse = labelService.makeLabelList();
        return new ResponseEntity<>(labelListResponse, HttpStatus.OK);
    }

    @GetMapping("/{labelId}")
    public ResponseEntity<LabelDetailResponse> getLabelDetail(@PathVariable Long labelId) {
        LabelDetailResponse labelDetailResponse = labelService.makeLabelDetail(labelId);
        return new ResponseEntity<>(labelDetailResponse, HttpStatus.OK);
    }

    @PutMapping("/{labelId}")
    public ResponseEntity<CommonResponse> modifyLabel(HttpServletRequest request,
                                                      @PathVariable Long labelId,
                                                      @RequestBody LabelVO labelVO) {
        String jwtToken = JwtUtils.getJwtTokenFromHeader(request);
        String userName = jwtService.getUserNameFromJwtToken(jwtToken);
        User user = userService.findUserByName(userName);
        labelService.modifyLabel(user, labelId, labelVO);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }

    @DeleteMapping("/{labelId}")
    public ResponseEntity<CommonResponse> deleteLabel(@PathVariable Long labelId) {
        labelService.deleteLabel(labelId);
        return new ResponseEntity<>(new CommonResponse(true), HttpStatus.OK);
    }
}
