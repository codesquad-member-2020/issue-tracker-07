package kr.codesquad.issuetracker07.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Data
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

    @JsonIgnore
    private String createdBy;

    @JsonIgnore
    private LocalDateTime createdAt;

    @JsonIgnore
    private String modifiedBy;

    @JsonIgnore
    private LocalDateTime modifiedAt;

    @JsonIgnore
    @OneToMany(mappedBy = "label")
    List<AttachmentLabel> attachmentLabelList;
}
