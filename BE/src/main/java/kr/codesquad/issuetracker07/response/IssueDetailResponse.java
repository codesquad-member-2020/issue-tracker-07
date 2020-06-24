package kr.codesquad.issuetracker07.response;

import kr.codesquad.issuetracker07.dto.AssigneeSummaryVO;
import kr.codesquad.issuetracker07.dto.CommentSummaryVO;
import kr.codesquad.issuetracker07.dto.LabelSummaryVO;
import kr.codesquad.issuetracker07.dto.MilestoneSummaryVO;
import lombok.*;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Builder
public class IssueDetailResponse {

    private boolean status;

    private Long id;

    private String title;

    @Getter(AccessLevel.NONE)
    private boolean isOpen;

    private List<CommentSummaryVO> comment;

    private List<MilestoneSummaryVO> milestone;

    private List<LabelSummaryVO> label;

    private List<AssigneeSummaryVO> assignee;

    public boolean getIsOpen() {
        return isOpen;
    }
}
