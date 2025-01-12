package com.project.coffhy.dto;

import com.project.coffhy.domain.User;
import lombok.Getter;

public class UserDto {

    @Getter
    public static class UserIdResponse {

        Long id;

        public UserIdResponse(Long id) {
            this.id = id;
        }

        public static UserIdResponse of(User user) {
            return new UserIdResponse(user.getId());
        }
    }
}
