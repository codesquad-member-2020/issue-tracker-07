package kr.codesquad.issuetracker07.service;

import kr.codesquad.issuetracker07.domain.AuthProvider;
import kr.codesquad.issuetracker07.domain.User;
import kr.codesquad.issuetracker07.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.NoSuchElementException;
import java.util.Optional;

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
        return userRepository.findByName(id).isPresent();
    }

    public boolean isValidIdAndPassword(String id, String password, AuthProvider authProvider) {
        return userRepository.findByLoginIdAndAndAuthProvider(id, authProvider)
                             .filter(user -> password.equals(user.getPassword()))
                             .isPresent();
    }

    public Optional<User> findUserByName(String userName) {
        return userRepository.findByName(userName);
    }

    public User findUserByLoginId(String loginId) {
        return userRepository.findByLoginId(loginId).orElseThrow(NoSuchElementException::new);
    }
}
