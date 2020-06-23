package kr.codesquad.issuetracker07.response;

import kr.codesquad.issuetracker07.dto.MilestoneDetailVO;
import lombok.*;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class MilestoneListResponse {

    private boolean status;

    private List<MilestoneDetailVO> milestone;
}
