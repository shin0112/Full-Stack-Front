package com.project.coffhy.controller;

import com.project.coffhy.dto.PostDto.PostRequest;
import com.project.coffhy.dto.PostDto.PostResponse;
import com.project.coffhy.global.api.ApiResponse;
import com.project.coffhy.service.PostService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/posts")
public class PostController {

    private final PostService postService;

    @GetMapping("users/{userId}")
    public ApiResponse<?> getPostAll(@PathVariable Long userId) {
        List<PostResponse> postResponseList = postService.getPostAll(userId);
        return ApiResponse.success(postResponseList);
    }

    @GetMapping("/mine/{userId}")
    public ApiResponse<?> getPostMine(@PathVariable Long userId) {
        List<PostResponse> postResponseList = postService.getPostMine(userId);
        return ApiResponse.success(postResponseList);
    }

    @PostMapping()
    public ApiResponse<?> createPost(@RequestBody PostRequest postRequest) {
        PostResponse postResponse = postService.createPost(postRequest);
        return ApiResponse.success(postResponse);
    }
}

