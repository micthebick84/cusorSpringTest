package com.example.service;

import com.example.model.User;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class UserService {
    
    // 간단한 인메모리 사용자 저장소 (실제로는 데이터베이스를 사용해야 함)
    private static final Map<String, User> userDatabase = new HashMap<>();
    
    static {
        // 테스트용 사용자 데이터
        userDatabase.put("admin", new User("admin", "1234", "관리자", "admin@example.com"));
        userDatabase.put("user", new User("user", "1234", "일반사용자", "user@example.com"));
    }
    
    public User authenticateUser(String username, String password) {
        User user = userDatabase.get(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
    
    public User getUserByUsername(String username) {
        return userDatabase.get(username);
    }
}
