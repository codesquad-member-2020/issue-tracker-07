package kr.codesquad.issuetracker07.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
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

    @JsonProperty("login")
    private String name;

    @Id
    @JsonProperty("name")
    private String loginId;

    @JsonProperty("avatar_url")
    private String imageUrl;

    private String password;

    @Enumerated(EnumType.STRING)
    @NonNull
    private AuthProvider authProvider;

    @OneToMany(mappedBy = "user")
    @Builder.Default
    private List<Issue> issues = new ArrayList<>();

    public void addIssue(Issue issue) {
        issue.setUser(this);
        getIssues().add(issue);
    }
}
