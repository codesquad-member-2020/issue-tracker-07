package kr.codesquad.issuetracker07.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class IssueRequestVO {

    private String title;

    private String description;
}
