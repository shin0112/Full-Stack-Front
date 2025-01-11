package com.project.coffhy.repository;

import com.project.coffhy.domain.User;
import java.util.Optional;
import org.springframework.stereotype.Repository;

public interface UserRepository {

    Optional<User> create();
}
