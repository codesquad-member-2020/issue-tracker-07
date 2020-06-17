package kr.codesquad.issuetracker07.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Builder
public class IssueSummaryVO {

    private Long id;

    private String title;

    private String description;

    private boolean isOpen;

    private String createdAt;

    private List<MilestoneSummaryVO> milestone;

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

    public String getCreatedAt() {
        return createdAt;
    }

    public List<MilestoneSummaryVO> getMilestone() {
        return milestone;
    }

    public List<LabelSummaryVO> getLabel() {
        return label;
    }
}
