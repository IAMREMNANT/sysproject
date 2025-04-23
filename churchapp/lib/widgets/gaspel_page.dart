import 'package:flutter/material.dart';

// 각 탭에 해당하는 페이지 위젯들을 import (실제 경로 확인)
import 'package:churchapp/pages/gaspel_01.dart'; // gaspel_01.dart 파일 경로
import 'package:churchapp/pages/gaspel_02.dart'; // gaspel_02.dart 파일 경로

class GaspelPage extends StatefulWidget {
  // Drawer에서 특정 탭으로 바로 이동할 경우 사용될 초기 인덱스 (101, 102, 103)
  // 101 -> 0번 탭 (기본), 102 -> 0번 탭, 103 -> 1번 탭
  final int? initialTabIndex;

  const GaspelPage({super.key, this.initialTabIndex});

  @override
  State<GaspelPage> createState() => _GaspelPageState();
}

class _GaspelPageState extends State<GaspelPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['사람의 문제', '구원의 길']; // 탭 제목 목록

  @override
  void initState() {
    super.initState();
    // 초기 탭 인덱스 설정
    int initialIndex = 0; // 기본값은 0번 탭 ('사람의 문제')

    if (widget.initialTabIndex != null) {
      // Drawer에서 102나 103을 전달했을 때 해당 탭으로 이동
      if (widget.initialTabIndex == 103) { // 구원의 길
        initialIndex = 1;
      }
      // 101 (복음이란 1 Depth 자체 탭)이나 102 (사람의 문제)인 경우 기본값 0 유지
    }

    _tabController = TabController(length: _tabs.length, vsync: this, initialIndex: initialIndex);

    // 탭 변경 리스너 (선택 사항) - 현재 선택된 탭에 따라 상단 설교 정보 변경 로직 등을 여기에 추가할 수 있습니다.
    // _tabController.addListener(() {
    //   if (_tabController.indexIsChanging) {
    //      print('탭 변경됨: ${_tabs[_tabController.index]}');
    //      // TODO: 선택된 탭에 따라 _buildTopSection의 설교 정보 등을 업데이트하는 로직
    //      setState(() { // 상태 변경 필요시 setState 호출
    //        // 예: _currentSermonInfo = _getSermonInfoForTabIndex(_tabController.index);
    //      });
    //   }
    // });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // --- 위젯 빌더 헬퍼 함수들 ---

  // 상단 제목, 이미지, 설교 정보 섹션
  Widget _buildTopSection() {
    // TODO: 선택된 탭에 따라 설교 정보가 변경되도록 상태 관리와 연동 필요
    // 현재는 고정된 정보 표시
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 왼쪽 이미지 (Salvation 이미지)
          // 이미지 경로는 'img/salvation.png' (pubspec.yaml 등록 필수)
          Image.asset(
            'img/salvation.png', // 이미지 경로
            width: 120, // 이미지 너비
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // 이미지 로드 실패 시 대체 위젯
              return Container(
                width: 120, height: 80, // 이미지 크기와 유사하게
                color: Colors.grey[200],
                child: const Icon(Icons.image, color: Colors.grey),
              );
            },
          ),
          const SizedBox(width: 16), // 이미지와 텍스트 사이 간격

          // 오른쪽 정보 텍스트 블록
          Expanded( // 남은 공간을 모두 차지하도록
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
              children: [
                const Text(
                  '복음 메세지', // 상위 페이지 제목
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // 이미지 하단의 설교 정보 텍스트 (선택된 탭에 따라 변경될 수 있음)
                 Text( // Text는 내용 때문에 const 불가 (동적)
                   // 현재 선택된 탭의 제목에 따라 설교 정보 변경 (예시)
                   // _tabController.index를 사용하여 현재 탭 인덱스 접근
                   _tabController.index == 0
                       ? '사람의 문제' // 0번 탭 제목
                       : '구원의 길', // 1번 탭 제목
                   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                 const SizedBox(height: 4),
                 // TODO: 실제 설교 정보를 API 등에서 가져와 표시 (현재는 고정된 예시)
                 const Text('본문: 히브리서 12:14~18', style: TextStyle(fontSize: 14, color: Colors.grey)),
                 const Text('설교자: 강태홍 목사', style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // GaspelPage는 TabBar와 TabBarView를 담는 Scaffold를 가집니다.
    return Scaffold(
      // AppBar는 MainAppScreen에서 관리하므로 여기서는 제거
      // 하지만 이미지상 "복음 메세지" 제목은 AppBar에 있는 것처럼 보입니다.
      // 이는 GaspelPage가 자체 AppBar를 가져야 함을 시사할 수도 있습니다.
      // 현재 MainAppScreen이 AppBar를 관리하므로, GaspelPage는 AppBar를 갖지 않고
      // _buildTopSection에서 "복음 메세지" 제목을 포함하는 것으로 구현했습니다.
      // 만약 MainAppScreen AppBar를 유지하고 싶다면, _buildTopSection에서 "복음 메세지" 제목은 제거해야 합니다.
      // 그리고 MainAppScreen에서 _selectedIndex가 101, 102, 103일 때 AppBar 제목을 "복음 메세지"로 변경하는 로직이 필요합니다.

      body: Column( // 탭 바와 탭 뷰를 수직으로 배치
        children: [
          // 상단 제목, 이미지, 설교 정보 섹션
          _buildTopSection(), // 상단 정보 빌더 호출 (여기서 복음 메세지 제목 포함)
          const SizedBox(height: 10), // 정보 섹션과 탭 바 사이 간격

          // 탭 바
          Container(
            color: Colors.grey[200], // 탭 바 배경색 (이미지 참고)
            child: TabBar(
              controller: _tabController,
              tabs: _tabs.map((String name) => Tab(text: name)).toList(), // 탭 제목들
              labelColor: Colors.black, // 선택된 탭 텍스트 색상
              unselectedLabelColor: Colors.grey[600], // 선택되지 않은 탭 텍스트 색상
              indicatorColor: Colors.black, // 하단 인디케이터 색상
              indicatorWeight: 3.0,
              // 탭 선택 시 동작 (선택된 탭에 따라 UI 업데이트 필요시 _tabController 리스너 활용)
            ),
          ),

          // 탭 뷰 (페이지 내용)
          Expanded( // TabBar를 제외한 남은 공간 모두 차지
            child: TabBarView(
              controller: _tabController,
              // 각 탭에 해당하는 페이지 위젯들을 순서대로 배치
              children: const [ // 자식 위젯들이 모두 const 가능하면 TabBarView도 const 가능
                Gaspel01Page(), // 0번 탭: 사람의 문제
                Gaspel02Page(), // 1번 탭: 구원의 길
              ],
            ),
          ),
        ],
      ),
      // 하단 네비게이션 바는 MainAppScreen에서 관리하므로 여기에 없습니다.
    );
  }
}