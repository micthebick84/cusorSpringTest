<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f7fa;
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .header h1 {
            margin: 0;
            font-size: 24px;
            font-weight: 300;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            font-weight: bold;
        }
        
        .logout-btn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.3);
            padding: 8px 16px;
            border-radius: 5px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.3);
        }
        
        .main-content {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        .welcome-card {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            margin-bottom: 30px;
        }
        
        .welcome-card h2 {
            color: #333;
            margin: 0 0 20px 0;
            font-size: 28px;
            font-weight: 400;
        }
        
        .welcome-card p {
            color: #666;
            font-size: 16px;
            line-height: 1.6;
            margin: 0;
        }
        
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        
        .feature-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease;
        }
        
        .feature-card:hover {
            transform: translateY(-5px);
        }
        
        .feature-card h3 {
            color: #333;
            margin: 0 0 15px 0;
            font-size: 20px;
            font-weight: 500;
        }
        
        .feature-card p {
            color: #666;
            margin: 0;
            line-height: 1.5;
        }
        
        .feature-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
            color: white;
            font-size: 24px;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        
        .stat-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }
        
        .stat-number {
            font-size: 32px;
            font-weight: bold;
            color: #667eea;
            margin: 0;
        }
        
        .stat-label {
            color: #666;
            margin: 5px 0 0 0;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1>Spring Boot JSP 웹 애플리케이션</h1>
            <div class="user-info">
                <div class="user-avatar">
                    ${user.name.charAt(0)}
                </div>
                <span>${user.name}님 환영합니다!</span>
                <a href="/logout" class="logout-btn">로그아웃</a>
            </div>
        </div>
    </div>
    
    <div class="main-content">
        <div class="welcome-card">
            <h2>환영합니다, ${user.name}님!</h2>
            <p>Spring Boot와 JSP를 사용하여 만든 웹 애플리케이션에 오신 것을 환영합니다. 
               이 페이지는 로그인 후에만 접근할 수 있습니다.</p>
        </div>
        
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">🚀</div>
                <h3>Spring Boot</h3>
                <p>강력하고 빠른 Spring Boot 프레임워크를 사용하여 개발되었습니다.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">🌐</div>
                <h3>JSP & WebMVC</h3>
                <p>전통적인 JSP 뷰와 Spring WebMVC를 활용한 웹 애플리케이션입니다.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">🔐</div>
                <h3>세션 기반 인증</h3>
                <p>HttpSession을 사용한 안전한 사용자 인증 시스템을 구현했습니다.</p>
            </div>
        </div>
        
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number">${user.username}</div>
                <div class="stat-label">사용자 ID</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-number">${user.email}</div>
                <div class="stat-label">이메일</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-number">Spring Boot</div>
                <div class="stat-label">프레임워크</div>
            </div>
        </div>
    </div>
</body>
</html>
