package kr.codesquad.issuetracker07.controller;

import kr.codesquad.issuetracker07.response.AssigneeListResponse;
import kr.codesquad.issuetracker07.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/assignees")
public class AssigneeController {

    private final UserService userService;

    public AssigneeController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("")
    public ResponseEntity<AssigneeListResponse> getAllAssigneeList() {
        AssigneeListResponse assigneeListResponse = userService.makeAssigneeList();
        return new ResponseEntity<>(assigneeListResponse, HttpStatus.OK);
    }
}
