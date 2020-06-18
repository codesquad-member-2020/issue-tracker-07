package kr.codesquad.issuetracker07.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CommentSummaryVO {

    private Long id;

    private String name;

    private String imageUrl;

    private String content;

    private LocalDateTime createdAt;

    private LocalDateTime modifiedAt;

    private List<EmojiSummaryVO> emoji;
}
