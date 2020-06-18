package kr.codesquad.issuetracker07.service;

import kr.codesquad.issuetracker07.domain.AuthProvider;
import kr.codesquad.issuetracker07.domain.User;
import kr.codesquad.issuetracker07.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public void saveUser(User user, AuthProvider authProvider) {
        user.setAuthProvider(authProvider);
        userRepository.save(user);
    }

    public User makeUser(String id, String password) {
        return User.builder()
                   .name(id)
                   .password(password)
                   .imageUrl("https://codesquad-mocha.s3.ap-northeast-2.amazonaws.com/github.png")
                   .authProvider(AuthProvider.local)
                   .build();
    }

    public boolean isExistedUser(String id) {
        return userRepository.findByName(id).isPresent();
    }

    public boolean isValidIdAndPassword(String id, String password, AuthProvider authProvider) {
        return userRepository.findByNameAndAuthProvider(id, authProvider)
                             .filter(user -> password.equals(user.getPassword()))
                             .isPresent();
    }

    public Optional<User> findUserByName(String userName) {
        return userRepository.findByName(userName);
    }
}
