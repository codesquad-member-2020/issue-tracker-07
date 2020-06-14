package kr.codesquad.issuetracker07.domain;

import lombok.*;

import javax.persistence.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Adding {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "commnet_id")
    private Comment comment;

    @ManyToOne
    @JoinColumn(name = "emoji_id")
    private Emoji emoji;

    private int addingCount;
}
