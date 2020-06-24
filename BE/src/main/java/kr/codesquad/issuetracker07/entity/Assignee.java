package kr.codesquad.issuetracker07.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Assignee {

    @Id
    private Long id;

    private String name;

    private String imageUrl;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "issue_id")
    private Issue issue;
}
