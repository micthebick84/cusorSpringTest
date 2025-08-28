# Spring Boot JSP 웹 애플리케이션

Spring Boot와 JSP를 사용하여 만든 웹 애플리케이션입니다. 로그인 기능과 세션 기반 인증을 포함하고 있습니다.

## 주요 기능

- **Spring Boot 2.7.18** 기반
- **JSP 뷰** 지원
- **Spring WebMVC** 사용
- **세션 기반 인증** 시스템
- **로그인/로그아웃** 기능
- **반응형 웹 디자인**

## 기술 스택

- Java 11
- Spring Boot 2.7.18
- Spring WebMVC
- JSP (JavaServer Pages)
- JSTL (JSP Standard Tag Library)
- Maven

## 프로젝트 구조

```
src/
├── main/
│   ├── java/
│   │   └── com/example/
│   │       ├── Application.java          # 메인 애플리케이션 클래스
│   │       ├── config/
│   │       │   └── WebConfig.java       # WebMVC 설정
│   │       ├── controller/
│   │       │   └── MainController.java  # 메인 컨트롤러
│   │       ├── dto/
│   │       │   └── LoginRequest.java    # 로그인 요청 DTO
│   │       ├── model/
│   │       │   └── User.java           # 사용자 모델
│   │       └── service/
│   │           └── UserService.java     # 사용자 서비스
│   ├── resources/
│   │   └── application.properties      # 애플리케이션 설정
│   └── webapp/
│       └── WEB-INF/
│           └── views/
│               ├── login.jsp            # 로그인 페이지
│               └── main.jsp             # 메인 페이지
└── test/
    └── java/
        └── com/example/
```

## 실행 방법

### 1. Maven 설치 확인
```bash
mvn --version
```

### 2. 프로젝트 빌드
```bash
mvn clean compile
```

### 3. 애플리케이션 실행
```bash
mvn spring-boot:run
```

### 4. 웹 브라우저에서 접속
- **로그인 페이지**: http://localhost:8080/
- **메인 페이지**: http://localhost:8080/main (로그인 후 접근 가능)

## 테스트 계정

- **관리자 계정**
  - 아이디: `admin`
  - 비밀번호: `1234`
  
- **일반 사용자 계정**
  - 아이디: `user`
  - 비밀번호: `1234`

## 주요 엔드포인트

- `GET /` - 로그인 페이지 (첫 페이지)
- `GET /login` - 로그인 페이지
- `POST /login` - 로그인 처리
- `GET /main` - 메인 페이지 (인증 필요)
- `GET /logout` - 로그아웃

## 보안 기능

- **세션 기반 인증**: HttpSession을 사용한 사용자 인증
- **접근 제어**: 로그인하지 않은 사용자는 메인 페이지 접근 불가
- **자동 리다이렉트**: 인증되지 않은 사용자는 로그인 페이지로 자동 이동

## 개발 환경 설정

### IDE 설정
- IntelliJ IDEA, Eclipse, VS Code 등에서 Spring Boot 프로젝트로 열기
- Maven 프로젝트로 인식되도록 설정

### 디버깅
- `application.properties`에서 로그 레벨 조정 가능
- Spring Boot DevTools로 자동 재시작 지원

## 배포

### JAR 파일로 빌드
```bash
mvn clean package
```

### 실행
```bash
java -jar target/springboot-jsp-web-1.0.0.jar
```

## 주의사항

- JSP는 내장 톰캣에서만 작동합니다
- 프로덕션 환경에서는 WAR 파일로 배포하는 것을 권장합니다
- 실제 운영 환경에서는 데이터베이스 연동과 보안 강화가 필요합니다

## 라이선스

이 프로젝트는 교육 및 학습 목적으로 제작되었습니다.
