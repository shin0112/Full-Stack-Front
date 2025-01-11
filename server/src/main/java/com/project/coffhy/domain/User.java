package com.project.coffhy.domain;

import lombok.Getter;

@Getter
public class User {

    Long id;
    String username = "";
    String password = "";

    public User(Long id) {
        this.id = id;
    }

    // todo: 로그인 시 아이디 비번 업데이트
}
