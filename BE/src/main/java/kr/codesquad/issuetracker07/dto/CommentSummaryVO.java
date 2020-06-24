package kr.codesquad.issuetracker07.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Builder
public class CommentSummaryVO {

    private Long id;

    private String name;

    private String imageUrl;

    private String content;

    private String createdAt;

    private String modifiedAt;
}
