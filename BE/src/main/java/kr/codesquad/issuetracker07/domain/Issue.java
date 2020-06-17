package kr.codesquad.issuetracker07.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Issue {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    private String description;

    private boolean isOpen;

    private LocalDateTime createdAt;

    private LocalDateTime modifiedAt;

    @ManyToOne
    private Milestone milestone;

    @OneToMany(mappedBy = "issue")
    private List<Comment> commentList;

    @OneToMany(mappedBy = "issue")
    private List<Attachment> attachmentList;

    @OneToMany(mappedBy = "issue")
    private List<Assignee> assigneeList;

    @ManyToOne
    @JsonIgnore
    private User user;
}
