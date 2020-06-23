package kr.codesquad.issuetracker07.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MilestoneDetailVO {

    private Long id;

    private String title;

    private String description;

    private LocalDate dueDate;

    private int progress;

    private int openedIssueCount;

    private int closedIssueCount;
}
