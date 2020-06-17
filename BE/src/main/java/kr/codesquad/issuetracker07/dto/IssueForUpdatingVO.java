package kr.codesquad.issuetracker07.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Builder
public class IssueForUpdatingVO {

    @NotEmpty
    private List<Long> issueIdList;

    @NotEmpty
    @NotBlank
    private String state;
}
