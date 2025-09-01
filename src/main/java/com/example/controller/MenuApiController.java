package com.example.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class MenuApiController {
    
    /**
     * 헬스 체크용 엔드포인트
     * 메뉴 관련 API 호출은 JavaScript에서 직접 외부 API로 수행
     */
    @GetMapping("/health")
    public Map<String, Object> health() {
        return Map.of(
            "status", "UP",
            "message", "Menu API Controller is running",
            "timestamp", System.currentTimeMillis()
        );
    }
}

