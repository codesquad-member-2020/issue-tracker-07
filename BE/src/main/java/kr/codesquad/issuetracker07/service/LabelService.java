package kr.codesquad.issuetracker07.service;

import kr.codesquad.issuetracker07.dto.LabelVO;
import kr.codesquad.issuetracker07.entity.Label;
import kr.codesquad.issuetracker07.entity.User;
import kr.codesquad.issuetracker07.repository.LabelRepository;
import kr.codesquad.issuetracker07.response.LabelDetailResponse;
import kr.codesquad.issuetracker07.response.LabelListResponse;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.NoSuchElementException;

@Service
public class LabelService {

    private final LabelRepository labelRepository;

    public LabelService(LabelRepository labelRepository) {
        this.labelRepository = labelRepository;
    }


    public void makeNewLabel(User user, LabelVO labelVO) {
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
    }

    public LabelListResponse makeLabelList() {
        List<Label> labelList = labelRepository.findAll();
        return LabelListResponse.builder()
                                .status(true)
                                .label(labelList)
                                .build();
    }

    public LabelDetailResponse makeLabelDetail(Long labelId) {
        Label label = labelRepository.findById(labelId).orElseThrow(NoSuchElementException::new);
        return LabelDetailResponse.builder()
                                  .status(true)
                                  .label(label)
                                  .build();
    }

    public void modifyLabel(User user, Long labelId, LabelVO labelVO) {
        Label label = labelRepository.findById(labelId).orElseThrow(NoSuchElementException::new);
        update(label, labelVO, user.getName());
    }

    public void deleteLabel(Long labelId) {
        Label label = labelRepository.findById(labelId).orElseThrow(NoSuchElementException::new);
        labelRepository.delete(label);
    }

    private void update(Label label,  LabelVO labelVO, String userName) {
        label.setTitle(labelVO.getTitle());
        label.setDescription(labelVO.getDescription());
        label.setBackgroundColor(labelVO.getBackgroundColor());
        label.setModifiedBy(userName);
        label.setModifiedAt(LocalDateTime.now());
        labelRepository.save(label);
    }
}
