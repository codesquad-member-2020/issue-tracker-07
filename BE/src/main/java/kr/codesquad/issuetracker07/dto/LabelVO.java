package kr.codesquad.issuetracker07.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class LabelVO {

    private String title;

    private String description;

    private String backgroundColor;
}
