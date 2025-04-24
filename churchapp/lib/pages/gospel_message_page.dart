// lib/pages/gospel_message_page.dart (복음 메세지 메인 페이지 위젯)

import 'package:flutter/material.dart';

// 각 탭에 해당하는 내용 위젯들을 import (실제 경로 확인)
import 'package:churchapp/pages/gaspel_01.dart'; // 사람의 문제 내용 위젯
import 'package:churchapp/pages/gaspel_02.dart'; // 구원의 길 내용 위젯

class GospelMessagePage extends StatefulWidget {
  // IndexedStack에 포함될 페이지이므로 Scaffold, AppBar, BottomNavigationBar는 MainAppScreen에서 관리됩니다.
  // Navigator.push로 호출되지 않으므로 initialTabIndex 파라미터는 여기서 제거합니다.
  // 만약 Drawer에서 특정 탭으로 바로 이동하는 기능을 유지하고 싶다면,
  // 이 페이지가 IndexedStack에서 몇 번 인덱스인지 MainAppScreen에서 알 수 있도록 하고
  // MainAppScreen에서 이 페이지의 TabController를 제어하는 방법(GlobalKey 등)을 사용해야 합니다.
  // 이 방식은 복잡하므로, 여기서는 initialTabIndex를 제거하고 기본 탭(0번)으로 시작하도록 합니다.
  // Drawer에서 '사람의 문제'나 '구원의 길'을 탭하면 이 페이지(GospelMessagePage)로 이동만 하고,
  // 사용자가 직접 탭을 선택하도록 합니다.

  const GospelMessagePage({super.key}); // initialTabIndex 파라미터 제거

  @override
  State<GospelMessagePage> createState() => _GospelMessagePageState();
}

class _GospelMessagePageState extends State<GospelMessagePage> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['사람의 문제', '구원의 길']; // 탭 제목 목록

  @override
  void initState() {
    super.initState();
    // TabController 초기화 (항상 0번 탭으로 시작)
    _tabController = TabController(length: _tabs.length, vsync: this, initialIndex: 0);

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
                // 이미지 하단의 설교 정보 텍스트 (선택된 탭에 따라 변경될 수 있음)
                 Text( // Text는 내용 때문에 const 불가 (동적)
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
    // GospelMessagePage는 Scaffold를 갖지 않고, body의 내용만 반환합니다.
    return Column( // 탭 바와 탭 뷰를 수직으로 배치
      children: [
        // 상단 제목, 이미지, 설교 정보 섹션
        _buildTopSection(), // 상단 정보 빌더 호출
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
              Gaspel01Content(), // 0번 탭: 사람의 문제 내용
              Gaspel02Content(), // 1번 탭: 구원의 길 내용
            ],
          ),
        ),
      ],
    );
  }
}