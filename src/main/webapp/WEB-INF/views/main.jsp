<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인 페이지</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding-top: 70px; /* 네비게이션 바 높이만큼 패딩 추가 */
            background-color: #f5f7fa;
            min-height: 100vh;
        }
        
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        
        .welcome-section {
            background: white;
            border-radius: 15px;
            padding: 40px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        .welcome-section h1 {
            color: #333;
            margin-bottom: 20px;
            font-size: 32px;
            font-weight: 300;
        }
        
        .welcome-section p {
            color: #666;
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }
        
        .card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            text-align: center;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
        }
        
        .card-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: white;
            font-size: 32px;
        }
        
        .card h3 {
            color: #333;
            margin-bottom: 15px;
            font-size: 20px;
            font-weight: 600;
        }
        
        .card p {
            color: #666;
            line-height: 1.6;
            margin-bottom: 20px;
        }
        
        .card-link {
            display: inline-block;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .card-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
        }
        
        .stats-section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-top: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .stat-item {
            text-align: center;
            padding: 20px;
            background: #f8f9ff;
            border-radius: 10px;
        }
        
        .stat-number {
            font-size: 32px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: #666;
            font-size: 14px;
        }
        
        @media (max-width: 768px) {
            .main-container {
                padding: 20px 15px;
            }
            
            .welcome-section {
                padding: 20px;
            }
            
            .welcome-section h1 {
                font-size: 24px;
            }
            
            .cards-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .card {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <!-- 공통 네비게이션 바 포함 -->
    <jsp:include page="common/navbar.jsp" />
    
    <div class="main-container">
        <div class="welcome-section">
            <h1>
                <i class="fas fa-home" style="color: #667eea; margin-right: 15px;"></i>
                환영합니다!
            </h1>
            <p>
                Spring Boot 애플리케이션에 오신 것을 환영합니다.<br>
                상단 메뉴를 통해 다양한 기능을 이용하실 수 있습니다.
            </p>
            <div class="stats-section">
                <h3 style="color: #333; margin-bottom: 20px; text-align: center;">
                    <i class="fas fa-chart-bar" style="margin-right: 10px; color: #667eea;"></i>
                    시스템 현황
                </h3>
                <div class="stats-grid">
                    <div class="stat-item">
                        <div class="stat-number">24</div>
                        <div class="stat-label">활성 세션</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">156</div>
                        <div class="stat-label">총 사용자</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">8</div>
                        <div class="stat-label">실행 중인 작업</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">99.9%</div>
                        <div class="stat-label">시스템 가동률</div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="cards-grid">
            <div class="card">
                <div class="card-icon">
                    <i class="fas fa-bars"></i>
                </div>
                <h3>동적 메뉴 시스템</h3>
                <p>Remote-example API를 통해 실시간으로 로드되는 계층형 메뉴 구조를 확인하세요.</p>
                <a href="/menu" class="card-link">
                    <i class="fas fa-arrow-right"></i> 메뉴 페이지로 이동
                </a>
            </div>
            
            <div class="card">
                <div class="card-icon">
                    <i class="fas fa-users"></i>
                </div>
                <h3>사용자 관리</h3>
                <p>시스템 사용자들을 관리하고 권한을 설정할 수 있습니다.</p>
                <a href="#" class="card-link">
                    <i class="fas fa-arrow-right"></i> 사용자 관리
                </a>
            </div>
            
            <div class="card">
                <div class="card-icon">
                    <i class="fas fa-cogs"></i>
                </div>
                <h3>시스템 설정</h3>
                <p>애플리케이션의 다양한 설정을 관리하고 구성할 수 있습니다.</p>
                <a href="#" class="card-link">
                    <i class="fas fa-arrow-right"></i> 설정 관리
                </a>
            </div>
            
            <div class="card">
                <div class="card-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <h3>통계 및 보고서</h3>
                <p>시스템 사용 현황과 다양한 통계 정보를 확인할 수 있습니다.</p>
                <a href="/stats" class="card-link">
                    <i class="fas fa-arrow-right"></i> 통계 보기
                </a>
            </div>
            
            <div class="card">
                <div class="card-icon">
                    <i class="fas fa-shield-alt"></i>
                </div>
                <h3>보안 관리</h3>
                <p>시스템 보안 설정과 접근 권한을 관리할 수 있습니다.</p>
                <a href="#" class="card-link">
                    <i class="fas fa-arrow-right"></i> 보안 설정
                </a>
            </div>
            
            <div class="card">
                <div class="card-icon">
                    <i class="fas fa-database"></i>
                </div>
                <h3>데이터 관리</h3>
                <p>시스템 데이터를 백업하고 복원할 수 있습니다.</p>
                <a href="#" class="card-link">
                    <i class="fas fa-arrow-right"></i> 데이터 관리
                </a>
            </div>
        </div>
    </div>
</body>
</html>