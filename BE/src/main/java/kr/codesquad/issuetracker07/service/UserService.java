package kr.codesquad.issuetracker07.service;

import kr.codesquad.issuetracker07.dto.AssigneeSummaryVO;
import kr.codesquad.issuetracker07.entity.Assignee;
import kr.codesquad.issuetracker07.entity.AuthProvider;
import kr.codesquad.issuetracker07.entity.User;
import kr.codesquad.issuetracker07.repository.UserRepository;
import kr.codesquad.issuetracker07.response.AssigneeListResponse;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public void saveUser(User user) {
        userRepository.save(user);
    }

    public User makeUser(String id, String name, String password, String imageUrl, AuthProvider authProvider) {
        return User.builder()
                   .name(name)
                   .loginId(id)
                   .password(password)
                   .imageUrl(imageUrl)
                   .authProvider(authProvider)
                   .build();
    }

    public boolean isExistedUser(String id) {
        return userRepository.findByLoginId(id).isPresent();
    }

    public boolean isValidIdAndPassword(String id, String password, AuthProvider authProvider) {
        return userRepository.findByLoginIdAndAuthProvider(id, authProvider)
                             .filter(user -> password.equals(user.getPassword()))
                             .isPresent();
    }

    public User findUserByName(String userName) {
        return userRepository.findByName(userName).orElseThrow(NoSuchElementException::new);
    }

    public User findUserByLoginId(String loginId) {
        return userRepository.findByLoginId(loginId).orElseThrow(NoSuchElementException::new);
    }

    public AssigneeListResponse makeAssigneeList() {
        List<User> userList = userRepository.findAll();
        List<AssigneeSummaryVO> assigneeSummaryVOList = userList.stream()
                                                                .map(user -> AssigneeSummaryVO.builder()
                                                                                              .id(user.getId())
                                                                                              .name(user.getName())
                                                                                              .imageUrl(user.getImageUrl())
                                                                                              .build())
                                                                .collect(Collectors.toList());
        return AssigneeListResponse.builder()
                .status(true)
                .assignee(assigneeSummaryVOList)
                .build();
    }

    public User findUserById(Long assigneeId) {
        return userRepository.findById(assigneeId).orElseThrow(NoSuchElementException::new);
    }
}
