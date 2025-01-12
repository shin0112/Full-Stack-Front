package com.project.coffhy.domain;

import com.project.coffhy.dto.PostDto.PostRequest;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import java.time.LocalDateTime;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Post {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    Long userId;
    String title;
    String content;
    int like;
    LocalDateTime createdAt;
    LocalDateTime updatedAt;

    @Builder
    public Post(
        final Long userId,
        final String title,
        final String content
    ) {
        this.userId = userId;
        this.title = title;
        this.content = content;
        this.like = 0;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    public void update(final PostRequest postRequest) {
        this.content = postRequest.getContent();
        this.title = postRequest.getTitle();
    }
}
