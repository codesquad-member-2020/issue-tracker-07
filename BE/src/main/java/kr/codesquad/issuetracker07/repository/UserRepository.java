package kr.codesquad.issuetracker07.repository;

import kr.codesquad.issuetracker07.entity.AuthProvider;
import kr.codesquad.issuetracker07.entity.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {
    Optional<User> findByName(String name);

    Optional<User> findByLoginIdAndAuthProvider(String loginId, AuthProvider authProvider);

    Optional<User> findByLoginId(String loginId);

    List<User> findAll();
}
