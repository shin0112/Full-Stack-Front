package com.project.coffhy.service;

import com.project.coffhy.domain.User;
import com.project.coffhy.dto.UserDto.UserIdResponse;
import com.project.coffhy.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    final private UserRepository userRepository;

    @Override
    public UserIdResponse createInitialUser() {
        User user = userRepository.save(new User());
        return UserIdResponse.of(user);
    }
}
