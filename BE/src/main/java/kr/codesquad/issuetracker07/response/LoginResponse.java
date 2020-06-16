package kr.codesquad.issuetracker07.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Getter
@Setter
public class LoginResponse {

    private boolean status;

    private String jwtToken;
}
