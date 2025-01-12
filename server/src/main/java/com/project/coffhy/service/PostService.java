package com.project.coffhy.service;

import com.project.coffhy.dto.PostDto;
import com.project.coffhy.dto.PostDto.PostResponse;
import java.util.List;

public interface PostService {

    List<PostResponse> getPostAll(final Long userId);

    List<PostResponse> getPostMine(Long userId);

    void createPost(PostDto.PostRequest postRequest);
}
