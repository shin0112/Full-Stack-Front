package com.project.coffhy.service;

import com.project.coffhy.domain.Post;
import com.project.coffhy.dto.PostDto.PostRequest;
import com.project.coffhy.dto.PostDto.PostResponse;
import com.project.coffhy.repository.PostRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class PostServiceImpl implements PostService {

    private final PostRepository postRepository;

    @Override
    @Transactional(readOnly = true)
    public List<PostResponse> getPostAll(final Long userId) {
        return postRepository.findAll(Sort.by("createdAt").descending()).stream()
            .map(post -> PostResponse.of(post, false))
            .toList();
    }

    @Override
    @Transactional(readOnly = true)
    public List<PostResponse> getPostMine(final Long userId) {
        return postRepository.findByUserId(userId).stream()
            .map(post -> PostResponse.of(post, false))
            .toList();
    }

    @Override
    public void createPost(final PostRequest postRequest) {
        Post post = PostRequest.toEntity(postRequest);
        postRepository.save(post);
    }
}
