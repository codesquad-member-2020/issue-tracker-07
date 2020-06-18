package kr.codesquad.issuetracker07.dto;

import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Builder
public class IssueSummaryVO {

    private Long id;

    private String title;

    private String description;

    @Getter(AccessLevel.NONE)
    private boolean isOpen;

    private String createdAt;

    private List<MilestoneSummaryVO> milestone;

    private List<LabelSummaryVO> label;

    public boolean getIsOpen() {
        return isOpen;
    }
}
