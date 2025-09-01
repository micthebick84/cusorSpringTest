<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>동적 메뉴 페이지</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            margin: 0;
            padding-top: 70px;
        }
        
        .main-content {
            padding: 40px 20px;
            min-height: calc(100vh - 70px);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .content-placeholder {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            padding: 60px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            width: 100%;
        }
        
        .content-placeholder h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 28px;
        }
        
        .menu-info {
            background: #f8f9ff;
            border-radius: 10px;
            padding: 20px;
            margin: 20px 0;
            border-left: 4px solid #667eea;
        }
        
        .refresh-button {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 20px;
        }
        
        .refresh-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
        }
    </style>
</head>
<body>
    <!-- 공통 네비게이션 바 포함 -->
    <jsp:include page="common/navbar.jsp" />
    
    <div class="main-content">
        <div class="content-placeholder">
            <h2><i class="fas fa-bars"></i> 동적 메뉴 네비게이션 페이지</h2>
            <p>상단 네비게이션바는 Remote-example API에서 가져온 계층형 메뉴 구조를 표시합니다.</p>
            
            <div class="menu-info">
                <strong>메뉴 상태:</strong> <span id="menu-stats">API 연결 중...</span>
            </div>
            
            <button id="refresh-menu-btn" onclick="refreshMenuData()" class="refresh-button">
                <i class="fas fa-sync-alt"></i> 메뉴 새로고침
            </button>
        </div>
    </div>

    <script>
        async function refreshMenuData() {
            const refreshBtn = document.getElementById('refresh-menu-btn');
            const statsElement = document.getElementById('menu-stats');
            
            if (refreshBtn) {
                refreshBtn.disabled = true;
                refreshBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 새로고침 중...';
            }
            
            try {
                if (typeof loadHierarchicalMenu === 'function') {
                    await loadHierarchicalMenu();
                    if (statsElement) {
                        statsElement.textContent = '메뉴 새로고침 완료 ✓';
                    }
                }
            } catch (error) {
                if (statsElement) {
                    statsElement.textContent = '메뉴 새로고침 실패 ✗';
                }
            } finally {
                if (refreshBtn) {
                    refreshBtn.disabled = false;
                    refreshBtn.innerHTML = '<i class="fas fa-sync-alt"></i> 메뉴 새로고침';
                }
            }
        }
        
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(() => {
                const statsElement = document.getElementById('menu-stats');
                const navbarMenu = document.getElementById('navbar-menu');
                
                if (navbarMenu && navbarMenu.children.length > 0) {
                    if (statsElement) {
                        const menuCount = navbarMenu.children.length;
                        statsElement.textContent = menuCount + '개 메뉴 로드 완료 ✓';
                    }
                } else {
                    if (statsElement) {
                        statsElement.textContent = 'Fallback 메뉴로 대체됨';
                    }
                }
            }, 2000);
        });
    </script>
</body>
</html>
