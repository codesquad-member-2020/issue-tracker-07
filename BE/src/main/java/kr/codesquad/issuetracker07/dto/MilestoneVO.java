package kr.codesquad.issuetracker07.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Getter
@NoArgsConstructor
public class MilestoneVO {

    private String title;

    private LocalDate dueDate;

    private String description;
}
