package kr.codesquad.issuetracker07.dto;

import lombok.*;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Builder
public class IssueVO {

    private Long id;

    private String title;

    private String authorName;

    private String imageUrl;

    @Getter(AccessLevel.NONE)
    private boolean isOpen;

    private String createdAt;

    private List<CommentSummaryVO> comment;

    private List<MilestoneSummaryVO> milestone;

    private List<LabelSummaryVO> label;

    private List<AssigneeSummaryVO> assignee;

    public boolean getIsOpen() {
        return isOpen;
    }
}
