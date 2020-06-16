package kr.codesquad.issuetracker07.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LabelSummaryVO {

    private Long id;

    private String title;

    private String backgroundColor;
}
