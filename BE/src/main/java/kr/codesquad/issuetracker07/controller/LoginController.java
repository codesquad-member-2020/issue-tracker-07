package kr.codesquad.issuetracker07.controller;

import kr.codesquad.issuetracker07.domain.AuthProvider;
import kr.codesquad.issuetracker07.domain.User;
import kr.codesquad.issuetracker07.dto.LoginVO;
import kr.codesquad.issuetracker07.service.AuthService;
import kr.codesquad.issuetracker07.service.JwtService;
import kr.codesquad.issuetracker07.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping("/signup")
    public ResponseEntity<HttpStatus> signInNewUser(@RequestBody LoginVO loginVO) {
        if (userService.isExistedUser(loginVO.getId())) {
            return new ResponseEntity<>(HttpStatus.CONFLICT);
        }
        userService.saveUser(userService.makeUser(loginVO.getId(), loginVO.getPassword()), AuthProvider.local);

        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @PostMapping("/login")
    public ResponseEntity<HttpStatus> loginLocal(@RequestBody LoginVO loginVO, HttpServletResponse response) {
        if (userService.isValidIdAndPassword(loginVO.getId(), loginVO.getPassword(), AuthProvider.local)) {
            String jwtToken = jwtService.makeJwtToken(loginVO.getId());
            response.setHeader("Authorization", jwtToken);
            return new ResponseEntity<>(HttpStatus.OK);
        }

        return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
    }

    @GetMapping("/login/github")
    public void loginGithub(HttpServletResponse response) throws IOException {
        response.sendRedirect(authService.createGithubAuthTokenUri());
    }

    @GetMapping("/callback/github")
    public void githubCallback(@RequestParam("code") String code, HttpServletResponse response) throws IOException {
        String githubAccessToken = authService.getGithubAccessToken(code);
        User user = authService.getUserInformationFromToken(githubAccessToken);
        userService.saveUser(user, AuthProvider.github);
        String jwtToken = jwtService.makeJwtToken(user.getName());
        response.sendRedirect("io.issuetracker.app://auth?token=" + jwtToken);
    }
}
