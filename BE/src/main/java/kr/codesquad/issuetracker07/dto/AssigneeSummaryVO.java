package kr.codesquad.issuetracker07.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AssigneeSummaryVO {

    private Long id;

    private String name;

    private String imageUrl;
}
