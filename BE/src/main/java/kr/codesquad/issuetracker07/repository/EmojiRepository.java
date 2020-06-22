package kr.codesquad.issuetracker07.repository;

import kr.codesquad.issuetracker07.entity.Emoji;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EmojiRepository extends JpaRepository<Emoji, Long> {

}
