package kr.codesquad.issuetracker07.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Data
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

    private String createdBy;

    private LocalDateTime createdAt;

    private String modifiedBy;

    private LocalDateTime modifiedAt;

    @OneToMany(mappedBy = "issue")
    private List<Comment> commentList;

    @OneToMany(mappedBy = "issue")
    private List<AttachmentLabel> attachmentLabelList;

    @OneToMany(mappedBy = "issue")
    private List<AttachmentMilestone> attachmentMilestoneList;

    @OneToMany(mappedBy = "issue")
    private List<Assignee> assigneeList;

    @ManyToOne
    @JsonIgnore
    private User user;
}
