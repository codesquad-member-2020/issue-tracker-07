package kr.codesquad.issuetracker07.response;

import kr.codesquad.issuetracker07.dto.IssueVO;
import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class IssueResponse {

    private boolean status;

    private IssueVO issue;
}
