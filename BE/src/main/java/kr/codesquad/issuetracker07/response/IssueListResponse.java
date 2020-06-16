package kr.codesquad.issuetracker07.response;

import kr.codesquad.issuetracker07.dto.IssueSummaryVO;
import lombok.*;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class IssueListResponse {

    private boolean status;

    private List<IssueSummaryVO> issue;

}
