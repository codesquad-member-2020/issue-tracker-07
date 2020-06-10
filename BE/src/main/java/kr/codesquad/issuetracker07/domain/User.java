package kr.codesquad.issuetracker07.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Id;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {

    @Id
    @JsonProperty("login")
    private String name;

    @JsonProperty("avatar_url")
    private String avatarUrl;

    private String password;

    @Enumerated(EnumType.STRING)
    @NonNull
    private AuthProvider authProvider;
}
