package kr.codesquad.issuetracker07.domain;

import lombok.*;

import javax.persistence.*;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Label {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    private String description;

    private String backgroundColor;

    @OneToMany(mappedBy = "label")
    List<Attachment> attachmentList;
}
