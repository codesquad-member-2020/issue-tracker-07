package kr.codesquad.issuetracker07.response;

import kr.codesquad.issuetracker07.dto.AssigneeSummaryVO;
import lombok.*;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class AssigneeListResponse {

    private boolean status;

    private List<AssigneeSummaryVO> assignee;
}
