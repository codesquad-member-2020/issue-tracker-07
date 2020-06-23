package kr.codesquad.issuetracker07.response;

import kr.codesquad.issuetracker07.entity.Label;
import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class LabelDetailResponse {

    private boolean status;

    private Label label;
}
