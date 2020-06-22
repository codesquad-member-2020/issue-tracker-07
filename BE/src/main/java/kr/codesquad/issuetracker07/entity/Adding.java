package kr.codesquad.issuetracker07.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Adding {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int addingCount;

    @ManyToOne
    @JoinColumn(name = "commnet_id")
    private Comment comment;

    @ManyToOne
    @JoinColumn(name = "emoji_id")
    private Emoji emoji;
}
