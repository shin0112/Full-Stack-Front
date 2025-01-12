package com.project.coffhy.controller;

import com.project.coffhy.dto.UserDto.UserIdResponse;
import com.project.coffhy.global.api.ApiResponse;
import com.project.coffhy.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("")
public class UserController {

    final private UserService userService;

    @GetMapping("/home")
    public ApiResponse<UserIdResponse> registerInitialUser() {
        return ApiResponse.success(userService.createInitialUser());
    }
}
