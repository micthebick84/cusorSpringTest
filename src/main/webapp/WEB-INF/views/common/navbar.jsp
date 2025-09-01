<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 공통 네비게이션 바 CSS -->
<style>
    /* 네비게이션 바 전체 컨테이너 */
    .navbar {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        backdrop-filter: blur(10px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.2);
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 1000;
        padding: 0 20px;
        height: 70px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
    }
    
    .navbar-brand {
        color: white;
        font-size: 24px;
        font-weight: bold;
        text-decoration: none;
    }
    
    .navbar-menu {
        display: flex;
        align-items: center;
        list-style: none;
        margin: 0;
        padding: 0;
        flex: 1;
        justify-content: center;
    }
    
    .navbar-item {
        margin: 0 5px; /* 간격 줄임 */
        position: relative;
    }
    
    .navbar-link {
        display: flex;
        align-items: center;
        text-decoration: none;
        color: rgba(255, 255, 255, 0.9);
        padding: 10px 15px; /* 패딩 줄임 */
        border-radius: 8px;
        transition: all 0.3s ease;
        font-weight: 500;
        cursor: pointer;
        white-space: nowrap; /* 텍스트 줄바꿈 방지 */
        font-size: 14px; /* 폰트 크기 줄임 */
        min-width: auto; /* 최소 너비 제거 */
    }
    
    .navbar-link:hover {
        background: rgba(255, 255, 255, 0.2);
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(255, 255, 255, 0.2);
    }
    
    .navbar-link i {
        margin-right: 6px; /* 아이콘 간격 줄임 */
        font-size: 14px;
    }
    
    /* 드롭다운 메뉴 스타일 개선 */
    .dropdown {
        position: relative;
    }
    
    .dropdown-content {
        display: none;
        position: absolute;
        top: 100%;
        left: 0;
        background: white;
        border-radius: 10px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        min-width: 280px; /* 최소 너비 증가 */
        max-width: 350px; /* 최대 너비 설정 */
        z-index: 1001;
        padding: 10px 0;
        margin-top: 0;
        border: 1px solid rgba(0, 0, 0, 0.1);
        transition: opacity 0.2s ease-in-out, transform 0.2s ease-in-out, visibility 0.2s ease-in-out;
        opacity: 0;
        transform: translateY(-10px);
        pointer-events: none;
        visibility: hidden;
    }
    
    /* 호버 시 드롭다운 표시 - 개선된 지연 효과 */
    .dropdown:hover .dropdown-content {
        display: block;
        opacity: 1;
        transform: translateY(0);
        pointer-events: auto;
        visibility: visible;
    }
    
    /* 드롭다운 호버 영역 확장 */
    .dropdown::after {
        content: '';
        position: absolute;
        top: 100%;
        left: 0;
        right: 0;
        height: 8px; /* 호버 영역 증가 */
        background: transparent;
        z-index: 1000;
    }
    
    .dropdown-item {
        padding: 0;
    }
    
    .dropdown-link {
        display: flex;
        align-items: center;
        padding: 12px 20px;
        color: #555;
        text-decoration: none;
        transition: all 0.3s ease;
        border-radius: 0;
        position: relative;
        min-height: 44px;
        white-space: nowrap; /* 텍스트 줄바꿈 방지 */
        overflow: hidden;
        text-overflow: ellipsis; /* 긴 텍스트 처리 */
    }
    
    .dropdown-link:hover {
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        transform: none;
        box-shadow: none;
    }
    
    .dropdown-link i {
        margin-right: 10px;
        width: 16px;
        text-align: center;
        flex-shrink: 0; /* 아이콘 크기 고정 */
    }
    
    /* 중메뉴(서브메뉴) 스타일 개선 */
    .sub-dropdown {
        position: relative;
    }
    
    .sub-dropdown-content {
        display: none;
        position: absolute;
        top: -5px;
        left: 100%;
        background: white;
        border-radius: 10px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        min-width: 250px; /* 서브메뉴 너비 증가 */
        max-width: 300px;
        z-index: 1002;
        padding: 10px 0;
        margin-left: -2px;
        border: 1px solid rgba(0, 0, 0, 0.1);
        transition: opacity 0.2s ease-in-out, transform 0.2s ease-in-out, visibility 0.2s ease-in-out;
        opacity: 0;
        transform: translateX(-10px);
        pointer-events: none;
        visibility: hidden;
    }
    
    /* 중메뉴 호버 시 서브메뉴 표시 */
    .sub-dropdown:hover .sub-dropdown-content {
        display: block;
        opacity: 1;
        transform: translateX(0);
        pointer-events: auto;
        visibility: visible;
    }
    
    /* 중메뉴 호버 영역 확장 */
    .sub-dropdown::after {
        content: '';
        position: absolute;
        top: 0;
        right: -8px; /* 확장 영역 증가 */
        bottom: 0;
        width: 12px;
        background: transparent;
        z-index: 1001;
    }
    
    .dropdown-arrow {
        margin-left: auto;
        font-size: 12px;
        flex-shrink: 0; /* 화살표 크기 고정 */
    }
    
    /* 메뉴 텍스트 너비 제한 */
    .menu-text {
        max-width: 200px; /* 메뉴 텍스트 최대 너비 */
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }
    
    .sub-menu-text {
        max-width: 180px; /* 서브메뉴 텍스트 최대 너비 */
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }
    
    /* 모바일 및 터치 디바이스 개선 */
    @media (hover: none) and (pointer: coarse) {
        .dropdown:hover .dropdown-content,
        .sub-dropdown:hover .sub-dropdown-content {
            display: none;
        }
        
        .dropdown.active .dropdown-content,
        .sub-dropdown.active .sub-dropdown-content {
            display: block;
            opacity: 1;
            transform: translateY(0) translateX(0);
            pointer-events: auto;
            visibility: visible;
        }
        
        .navbar-link,
        .dropdown-link {
            min-height: 48px;
            padding: 16px 24px;
        }
    }
    
    /* 키보드 접근성 개선 */
    .navbar-link:focus,
    .dropdown-link:focus {
        outline: 2px solid rgba(255, 255, 255, 0.8);
        outline-offset: 2px;
        background: rgba(255, 255, 255, 0.2);
        color: white;
    }
    
    /* 메뉴 아이템 구분선 */
    .dropdown-item:not(:last-child) {
        border-bottom: 1px solid #f0f0f0;
    }
    
    .sub-dropdown .dropdown-item:not(:last-child) {
        border-bottom: 1px solid #f5f5f5;
    }
    
    .user-info {
        display: flex;
        align-items: center;
        color: rgba(255, 255, 255, 0.9);
        font-size: 14px;
    }
    
    .user-info i {
        margin-right: 8px;
        color: rgba(255, 255, 255, 0.8);
    }
    
    .logout-btn {
        margin-left: 20px;
        padding: 8px 16px;
        background: rgba(255, 255, 255, 0.2);
        color: white;
        text-decoration: none;
        border-radius: 6px;
        transition: all 0.3s ease;
        font-size: 14px;
        border: 1px solid rgba(255, 255, 255, 0.3);
    }
    
    .logout-btn:hover {
        background: rgba(255, 255, 255, 0.3);
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(255, 255, 255, 0.2);
    }
    
    /* 반응형 디자인 */
    @media (max-width: 1200px) {
        .navbar-link {
            padding: 8px 12px;
            font-size: 13px;
        }
        
        .dropdown-content {
            min-width: 250px;
        }
        
        .sub-dropdown-content {
            min-width: 220px;
        }
    }
    
    @media (max-width: 768px) {
        .navbar {
            padding: 0 10px;
        }
        
        .navbar-item {
            margin: 0 2px;
        }
        
        .navbar-link {
            padding: 6px 10px;
            font-size: 12px;
        }
        
        .menu-text {
            max-width: 120px;
        }
        
        .dropdown-content {
            min-width: 200px;
            left: -50px; /* 중앙 정렬을 위해 조정 */
        }
    }
</style>

<!-- 네비게이션 바 HTML -->
<nav class="navbar">
    <a href="/" class="navbar-brand">
        <i class="fas fa-code"></i> Spring Boot App
    </a>
    
    <ul class="navbar-menu" id="navbar-menu">
        <!-- 동적 메뉴가 여기에 로드됩니다 -->
    </ul>
    
    <div class="user-info">
        <c:choose>
            <c:when test="${not empty user and not empty user.username}">
                <i class="fas fa-user"></i>
                <span>${user.username}</span>
            </c:when>
            <c:otherwise>
                <i class="fas fa-user"></i>
                <span>Guest</span>
            </c:otherwise>
        </c:choose>
        <a href="/logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> 로그아웃
        </a>
    </div>
</nav>

<!-- 공통 네비게이션 JavaScript -->
<script>
    // 메뉴 타이머 변수
    let menuTimers = {
        hideMainMenu: null,
        hideSubMenu: null
    };
    
    // 네비게이션 초기화
    function initializeNavbar() {
        loadHierarchicalMenu();
        setupMenuEventListeners();
    }
    
    // 메뉴 이벤트 리스너 설정
    function setupMenuEventListeners() {
        const isTouchDevice = 'ontouchstart' in window || navigator.maxTouchPoints > 0;
        
        if (isTouchDevice) {
            setupTouchMenuEvents();
        } else {
            setupMouseMenuEvents();
        }
        
        setupKeyboardMenuEvents();
    }
    
    // 마우스 디바이스용 메뉴 이벤트 - 개선된 버전
    function setupMouseMenuEvents() {
        document.addEventListener('mouseover', function(e) {
            const dropdown = e.target.closest('.dropdown');
            const subDropdown = e.target.closest('.sub-dropdown');
            
            if (dropdown) {
                clearMenuTimer('hideMainMenu');
                showDropdownMenu(dropdown);
            }
            
            if (subDropdown) {
                clearMenuTimer('hideSubMenu');
                showSubDropdownMenu(subDropdown);
            }
        });
        
        document.addEventListener('mouseout', function(e) {
            const dropdown = e.target.closest('.dropdown');
            const subDropdown = e.target.closest('.sub-dropdown');
            
            // 더 정확한 마우스 아웃 감지
            if (dropdown) {
                const dropdownContent = dropdown.querySelector('.dropdown-content');
                if (!dropdown.contains(e.relatedTarget) && 
                    !dropdownContent?.contains(e.relatedTarget)) {
                    hideDropdownMenuWithDelay(dropdown, 200); // 지연 시간 단축
                }
            }
            
            if (subDropdown) {
                const subDropdownContent = subDropdown.querySelector('.sub-dropdown-content');
                if (!subDropdown.contains(e.relatedTarget) && 
                    !subDropdownContent?.contains(e.relatedTarget)) {
                    hideSubDropdownMenuWithDelay(subDropdown, 150); // 지연 시간 단축
                }
            }
        });
        
        // 전역 마우스 아웃 감지 (메뉴 영역 완전 이탈 시)
        document.addEventListener('mousemove', function(e) {
            const allDropdowns = document.querySelectorAll('.dropdown');
            allDropdowns.forEach(dropdown => {
                const rect = dropdown.getBoundingClientRect();
                const content = dropdown.querySelector('.dropdown-content');
                const contentRect = content?.getBoundingClientRect();
                
                // 마우스가 드롭다운과 그 콘텐츠 영역 모두에서 벗어났는지 확인
                if (content && content.style.opacity === '1') {
                    const isOutsideDropdown = e.clientX < rect.left - 10 || 
                                             e.clientX > rect.right + 10 || 
                                             e.clientY < rect.top - 10;
                    const isOutsideContent = contentRect && (
                        e.clientX < contentRect.left - 10 || 
                        e.clientX > contentRect.right + 10 || 
                        e.clientY < contentRect.top - 10 || 
                        e.clientY > contentRect.bottom + 10
                    );
                    
                    if (isOutsideDropdown && isOutsideContent) {
                        hideDropdownMenuWithDelay(dropdown, 100);
                    }
                }
            });
        });
    }
    
    // 터치 디바이스용 메뉴 이벤트
    function setupTouchMenuEvents() {
        document.addEventListener('click', function(e) {
            const dropdownLink = e.target.closest('.dropdown > .navbar-link');
            const subDropdownLink = e.target.closest('.sub-dropdown > .dropdown-link');
            
            if (dropdownLink) {
                e.preventDefault();
                const dropdown = dropdownLink.parentElement;
                toggleDropdownMenu(dropdown);
            }
            
            if (subDropdownLink) {
                e.preventDefault();
                const subDropdown = subDropdownLink.parentElement;
                toggleSubDropdownMenu(subDropdown);
            }
            
            if (!e.target.closest('.dropdown')) {
                closeAllMenus();
            }
        });
    }
    
    // 키보드 접근성 지원
    function setupKeyboardMenuEvents() {
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                closeAllMenus();
            }
            
            if (e.key === 'Enter' || e.key === ' ') {
                const focusedElement = document.activeElement;
                if (focusedElement.closest('.dropdown > .navbar-link')) {
                    e.preventDefault();
                    const dropdown = focusedElement.closest('.dropdown');
                    toggleDropdownMenu(dropdown);
                }
            }
        });
    }
    
    // 메뉴 타이머 클리어
    function clearMenuTimer(timerName) {
        if (menuTimers[timerName]) {
            clearTimeout(menuTimers[timerName]);
            menuTimers[timerName] = null;
        }
    }
    
    // 드롭다운 메뉴 표시
    function showDropdownMenu(dropdown) {
        const content = dropdown.querySelector('.dropdown-content');
        if (content) {
            content.style.display = 'block';
            content.style.visibility = 'visible';
            setTimeout(() => {
                content.style.opacity = '1';
                content.style.transform = 'translateY(0)';
                content.style.pointerEvents = 'auto';
            }, 10);
        }
    }
    
    // 서브 드롭다운 메뉴 표시
    function showSubDropdownMenu(subDropdown) {
        const content = subDropdown.querySelector('.sub-dropdown-content');
        if (content) {
            content.style.display = 'block';
            content.style.visibility = 'visible';
            setTimeout(() => {
                content.style.opacity = '1';
                content.style.transform = 'translateX(0)';
                content.style.pointerEvents = 'auto';
            }, 10);
        }
    }
    
    // 지연된 드롭다운 메뉴 숨김
    function hideDropdownMenuWithDelay(dropdown, delay) {
        clearMenuTimer('hideMainMenu');
        menuTimers.hideMainMenu = setTimeout(() => {
            const content = dropdown.querySelector('.dropdown-content');
            if (content) {
                content.style.opacity = '0';
                content.style.transform = 'translateY(-10px)';
                content.style.pointerEvents = 'none';
                setTimeout(() => {
                    content.style.display = 'none';
                    content.style.visibility = 'hidden';
                }, 200);
            }
        }, delay);
    }
    
    // 지연된 서브 드롭다운 메뉴 숨김
    function hideSubDropdownMenuWithDelay(subDropdown, delay) {
        clearMenuTimer('hideSubMenu');
        menuTimers.hideSubMenu = setTimeout(() => {
            const content = subDropdown.querySelector('.sub-dropdown-content');
            if (content) {
                content.style.opacity = '0';
                content.style.transform = 'translateX(-10px)';
                content.style.pointerEvents = 'none';
                setTimeout(() => {
                    content.style.display = 'none';
                    content.style.visibility = 'hidden';
                }, 200);
            }
        }, delay);
    }
    
    // 드롭다운 메뉴 토글 (터치용)
    function toggleDropdownMenu(dropdown) {
        const isActive = dropdown.classList.contains('active');
        closeAllMenus();
        
        if (!isActive) {
            dropdown.classList.add('active');
            showDropdownMenu(dropdown);
        }
    }
    
    // 서브 드롭다운 메뉴 토글 (터치용)
    function toggleSubDropdownMenu(subDropdown) {
        const isActive = subDropdown.classList.contains('active');
        
        const parentDropdown = subDropdown.closest('.dropdown-content');
        if (parentDropdown) {
            parentDropdown.querySelectorAll('.sub-dropdown.active').forEach(activeSubDropdown => {
                if (activeSubDropdown !== subDropdown) {
                    activeSubDropdown.classList.remove('active');
                    hideSubDropdownMenu(activeSubDropdown);
                }
            });
        }
        
        if (!isActive) {
            subDropdown.classList.add('active');
            showSubDropdownMenu(subDropdown);
        } else {
            subDropdown.classList.remove('active');
            hideSubDropdownMenu(subDropdown);
        }
    }
    
    // 모든 메뉴 닫기
    function closeAllMenus() {
        document.querySelectorAll('.dropdown.active').forEach(dropdown => {
            dropdown.classList.remove('active');
            hideDropdownMenu(dropdown);
        });
        
        document.querySelectorAll('.sub-dropdown.active').forEach(subDropdown => {
            subDropdown.classList.remove('active');
            hideSubDropdownMenu(subDropdown);
        });
        
        // 모든 드롭다운 메뉴 즉시 숨김
        document.querySelectorAll('.dropdown-content').forEach(content => {
            if (content.style.opacity === '1') {
                content.style.opacity = '0';
                content.style.transform = 'translateY(-10px)';
                content.style.pointerEvents = 'none';
                setTimeout(() => {
                    content.style.display = 'none';
                    content.style.visibility = 'hidden';
                }, 200);
            }
        });
    }
    
    // 즉시 메뉴 숨김 (터치용)
    function hideDropdownMenu(dropdown) {
        const content = dropdown.querySelector('.dropdown-content');
        if (content) {
            content.style.opacity = '0';
            content.style.transform = 'translateY(-10px)';
            content.style.pointerEvents = 'none';
            setTimeout(() => {
                content.style.display = 'none';
                content.style.visibility = 'hidden';
            }, 200);
        }
    }
    
    // 즉시 서브메뉴 숨김 (터치용)
    function hideSubDropdownMenu(subDropdown) {
        const content = subDropdown.querySelector('.sub-dropdown-content');
        if (content) {
            content.style.opacity = '0';
            content.style.transform = 'translateX(-10px)';
            content.style.pointerEvents = 'none';
            setTimeout(() => {
                content.style.display = 'none';
                content.style.visibility = 'hidden';
            }, 200);
        }
    }
    
    // Remote Example API에서 계층형 메뉴 구조를 가져오는 함수
    async function loadHierarchicalMenu() {
        try {
            const baseUrl = 'http://localhost:8080';
            const userId = 'admin';
            const siteName = 'Netis v6.6';
            const auth = 'admin';
            const menuAuthNo = 0;
            
            const apiUrl = baseUrl + '/api/menu/hierarchical' +
                '?userId=' + encodeURIComponent(userId) +
                '&siteName=' + encodeURIComponent(siteName) +
                '&auth=' + encodeURIComponent(auth) +
                '&menuAuthNo=' + menuAuthNo;
            
            console.log('Remote-example API 호출 시도:', apiUrl);
            
            const response = await fetch(apiUrl, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            });
            
            if (!response.ok) {
                throw new Error('Remote-example API 호출 실패: HTTP ' + response.status);
            }
            
            const hierarchicalData = await response.json();
            console.log('Remote-example API 응답 성공:', hierarchicalData);
            
            const transformedMenuData = transformRemoteExampleData(hierarchicalData);
            renderHierarchicalMenu(transformedMenuData);
            
        } catch (error) {
            console.warn('Remote-example API 연결 실패, Fallback 메뉴로 전환:', error.message);
            await loadFallbackMenuWithDelay();
        }
    }
    
    // Remote-example API 데이터를 내부 메뉴 구조로 변환
    function transformRemoteExampleData(remoteData) {
        console.log('Remote-example 데이터 변환 시작:', remoteData);
        
        if (!Array.isArray(remoteData)) {
            console.warn('Remote-example API 데이터가 배열이 아님:', typeof remoteData);
            return createFallbackMenu();
        }
        
        if (remoteData.length === 0) {
            console.warn('Remote-example API에서 빈 데이터 반환');
            return createFallbackMenu();
        }
        
        const transformedMenu = remoteData.map(page => ({
            menuId: page.pageNo || 'PAGE_' + Math.random().toString(36).substr(2, 9),
            menuName: page.pageName || '알 수 없는 페이지',
            menuType: 'LARGE',
            parentMenuId: null,
            orderNo: page.orderNo || 1,
            iconClass: page.webIconClass || 'fas fa-folder',
            url: null,
            subMenus: transformPageGroups(page.children, page.pageNo)
        }));
        
        console.log('Remote-example 데이터 변환 완료: 대메뉴 ' + transformedMenu.length + '개');
        return transformedMenu;
    }
    
    // 페이지 그룹(중메뉴) 변환 함수
    function transformPageGroups(pageGroups, parentPageNo) {
        if (!Array.isArray(pageGroups) || pageGroups.length === 0) {
            return [];
        }
        
        return pageGroups.map(pageGroup => ({
            menuId: pageGroup.pageGrpNo || 'GROUP_' + Math.random().toString(36).substr(2, 9),
            menuName: pageGroup.pageGrpName || '알 수 없는 그룹',
            menuType: 'MEDIUM',
            parentMenuId: parentPageNo,
            orderNo: pageGroup.orderNo || 1,
            iconClass: 'fas fa-folder-open',
            url: null,
            subMenus: transformMenus(pageGroup.children, pageGroup.pageGrpNo)
        }));
    }
    
    // 메뉴(소메뉴) 변환 함수
    function transformMenus(menus, parentGroupNo) {
        if (!Array.isArray(menus) || menus.length === 0) {
            return [];
        }
        
        return menus.map(menu => ({
            menuId: menu.menuNo || 'MENU_' + Math.random().toString(36).substr(2, 9),
            menuName: menu.menuName || '알 수 없는 메뉴',
            menuType: 'SMALL',
            parentMenuId: parentGroupNo,
            orderNo: menu.orderNo || 1,
            iconClass: getMenuIcon(menu.menuType),
            url: menu.guid ? '/page/' + menu.guid : '#'
        }));
    }
    
    // 메뉴 타입에 따른 아이콘 반환
    function getMenuIcon(menuType) {
        const iconMap = {
            'link': 'fas fa-link',
            'page': 'fas fa-file-alt',
            'form': 'fas fa-edit',
            'report': 'fas fa-chart-bar',
            'dashboard': 'fas fa-tachometer-alt'
        };
        return iconMap[menuType] || 'fas fa-circle';
    }
    
    // 계층형 메뉴 렌더링
    function renderHierarchicalMenu(menuData) {
        const navbarMenu = document.getElementById('navbar-menu');
        if (!navbarMenu) {
            console.error('navbar-menu 엘리먼트를 찾을 수 없습니다.');
            return;
        }
        
        navbarMenu.innerHTML = '';
        
        menuData.forEach(largeMenu => {
            const menuItem = createMenuElement(largeMenu);
            navbarMenu.appendChild(menuItem);
        });
        
        console.log('계층형 메뉴 렌더링 완료: ' + menuData.length + '개 대메뉴');
    }
    
    // 메뉴 엘리먼트 생성
    function createMenuElement(menuData) {
        const li = document.createElement('li');
        li.className = 'navbar-item dropdown';
        
        const link = document.createElement('a');
        link.className = 'navbar-link';
        link.href = menuData.url || '#';
        
        const icon = document.createElement('i');
        icon.className = menuData.iconClass || 'fas fa-folder';
        
        const text = document.createElement('span');
        text.className = 'menu-text';
        text.textContent = menuData.menuName;
        
        link.appendChild(icon);
        link.appendChild(text);
        
        if (menuData.subMenus && menuData.subMenus.length > 0) {
            const arrow = document.createElement('i');
            arrow.className = 'fas fa-chevron-down dropdown-arrow';
            link.appendChild(arrow);
            
            const dropdownContent = createDropdownContent(menuData.subMenus);
            li.appendChild(link);
            li.appendChild(dropdownContent);
        } else {
            li.appendChild(link);
        }
        
        return li;
    }
    
    // 드롭다운 콘텐츠 생성
    function createDropdownContent(subMenus) {
        const div = document.createElement('div');
        div.className = 'dropdown-content';
        
        subMenus.forEach(subMenu => {
            const item = createDropdownItem(subMenu);
            div.appendChild(item);
        });
        
        return div;
    }
    
    // 드롭다운 아이템 생성
    function createDropdownItem(menuData) {
        const div = document.createElement('div');
        div.className = 'dropdown-item';
        
        if (menuData.subMenus && menuData.subMenus.length > 0) {
            div.classList.add('sub-dropdown');
            
            const link = document.createElement('a');
            link.className = 'dropdown-link';
            link.href = menuData.url || '#';
            
            const icon = document.createElement('i');
            icon.className = menuData.iconClass || 'fas fa-folder';
            
            const text = document.createElement('span');
            text.className = 'sub-menu-text';
            text.textContent = menuData.menuName;
            
            const arrow = document.createElement('i');
            arrow.className = 'fas fa-chevron-right dropdown-arrow';
            
            link.appendChild(icon);
            link.appendChild(text);
            link.appendChild(arrow);
            
            const subDropdownContent = createDropdownContent(menuData.subMenus);
            subDropdownContent.className = 'sub-dropdown-content';
            
            div.appendChild(link);
            div.appendChild(subDropdownContent);
        } else {
            const link = document.createElement('a');
            link.className = 'dropdown-link';
            link.href = menuData.url || '#';
            
            const icon = document.createElement('i');
            icon.className = menuData.iconClass || 'fas fa-circle';
            
            const text = document.createElement('span');
            text.className = 'sub-menu-text';
            text.textContent = menuData.menuName;
            
            link.appendChild(icon);
            link.appendChild(text);
            
            div.appendChild(link);
        }
        
        return div;
    }
    
    // Fallback 메뉴 생성
    function createFallbackMenu() {
        return [
            {
                menuId: 'home',
                menuName: '홈',
                menuType: 'LARGE',
                iconClass: 'fas fa-home',
                url: '/',
                subMenus: []
            },
            {
                menuId: 'system',
                menuName: '시스템 관리',
                menuType: 'LARGE',
                iconClass: 'fas fa-cogs',
                url: null,
                subMenus: [
                    {
                        menuId: 'user-mgmt',
                        menuName: '사용자 관리',
                        menuType: 'MEDIUM',
                        iconClass: 'fas fa-users',
                        url: '#',
                        subMenus: []
                    },
                    {
                        menuId: 'system-config',
                        menuName: '시스템 설정',
                        menuType: 'MEDIUM',
                        iconClass: 'fas fa-wrench',
                        url: '#',
                        subMenus: []
                    }
                ]
            }
        ];
    }
    
    // Fallback 메뉴를 지연 로딩으로 표시
    async function loadFallbackMenuWithDelay() {
        console.log('Fallback 메뉴 로딩 중...');
        
        setTimeout(() => {
            const fallbackMenu = createFallbackMenu();
            renderHierarchicalMenu(fallbackMenu);
            console.log('Fallback 메뉴 로딩 완료');
        }, 1000);
    }
    
    // 페이지 로드 시 네비게이션 초기화
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initializeNavbar);
    } else {
        initializeNavbar();
    }
</script>
