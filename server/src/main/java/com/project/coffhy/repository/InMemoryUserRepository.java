package com.project.coffhy.repository;

import com.project.coffhy.domain.User;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import org.springframework.stereotype.Repository;

@Repository
public class InMemoryUserRepository implements UserRepository {

    private static Long id = 0L;
    private final Map<Long, User> userStore = new HashMap<>();

    @Override
    public Optional<User> create() {
        User user = new User(id++);
        userStore.put(user.getId(), user);
        return Optional.of(user);
    }

    public void clearStore() {
        userStore.clear();
        id = 0L;
    }
}
