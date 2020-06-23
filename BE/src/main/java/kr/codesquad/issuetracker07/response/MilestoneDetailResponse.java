package kr.codesquad.issuetracker07.response;

import kr.codesquad.issuetracker07.entity.Milestone;
import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class MilestoneDetailResponse {

    private boolean status;

    private Milestone milestone;
}
