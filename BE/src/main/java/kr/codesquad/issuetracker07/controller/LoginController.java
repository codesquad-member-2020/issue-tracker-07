package kr.codesquad.issuetracker07.controller;

import kr.codesquad.issuetracker07.constant.UriConstants;
import kr.codesquad.issuetracker07.domain.AuthProvider;
import kr.codesquad.issuetracker07.domain.User;
import kr.codesquad.issuetracker07.dto.LoginVO;
import kr.codesquad.issuetracker07.response.LoginResponse;
import kr.codesquad.issuetracker07.response.SignUpResponse;
import kr.codesquad.issuetracker07.service.AuthService;
import kr.codesquad.issuetracker07.service.JwtService;
import kr.codesquad.issuetracker07.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@RestController
public class LoginController {

    private final AuthService authService;

    private final UserService userService;

    private final JwtService jwtService;

    public LoginController(AuthService authService, UserService userService, JwtService jwtService) {
        this.authService = authService;
        this.userService = userService;
        this.jwtService = jwtService;
    }

    @PostMapping("/signup")
    public ResponseEntity<SignUpResponse> signInNewUser(@RequestBody LoginVO loginVO) {
        if (userService.isExistedUser(loginVO.getId())) {
            return new ResponseEntity<>(new SignUpResponse(false), HttpStatus.OK);
        }
        userService.saveUser(userService.makeUser(loginVO.getId(), loginVO.getName(), loginVO.getPassword(), UriConstants.GithubImageUrl, AuthProvider.local));
        return new ResponseEntity<>(new SignUpResponse(true), HttpStatus.OK);
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponse> loginLocal(@RequestBody LoginVO loginVO) {
        if (userService.isValidIdAndPassword(loginVO.getId(), loginVO.getPassword(), AuthProvider.local)) {
            User user = userService.findUserByLoginId(loginVO.getId());
            return new ResponseEntity<>(new LoginResponse(true, jwtService.makeJwtToken(loginVO.getId(), user.getName())), HttpStatus.OK);
        }
        return new ResponseEntity<>(new LoginResponse(false, ""), HttpStatus.OK);
    }

    @PostMapping("/login/apple")
    public ResponseEntity<LoginResponse> loginApple(@RequestBody Map<String, String> requestBody) {
        if (!userService.isExistedUser(requestBody.get("id"))) {
            User user = userService.makeUser(requestBody.get("id"), requestBody.get("name"), null, UriConstants.AppleImageUrl, AuthProvider.apple);
            userService.saveUser(user);
            return new ResponseEntity<>(new LoginResponse(true, jwtService.makeJwtToken(requestBody.get("id"), requestBody.get("name"))), HttpStatus.OK);
        }
        return new ResponseEntity<>(new LoginResponse(true, jwtService.makeJwtToken(requestBody.get("id"), requestBody.get("name"))), HttpStatus.OK);
    }

    @GetMapping("/login/github")
    public void loginGithub(HttpServletResponse response) throws IOException {
        response.sendRedirect(authService.createGithubAuthTokenUri());
    }

    @GetMapping("/callback/github")
    public void githubCallback(@RequestParam("code") String code, HttpServletResponse response) throws IOException {
        String githubAccessToken = authService.getGithubAccessToken(code);
        User user = authService.getUserInformationFromToken(githubAccessToken);
        userService.saveUser(user);
        String jwtToken = jwtService.makeJwtToken(user.getLoginId(), user.getName());
        response.sendRedirect(UriConstants.AppleSchemeUrl + jwtToken);
    }
}
