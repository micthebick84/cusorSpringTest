<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>통계 및 보고서</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- jqxWidgets CSS -->
    <link rel="stylesheet" href="https://jqwidgets.com/public/jqwidgets/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="https://jqwidgets.com/public/jqwidgets/styles/jqx.material-purple.css" type="text/css" />
    
    <!-- jqxWidgets JavaScript -->
    <script src="https://jqwidgets.com/public/jqwidgets/jqx-all.js"></script>
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding-top: 70px; /* 공통 네비게이션 바 높이만큼 패딩 추가 */
        }
        
        .stats-container {
            display: flex;
            height: calc(100vh - 70px);
            gap: 20px;
            padding: 20px;
        }
        
        /* 좌측 그룹 패널 (20%) */
        .group-panel {
            width: 20%;
            min-width: 300px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }
        
        .panel-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .panel-header h3 {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
        }
        
        .panel-content {
            flex: 1;
            padding: 20px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }
        
        /* jqxTreeGrid 컨테이너 */
        .tree-grid-container {
            flex: 1;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            overflow: hidden;
        }
        
        /* 우측 통계 패널 (80%) */
        .stats-panel {
            flex: 1;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }
        
        .stats-content {
            flex: 1;
            padding: 30px;
            overflow-y: auto;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: #f8f9ff;
            border-radius: 12px;
            padding: 25px;
            text-align: center;
            border: 1px solid #e8eaff;
            transition: all 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.15);
        }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            margin: 0 auto 15px;
        }
        
        .stat-number {
            font-size: 32px;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }
        
        .stat-change {
            font-size: 12px;
            padding: 4px 8px;
            border-radius: 12px;
            font-weight: 500;
        }
        
        .stat-change.positive {
            background: #d4edda;
            color: #155724;
        }
        
        .stat-change.negative {
            background: #f8d7da;
            color: #721c24;
        }
        
        /* 차트 영역 */
        .chart-section {
            background: #f8f9ff;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 30px;
        }
        
        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .chart-title {
            font-size: 20px;
            font-weight: 600;
            color: #333;
        }
        
        .chart-controls {
            display: flex;
            gap: 10px;
        }
        
        .chart-btn {
            padding: 8px 16px;
            border: 1px solid #ddd;
            border-radius: 6px;
            background: white;
            color: #666;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 14px;
        }
        
        .chart-btn:hover,
        .chart-btn.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: transparent;
        }
        
        .chart-placeholder {
            height: 300px;
            background: white;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #999;
            font-size: 16px;
            border: 2px dashed #e0e0e0;
        }
        
        /* 로딩 상태 */
        .loading {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px;
            color: #666;
        }
        
        .loading i {
            animation: spin 1s linear infinite;
            margin-right: 10px;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        /* 에러 상태 */
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            margin: 20px;
        }
        
        .error i {
            font-size: 24px;
            margin-bottom: 10px;
        }
        
        /* 새로고침 버튼 */
        .refresh-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 14px;
            margin-top: 15px;
        }
        
        .refresh-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }
        
        .refresh-btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }
        
        /* 반응형 디자인 */
        @media (max-width: 1024px) {
            .stats-container {
                flex-direction: column;
                height: auto;
            }
            
            .group-panel {
                width: 100%;
                min-width: auto;
                height: 400px;
            }
            
            .stats-grid {
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            }
        }
        
        @media (max-width: 768px) {
            .stats-container {
                padding: 10px;
                gap: 10px;
            }
            
            .panel-content,
            .stats-content {
                padding: 15px;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
                gap: 15px;
            }
            
            .stat-card {
                padding: 20px;
            }
        }
        
        /* jqxTreeGrid 커스텀 스타일 */
        .jqx-tree-grid {
            border: none !important;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif !important;
        }
        
        .jqx-tree-grid-cell {
            border-right: 1px solid #e8eaff !important;
            border-bottom: 1px solid #e8eaff !important;
        }
        
        .jqx-tree-grid-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
            color: white !important;
            font-weight: 600 !important;
        }
        
        .jqx-tree-grid-cell:hover {
            background: #f8f9ff !important;
        }
    </style>
</head>
<body>
    <!-- 공통 네비게이션 바 포함 -->
    <jsp:include page="common/navbar.jsp" />
    
    <div class="stats-container">
        <!-- 좌측 그룹 패널 (20%) -->
        <div class="group-panel">
            <div class="panel-header">
                <i class="fas fa-sitemap"></i>
                <h3>그룹 정보</h3>
                <button class="refresh-btn" onclick="refreshGroupData()" id="group-refresh-btn">
                    <i class="fas fa-sync-alt"></i>
                </button>
            </div>
            <div class="panel-content">
                <div class="tree-grid-container">
                    <div id="groupTreeGrid"></div>
                </div>
            </div>
        </div>
        
        <!-- 우측 통계 패널 (80%) -->
        <div class="stats-panel">
            <div class="panel-header">
                <i class="fas fa-chart-line"></i>
                <h3>통계 및 보고서</h3>
            </div>
            <div class="stats-content">
                <!-- 통계 카드들 -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-number" id="total-users">1,247</div>
                        <div class="stat-label">총 사용자</div>
                        <div class="stat-change positive">+12% 이번 달</div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-server"></i>
                        </div>
                        <div class="stat-number" id="active-sessions">89</div>
                        <div class="stat-label">활성 세션</div>
                        <div class="stat-change positive">+5% 어제 대비</div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-database"></i>
                        </div>
                        <div class="stat-number" id="data-usage">2.3TB</div>
                        <div class="stat-label">데이터 사용량</div>
                        <div class="stat-change negative">+8% 이번 주</div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="stat-number" id="uptime">99.9%</div>
                        <div class="stat-label">시스템 가동률</div>
                        <div class="stat-change positive">목표 달성</div>
                    </div>
                </div>
                
                <!-- 차트 섹션 -->
                <div class="chart-section">
                    <div class="chart-header">
                        <h4 class="chart-title">시스템 사용 추이</h4>
                        <div class="chart-controls">
                            <button class="chart-btn active" onclick="changeChart('day')">일간</button>
                            <button class="chart-btn" onclick="changeChart('week')">주간</button>
                            <button class="chart-btn" onclick="changeChart('month')">월간</button>
                        </div>
                    </div>
                    <div class="chart-placeholder">
                        <i class="fas fa-chart-area" style="margin-right: 10px; font-size: 24px;"></i>
                        차트 데이터 로딩 중...
                    </div>
                </div>
                
                <!-- 추가 통계 섹션 -->
                <div class="chart-section">
                    <div class="chart-header">
                        <h4 class="chart-title">그룹별 통계</h4>
                        <div class="chart-controls">
                            <button class="chart-btn active" onclick="updateGroupStats()">
                                <i class="fas fa-sync-alt"></i> 새로고침
                            </button>
                        </div>
                    </div>
                    <div id="group-stats-content" class="chart-placeholder">
                        <i class="fas fa-sitemap" style="margin-right: 10px; font-size: 24px;"></i>
                        그룹을 선택하면 해당 그룹의 통계가 표시됩니다.
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 전역 변수
        let groupTreeGridData = [];
        let selectedGroupId = null;
        
        // 페이지 로드 시 초기화
        $(document).ready(function() {
            initializeGroupTreeGrid();
            loadGroupData();
            
            // 통계 데이터 자동 새로고침 (30초마다)
            setInterval(updateStats, 30000);
        });
        
        // jqxTreeGrid 초기화
        function initializeGroupTreeGrid() {
            const columns = [
                { 
                    text: '그룹명', 
                    dataField: 'grpName', 
                    width: '60%',
                    cellsRenderer: function(row, column, value, data) {
                        const level = data.level || 0;
                        const indent = level * 20;
                        const icon = data.isLeaf ? 'fas fa-folder' : 'fas fa-folder-open';
                        const errorClass = data.err > 0 ? 'style="color: #dc3545;"' : '';
                        
                        return '<div style="margin-left: ' + indent + 'px;">' +
                               '<i class="' + icon + '" style="margin-right: 8px; color: #667eea;"></i>' +
                               '<span ' + errorClass + '>' + value + '</span>' +
                               '</div>';
                    }
                },
                { 
                    text: '장비수', 
                    dataField: 'cnt', 
                    width: '20%',
                    cellsAlign: 'center',
                    cellsRenderer: function(row, column, value) {
                        return '<span style="font-weight: 600; color: #667eea;">' + (value || 0) + '</span>';
                    }
                },
                { 
                    text: '오류', 
                    dataField: 'err', 
                    width: '20%',
                    cellsAlign: 'center',
                    cellsRenderer: function(row, column, value) {
                        if (value > 0) {
                            return '<span style="background: #f8d7da; color: #721c24; padding: 2px 8px; border-radius: 12px; font-size: 12px; font-weight: 600;">' + value + '</span>';
                        }
                        return '<span style="color: #28a745; font-weight: 600;">0</span>';
                    }
                }
            ];
            
            const source = {
                dataType: "json",
                dataFields: [
                    { name: 'grpNo', type: 'string' },
                    { name: 'grpName', type: 'string' },
                    { name: 'grpParent', type: 'string' },
                    { name: 'cnt', type: 'number' },
                    { name: 'err', type: 'number' },
                    { name: 'isLeaf', type: 'number' },
                    { name: 'level', type: 'number' }
                ],
                hierarchy: {
                    keyDataField: { name: 'grpNo' },
                    parentDataField: { name: 'grpParent' }
                },
                id: 'grpNo',
                localData: []
            };
            
            const dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#groupTreeGrid").jqxTreeGrid({
                width: '100%',
                height: '100%',
                source: dataAdapter,
                theme: 'material-purple',
                columns: columns,
                hierarchicalCheckboxes: false,
                checkboxes: false,
                editable: false,
                selectionMode: 'singleRow',
                altRows: true,
                sortable: true,
                filterable: false,
                showHeader: true,
                ready: function() {
                    $("#groupTreeGrid").jqxTreeGrid('expandAll');
                }
            });
            
            // 행 선택 이벤트
            $("#groupTreeGrid").on('rowSelect', function(event) {
                const args = event.args;
                const rowData = args.row;
                selectedGroupId = rowData.grpNo;
                
                console.log('선택된 그룹:', rowData);
                updateGroupStats(rowData);
            });
        }
        
        // 그룹 데이터 로드
        async function loadGroupData() {
            const refreshBtn = document.getElementById('group-refresh-btn');
            
            try {
                if (refreshBtn) {
                    refreshBtn.disabled = true;
                    refreshBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
                }
                
                console.log('그룹 데이터 로딩 시작...');
                
                // Remote-example API 호출
                const baseUrl = 'http://localhost:8080';
                const apiUrl = baseUrl + '/api/grp/default-tree';
                
                console.log('Remote-example 그룹 API 호출:', apiUrl);
                
                const response = await fetch(apiUrl, {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });
                
                if (!response.ok) {
                    throw new Error('그룹 API 호출 실패: HTTP ' + response.status);
                }
                
                const groupData = await response.json();
                console.log('그룹 API 응답 성공:', groupData);
                
                // 데이터 변환 및 TreeGrid 업데이트
                const transformedData = transformGroupData(groupData);
                updateTreeGrid(transformedData);
                
            } catch (error) {
                console.error('그룹 데이터 로딩 실패:', error);
                
                // Fallback 데이터 사용
                const fallbackData = createFallbackGroupData();
                updateTreeGrid(fallbackData);
                
                // 에러 표시
                showError('그룹 데이터 로딩에 실패했습니다. Fallback 데이터를 사용합니다.');
                
            } finally {
                if (refreshBtn) {
                    refreshBtn.disabled = false;
                    refreshBtn.innerHTML = '<i class="fas fa-sync-alt"></i>';
                }
            }
        }
        
        // 그룹 데이터 변환
        function transformGroupData(apiData) {
            if (!Array.isArray(apiData)) {
                console.warn('그룹 API 데이터가 배열이 아님:', typeof apiData);
                return createFallbackGroupData();
            }
            
            return apiData.map((item, index) => {
                // 레벨 계산 (grpParent가 null이면 루트 레벨)
                const level = item.grpParent ? 1 : 0;
                
                return {
                    grpNo: item.grpNo || 'GRP_' + index,
                    grpName: item.grpName || item.grpNameStr || '알 수 없는 그룹',
                    grpParent: item.grpParent || null,
                    cnt: item.cnt || 0,
                    err: item.err || 0,
                    isLeaf: item.isLeaf || 0,
                    level: level,
                    // 추가 정보
                    centerCode: item.centerCode,
                    grpCode: item.grpCode,
                    devKind1: item.devKind1,
                    devKind2: item.devKind2,
                    devIp: item.devIp
                };
            });
        }
        
        // Fallback 그룹 데이터 생성
        function createFallbackGroupData() {
            return [
                {
                    grpNo: 'ROOT',
                    grpName: '전체 시스템',
                    grpParent: null,
                    cnt: 45,
                    err: 2,
                    isLeaf: 0,
                    level: 0
                },
                {
                    grpNo: 'NET_001',
                    grpName: '네트워크 장비',
                    grpParent: 'ROOT',
                    cnt: 20,
                    err: 1,
                    isLeaf: 0,
                    level: 1
                },
                {
                    grpNo: 'SRV_001',
                    grpName: '서버 그룹',
                    grpParent: 'ROOT',
                    cnt: 15,
                    err: 0,
                    isLeaf: 0,
                    level: 1
                },
                {
                    grpNo: 'MON_001',
                    grpName: '모니터링 시스템',
                    grpParent: 'ROOT',
                    cnt: 10,
                    err: 1,
                    isLeaf: 0,
                    level: 1
                },
                {
                    grpNo: 'NET_SW_001',
                    grpName: '스위치',
                    grpParent: 'NET_001',
                    cnt: 8,
                    err: 0,
                    isLeaf: 1,
                    level: 2
                },
                {
                    grpNo: 'NET_RT_001',
                    grpName: '라우터',
                    grpParent: 'NET_001',
                    cnt: 12,
                    err: 1,
                    isLeaf: 1,
                    level: 2
                }
            ];
        }
        
        // TreeGrid 업데이트
        function updateTreeGrid(data) {
            groupTreeGridData = data;
            
            const source = {
                dataType: "json",
                dataFields: [
                    { name: 'grpNo', type: 'string' },
                    { name: 'grpName', type: 'string' },
                    { name: 'grpParent', type: 'string' },
                    { name: 'cnt', type: 'number' },
                    { name: 'err', type: 'number' },
                    { name: 'isLeaf', type: 'number' },
                    { name: 'level', type: 'number' }
                ],
                hierarchy: {
                    keyDataField: { name: 'grpNo' },
                    parentDataField: { name: 'grpParent' }
                },
                id: 'grpNo',
                localData: data
            };
            
            const dataAdapter = new $.jqx.dataAdapter(source);
            $("#groupTreeGrid").jqxTreeGrid('source', dataAdapter);
            
            // 모든 노드 확장
            setTimeout(() => {
                $("#groupTreeGrid").jqxTreeGrid('expandAll');
            }, 100);
            
            console.log('TreeGrid 업데이트 완료, 데이터 개수:', data.length);
        }
        
        // 그룹별 통계 업데이트
        function updateGroupStats(groupData) {
            if (!groupData) {
                document.getElementById('group-stats-content').innerHTML = 
                    '<i class="fas fa-sitemap" style="margin-right: 10px; font-size: 24px;"></i>' +
                    '그룹을 선택하면 해당 그룹의 통계가 표시됩니다.';
                return;
            }
            
            let statsHtml = '<div style="padding: 20px;">';
            statsHtml += '<h4 style="color: #333; margin-bottom: 20px; border-bottom: 2px solid #667eea; padding-bottom: 10px;">';
            statsHtml += '<i class="fas fa-folder-open" style="color: #667eea; margin-right: 10px;"></i>';
            statsHtml += groupData.grpName + ' 상세 정보';
            statsHtml += '</h4>';
            
            statsHtml += '<div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;">';
            
            // 그룹 ID 카드
            statsHtml += '<div style="background: #f8f9ff; padding: 15px; border-radius: 8px; border-left: 4px solid #667eea;">';
            statsHtml += '<div style="font-size: 12px; color: #666; margin-bottom: 5px;">그룹 ID</div>';
            statsHtml += '<div style="font-weight: 600; color: #333;">' + groupData.grpNo + '</div>';
            statsHtml += '</div>';
            
            // 총 장비 수 카드
            statsHtml += '<div style="background: #f8f9ff; padding: 15px; border-radius: 8px; border-left: 4px solid #28a745;">';
            statsHtml += '<div style="font-size: 12px; color: #666; margin-bottom: 5px;">총 장비 수</div>';
            statsHtml += '<div style="font-weight: 600; color: #333; font-size: 18px;">' + (groupData.cnt || 0) + '개</div>';
            statsHtml += '</div>';
            
            // 오류 발생 카드
            const errorColor = groupData.err > 0 ? '#dc3545' : '#28a745';
            statsHtml += '<div style="background: #f8f9ff; padding: 15px; border-radius: 8px; border-left: 4px solid ' + errorColor + ';">';
            statsHtml += '<div style="font-size: 12px; color: #666; margin-bottom: 5px;">오류 발생</div>';
            statsHtml += '<div style="font-weight: 600; color: ' + errorColor + '; font-size: 18px;">' + (groupData.err || 0) + '건</div>';
            statsHtml += '</div>';
            
            // 타입 카드
            statsHtml += '<div style="background: #f8f9ff; padding: 15px; border-radius: 8px; border-left: 4px solid #6f42c1;">';
            statsHtml += '<div style="font-size: 12px; color: #666; margin-bottom: 5px;">타입</div>';
            statsHtml += '<div style="font-weight: 600; color: #333;">' + (groupData.isLeaf ? '말단 그룹' : '상위 그룹') + '</div>';
            statsHtml += '</div>';
            
            statsHtml += '</div>';
            
            // 장비 IP 정보 (있는 경우만)
            if (groupData.devIp) {
                statsHtml += '<div style="margin-top: 20px; padding: 15px; background: #e8f4f8; border-radius: 8px;">';
                statsHtml += '<div style="font-size: 12px; color: #666; margin-bottom: 5px;">장비 IP</div>';
                statsHtml += '<div style="font-weight: 600; color: #333; font-family: monospace;">' + groupData.devIp + '</div>';
                statsHtml += '</div>';
            }
            
            statsHtml += '</div>';
            
            document.getElementById('group-stats-content').innerHTML = statsHtml;
        }
        
        // 그룹 데이터 새로고침
        async function refreshGroupData() {
            await loadGroupData();
        }
        
        // 통계 데이터 업데이트
        function updateStats() {
            // 실제 환경에서는 API에서 데이터를 가져옴
            const stats = {
                totalUsers: Math.floor(Math.random() * 100) + 1200,
                activeSessions: Math.floor(Math.random() * 50) + 50,
                dataUsage: (Math.random() * 0.5 + 2.0).toFixed(1),
                uptime: (Math.random() * 0.1 + 99.9).toFixed(1)
            };
            
            // 애니메이션과 함께 업데이트
            animateNumber('total-users', stats.totalUsers);
            animateNumber('active-sessions', stats.activeSessions);
            document.getElementById('data-usage').textContent = stats.dataUsage + 'TB';
            document.getElementById('uptime').textContent = stats.uptime + '%';
        }
        
        // 숫자 애니메이션
        function animateNumber(elementId, targetValue) {
            const element = document.getElementById(elementId);
            const currentValue = parseInt(element.textContent.replace(/,/g, '')) || 0;
            const increment = (targetValue - currentValue) / 20;
            let current = currentValue;
            
            const timer = setInterval(() => {
                current += increment;
                if ((increment > 0 && current >= targetValue) || (increment < 0 && current <= targetValue)) {
                    current = targetValue;
                    clearInterval(timer);
                }
                element.textContent = Math.floor(current).toLocaleString();
            }, 50);
        }
        
        // 차트 변경
        function changeChart(period) {
            // 버튼 활성화 상태 변경
            document.querySelectorAll('.chart-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');
            
            // 차트 업데이트 (실제 구현에서는 차트 라이브러리 사용)
            const placeholder = document.querySelector('.chart-placeholder');
            const periodText = period === 'day' ? '일간' : period === 'week' ? '주간' : '월간';
            
            placeholder.innerHTML = 
                '<i class="fas fa-chart-area" style="margin-right: 10px; font-size: 24px;"></i>' +
                periodText + ' 차트 로딩 중...';
            
            setTimeout(() => {
                placeholder.innerHTML = 
                    '<i class="fas fa-chart-line" style="margin-right: 10px; font-size: 24px; color: #667eea;"></i>' +
                    periodText + ' 데이터가 여기에 표시됩니다.';
            }, 1000);
        }
        
        // 에러 표시
        function showError(message) {
            const errorDiv = document.createElement('div');
            errorDiv.className = 'error';
            errorDiv.innerHTML = 
                '<i class="fas fa-exclamation-triangle"></i>' +
                '<div>' + message + '</div>';
            
            document.body.appendChild(errorDiv);
            
            setTimeout(() => {
                errorDiv.remove();
            }, 5000);
        }
    </script>
</body>
</html>
