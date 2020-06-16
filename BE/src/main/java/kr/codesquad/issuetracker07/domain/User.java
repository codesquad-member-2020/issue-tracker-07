package kr.codesquad.issuetracker07.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

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
    private String imageUrl;

    private String password;

    @Enumerated(EnumType.STRING)
    @NonNull
    private AuthProvider authProvider;

    @OneToMany(mappedBy = "user")
    @Builder.Default
    private List<Issue> issues = new ArrayList<>();

    @OneToMany(mappedBy = "user")
    private List<Comment> commentList;

    public void addIssue(Issue issue) {
        issue.setUser(this);
        getIssues().add(issue);
    }
}
