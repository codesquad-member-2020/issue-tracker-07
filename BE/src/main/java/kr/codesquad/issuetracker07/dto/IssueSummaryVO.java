package kr.codesquad.issuetracker07.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Builder
public class IssueSummaryVO {

    private Long id;

    private String title;

    private String description;

    private boolean isOpen;

    private LocalDate createdAt;

    private MilestoneSummaryVO milestone;

    private List<LabelSummaryVO> label;

    public Long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public boolean getIsOpen() {
        return isOpen;
    }

    public LocalDate getCreatedAt() {
        return createdAt;
    }

    public MilestoneSummaryVO getMilestone() {
        return milestone;
    }

    public List<LabelSummaryVO> getLabel() {
        return label;
    }
}
