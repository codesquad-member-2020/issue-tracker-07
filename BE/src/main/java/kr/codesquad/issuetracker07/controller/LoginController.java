package kr.codesquad.issuetracker07.controller;

import kr.codesquad.issuetracker07.domain.User;
import kr.codesquad.issuetracker07.service.AuthService;
import kr.codesquad.issuetracker07.service.JwtService;
import kr.codesquad.issuetracker07.service.UserService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@RestController
public class LoginController {

    private final AuthService authService;

    private final JwtService jwtService;

    private final UserService userService;

    public LoginController(AuthService authService, JwtService jwtService, UserService userService) {
        this.authService = authService;
        this.jwtService = jwtService;
        this.userService = userService;
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
        String jwtToken = jwtService.makeJwtToken(user.getEmail());
        response.sendRedirect("io.issuetracker.app://auth?token=" + jwtToken);
    }
}
