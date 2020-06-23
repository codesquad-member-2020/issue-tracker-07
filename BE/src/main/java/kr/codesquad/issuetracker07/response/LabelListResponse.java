package kr.codesquad.issuetracker07.response;

import kr.codesquad.issuetracker07.entity.Label;
import lombok.*;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class LabelListResponse {

    private boolean status;

    private List<Label> label;
}
