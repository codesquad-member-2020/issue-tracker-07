package kr.codesquad.issuetracker07.service;

import kr.codesquad.issuetracker07.dto.LabelVO;
import kr.codesquad.issuetracker07.entity.Attachment;
import kr.codesquad.issuetracker07.entity.Issue;
import kr.codesquad.issuetracker07.entity.Label;
import kr.codesquad.issuetracker07.entity.User;
import kr.codesquad.issuetracker07.repository.AttachmentRepository;
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

    private final AttachmentRepository attachmentRepository;

    private final IssueRepository issueRepository;

    public LabelService(LabelRepository labelRepository,
                        AttachmentRepository attachmentRepository,
                        IssueRepository issueRepository) {
        this.labelRepository = labelRepository;
        this.attachmentRepository = attachmentRepository;
        this.issueRepository = issueRepository;
    }


    public void makeNewLabel(User user, Long issueId, LabelVO labelVO) {
        Issue issue = issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);
        Label label = new Label().builder()
                                 .title(labelVO.getTitle())
                                 .description(labelVO.getDescription())
                                 .backgroundColor(labelVO.getBackgroundColor())
                                 .createdBy(user.getName())
                                 .createdAt(LocalDateTime.now())
                                 .modifiedBy(user.getName())
                                 .modifiedAt(LocalDateTime.now())
                                 .build();
        labelRepository.save(label);
        Attachment attachment = new Attachment().builder()
                                                .issue(issue)
                                                .label(label)
                                                .isAttached(false)
                                                .build();
        attachmentRepository.save(attachment);
    }

    public LabelListResponse makeLabelList(Long issueId) {
        Issue issue = issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);
        List<Label> labelList = issue.getAttachmentList().stream()
                                                         .map(Attachment::getLabel)
                                                         .collect(Collectors.toList());
        return new LabelListResponse().builder()
                                      .status(true)
                                      .label(labelList)
                                      .build();
    }

    public LabelDetailResponse makeLabelDetail(Long issueId, Long labelId) {
        Issue issue = issueRepository.findById(issueId).orElseThrow(NoSuchElementException::new);
        Label label = issue.getAttachmentList().stream()
                                               .filter(attachment -> attachment.getLabel().getId().equals(labelId))
                                               .findFirst()
                                               .orElseThrow(NoSuchElementException::new)
                                               .getLabel();
        return new LabelDetailResponse().builder()
                                        .status(true)
                                        .label(label)
                                        .build();
    }

    public void modifyLabel(User user, Long issueId, Long labelId, LabelVO labelVO) {
        Label label = labelRepository.findById(labelId).orElseThrow(NoSuchElementException::new);
        Attachment attachment = attachmentRepository.findByIssue_IdAndLabel_Id(issueId, labelId)
                                                    .orElseThrow(NoSuchElementException::new);
        update(label, attachment, labelVO, user.getName());
    }

    public void attachLabel(Long issueId, Long labelId) {
        Attachment attachment = attachmentRepository.findByIssue_IdAndLabel_Id(issueId, labelId)
                                                    .orElseThrow(NoSuchElementException::new);
        attachment.setAttached(true);
        attachmentRepository.save(attachment);
    }

    public void deleteLabel(Long issueId, Long labelId) {
        Label label = labelRepository.findById(labelId).orElseThrow(NoSuchElementException::new);
        Attachment attachment = attachmentRepository.findByIssue_IdAndLabel_Id(issueId, labelId).orElseThrow(NoSuchElementException::new);
        attachmentRepository.delete(attachment);
        labelRepository.delete(label);
    }

    private void update(Label label, Attachment attachment, LabelVO labelVO, String userName) {
        label.setTitle(labelVO.getTitle());
        label.setDescription(labelVO.getDescription());
        label.setBackgroundColor(labelVO.getBackgroundColor());
        label.setModifiedBy(userName);
        label.setModifiedAt(LocalDateTime.now());
        labelRepository.save(label);
        attachment.setLabel(label);
        attachmentRepository.save(attachment);
    }
}
