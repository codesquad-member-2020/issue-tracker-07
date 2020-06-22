package kr.codesquad.issuetracker07.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class LoginVO {

    private String id;

    private String name;

    private String password;

    private String token;
}
