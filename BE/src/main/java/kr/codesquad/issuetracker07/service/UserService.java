package kr.codesquad.issuetracker07.service;

import kr.codesquad.issuetracker07.domain.User;
import kr.codesquad.issuetracker07.repository.UserRepository;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public void saveUser(User user) {
        userRepository.save(user);
    }
}
