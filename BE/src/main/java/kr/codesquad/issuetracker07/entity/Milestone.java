package kr.codesquad.issuetracker07.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
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

    private String createdBy;

    private LocalDateTime createdAt;

    private String modifiedBy;

    private LocalDateTime modifiedAt;

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
