package kr.codesquad.issuetracker07.service;

import kr.codesquad.issuetracker07.dto.LabelVO;
import kr.codesquad.issuetracker07.entity.AttachmentLabel;
import kr.codesquad.issuetracker07.entity.Issue;
import kr.codesquad.issuetracker07.entity.Label;
import kr.codesquad.issuetracker07.entity.User;
import kr.codesquad.issuetracker07.repository.AttachmentLabelRepository;
import kr.codesquad.issuetracker07.repository.IssueRepository;
import kr.codesquad.issuetracker07.repository.LabelRepository;
import kr.codesquad.issuetracker07.response.LabelDetailResponse;
import kr.codesquad.issuetracker07.response.LabelListResponse;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Service
public class LabelService {

    private final LabelRepository labelRepository;

    private final AttachmentLabelRepository attachmentLabelRepository;

    private final IssueRepository issueRepository;

    public LabelService(LabelRepository labelRepository,
                        AttachmentLabelRepository attachmentLabelRepository,
                        IssueRepository issueRepository) {
        this.labelRepository = labelRepository;
        this.attachmentLabelRepository = attachmentLabelRepository;
        this.issueRepository = issueRepository;
    }


    public void makeNewLabel(User user, Long issueId, LabelVO labelVO) {
        Issue issue = issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);
        Label label = Label.builder()
                           .title(labelVO.getTitle())
                           .description(labelVO.getDescription())
                           .backgroundColor(labelVO.getBackgroundColor())
                           .createdBy(user.getName())
                           .createdAt(LocalDateTime.now())
                           .modifiedBy(user.getName())
                           .modifiedAt(LocalDateTime.now())
                           .build();
        labelRepository.save(label);
        AttachmentLabel attachmentLabel = AttachmentLabel.builder()
                                                         .issue(issue)
                                                         .label(label)
                                                         .isAttached(false)
                                                         .build();
        attachmentLabelRepository.save(attachmentLabel);
    }

    public LabelListResponse makeLabelList(Long issueId) {
        Issue issue = issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);
        List<Label> labelList = issue.getAttachmentLabelList().stream()
                                                              .map(AttachmentLabel::getLabel)
                                                              .collect(Collectors.toList());
        return LabelListResponse.builder()
                                .status(true)
                                .label(labelList)
                                .build();
    }

    public LabelDetailResponse makeLabelDetail(Long issueId, Long labelId) {
        Issue issue = issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);
        Label label = issue.getAttachmentLabelList().stream()
                                                    .filter(attachmentLabel -> attachmentLabel.getLabel().getId().equals(labelId))
                                                    .findFirst()
                                                    .orElseThrow(NoSuchElementException::new)
                                                    .getLabel();
        return LabelDetailResponse.builder()
                                  .status(true)
                                  .label(label)
                                  .build();
    }

    public void modifyLabel(User user, Long issueId, Long labelId, LabelVO labelVO) {
        Label label = labelRepository.findById(labelId).orElseThrow(NoSuchElementException::new);
        AttachmentLabel attachmentLabel = attachmentLabelRepository.findByIssueIdAndLabelId(issueId, labelId);
        update(label, attachmentLabel, labelVO, user.getName());
    }

    public void attachLabel(Long issueId, Long labelId) {
        AttachmentLabel attachmentLabel = attachmentLabelRepository.findByIssueIdAndLabelId(issueId, labelId);
        attachmentLabel.setAttached(true);
        attachmentLabelRepository.save(attachmentLabel);
    }

    public void deleteLabel(Long issueId, Long labelId) {
        Label label = labelRepository.findById(labelId).orElseThrow(NoSuchElementException::new);
        AttachmentLabel attachmentLabel = attachmentLabelRepository.findByIssueIdAndLabelId(issueId, labelId);
        attachmentLabelRepository.delete(attachmentLabel);
        labelRepository.delete(label);
    }

    private void update(Label label, AttachmentLabel attachmentLabel, LabelVO labelVO, String userName) {
        label.setTitle(labelVO.getTitle());
        label.setDescription(labelVO.getDescription());
        label.setBackgroundColor(labelVO.getBackgroundColor());
        label.setModifiedBy(userName);
        label.setModifiedAt(LocalDateTime.now());
        labelRepository.save(label);
        attachmentLabel.setLabel(label);
        attachmentLabelRepository.save(attachmentLabel);
    }
}
