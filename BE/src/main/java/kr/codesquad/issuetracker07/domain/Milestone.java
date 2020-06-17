package kr.codesquad.issuetracker07.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Milestone {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    private LocalDate dueDate;

    private String description;

    private boolean isAttached;

    @OneToMany(mappedBy = "milestone")
    @JsonIgnore
    @Builder.Default
    private List<Issue> issue = new ArrayList<>();

    public void addIssue(Issue issue) {
        issue.setMilestone(this);
        getIssue().add(issue);
    }

    public void modifyIssue(Issue issue) {
        issue.setMilestone(this);
        getIssue().get(this.getIssue().indexOf(issue)).setMilestone(this);
    }
}
