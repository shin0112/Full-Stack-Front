package com.project.coffhy.dto;

import com.project.coffhy.domain.Post;
import java.time.LocalDateTime;
import lombok.Builder;
import lombok.Getter;

public class PostDto {

    @Getter
    @Builder
    public static class PostResponse {

        Long id;
        Long userId;
        String title;
        String content;
        int like;
        boolean isLike;
        LocalDateTime createdAt;
        LocalDateTime updatedAt;

        public static PostResponse of(Post post, boolean isLike) {
            return PostResponse.builder()
                .id(post.getId())
                .userId(post.getUserId())
                .title(post.getTitle())
                .content(post.getContent())
                .like(post.getLike())
                .isLike(isLike)
                .createdAt(post.getCreatedAt())
                .updatedAt(post.getUpdatedAt())
                .build();
        }
    }

    @Getter
    @Builder
    public static class PostRequest {
        Long userId;
        String title;
        String content;

        public static Post toEntity(PostRequest postRequest) {
            return Post.builder()
                .userId(postRequest.getUserId())
                .title(postRequest.getTitle())
                .content(postRequest.getContent())
                .build();
        }
    }
}
