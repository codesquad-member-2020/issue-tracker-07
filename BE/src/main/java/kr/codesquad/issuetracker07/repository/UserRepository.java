package kr.codesquad.issuetracker07.repository;

import kr.codesquad.issuetracker07.domain.AuthProvider;
import kr.codesquad.issuetracker07.domain.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends CrudRepository<User, String> {
    Optional<User> findByName(String name);

    Optional<User> findByNameAndAuthProvider(String name, AuthProvider authProvider);
}
