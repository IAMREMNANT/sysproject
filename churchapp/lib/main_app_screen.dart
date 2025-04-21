// main_app_screen.dart

import 'package:flutter/material.dart';

// import 되는 페이지 목록
import 'package:churchapp/pages/home_page.dart';
import 'package:churchapp/pages/word_page.dart';
import 'package:churchapp/pages/church_intro_page.dart';
import 'package:churchapp/pages/nextgen_intro_page.dart';
import 'package:churchapp/pages/administration_page.dart';

// Quick Menu/Drawer에서 이동할 페이지들
import 'package:churchapp/pages/worship_time_page.dart';
import 'package:churchapp/pages/church_weekly_page.dart';
import 'package:churchapp/pages/church_news_page.dart';
import 'package:churchapp/pages/directions_page.dart';

import 'package:churchapp/widgets/app_bottom_navigation_bar.dart';

// --- Drawer 메뉴 항목 데이터 구조 ---
enum DrawerItemType {
  headerMajorTappable, // 하얀 배경, 굵은 글씨, 화살표, 탭 가능 (예: 교회소개)
  itemIndented, // 회색 배경, 일반 글씨, 들여쓰기, 탭 가능 (예: 예배시간)
  divider, // 구분선
}

// 2 Depth 하위 메뉴 항목 데이터 구조 (이전과 동일)
class DrawerSubItemData {
  final String title; // 하위 메뉴 텍스트
  final int? targetPageIndex; // 이동할 페이지의 _pages 리스트 인덱스 (0-8 또는 >=100)

  const DrawerSubItemData(this.title, this.targetPageIndex);
}

// 1 Depth 주 메뉴 항목 데이터 구조 (수정됨)
class DrawerMenuItemData {
  final String title; // 1 Depth 메뉴 텍스트
  final List<DrawerSubItemData> subItems; // 하위 메뉴 목록
  final int? targetPageIndex; // 1 Depth 메뉴 자체를 탭했을 때 이동할 페이지 (선택 사항)

  // 생성자 수정: this.this.subItems 오타 수정 및 모든 final 변수 초기화
  const DrawerMenuItemData(this.title, this.subItems, {this.targetPageIndex});
}

// 실제 Drawer 메뉴 구조 데이터 (이미지 기반 - 계층적으로 재구성, 생성자 호출 수정)
const List<DrawerMenuItemData> _drawerMenuData = <DrawerMenuItemData>[
  DrawerMenuItemData('복음이란', [
    // subItems 리스트 앞에 const 추가
    DrawerSubItemData('사람의 문제', 102),
    DrawerSubItemData('구원의 길', 103),
  ], targetPageIndex: 101), // targetPageIndex를 명명된 매개변수로 전달

  DrawerMenuItemData('교회소개', [
    // subItems 리스트 앞에 const 추가
    DrawerSubItemData('영광교회', 2),
    DrawerSubItemData('예배시간', 5),
    DrawerSubItemData('섬기는 분들', 110),
    DrawerSubItemData('조직&전도회', 111),
    DrawerSubItemData('오시는 길', 8),
  ], targetPageIndex: 2), // targetPageIndex를 명명된 매개변수로 전달

  DrawerMenuItemData('생명의 말씀', [
    // subItems 리스트 앞에 const 추가
    DrawerSubItemData('영광교회 강단', 1),
    DrawerSubItemData('RUTC 방송', 120),
    DrawerSubItemData('기도수첩', 121),
  ], targetPageIndex: 1), // targetPageIndex를 명명된 매개변수로 전달

  DrawerMenuItemData('새가족 안내', [
    // subItems 리스트 앞에 const 추가
    DrawerSubItemData('새가족부 소개', 105),
  ], targetPageIndex: 104), // targetPageIndex를 명명된 매개변수로 전달

  DrawerMenuItemData('후대사역', [
    // subItems 리스트 앞에 const 추가
    DrawerSubItemData('태영아부', 130),
    DrawerSubItemData('유아부', 131),
    DrawerSubItemData('유치부', 132),
    DrawerSubItemData('유초등부', 133),
    DrawerSubItemData('청소년부', 134),
    DrawerSubItemData('디모데1부(20~26세)', 135),
    DrawerSubItemData('디모데2부(26세 이상)', 136),
  ], targetPageIndex: 3), // targetPageIndex를 명명된 매개변수로 전달

  DrawerMenuItemData('교회소식', [
    // subItems 리스트 앞에 const 추가
    DrawerSubItemData('주보', 6),
    DrawerSubItemData('교회광고', 140),
    DrawerSubItemData('교우소식', 141),
    DrawerSubItemData('교회앨범', 142),
    DrawerSubItemData('RUTC광고', 143),
    DrawerSubItemData('교회일정', 144),
  ], targetPageIndex: 7), // targetPageIndex를 명명된 매개변수로 전달

  DrawerMenuItemData('전도/선교/훈련', [
    // subItems 리스트 앞에 const 추가
    DrawerSubItemData('국내사역', 150),
    DrawerSubItemData('해외선교', 151),
    DrawerSubItemData('성도산업현장', 152),
    DrawerSubItemData('전도자료', 153),
    DrawerSubItemData('훈련일정표', 154),
    DrawerSubItemData('새가족/현장사역자', 155),
  ], targetPageIndex: 106), // targetPageIndex를 명명된 매개변수로 전달

  DrawerMenuItemData('부설기관', [
    // subItems 리스트 앞에 const 추가
    DrawerSubItemData('Groly Remnant School', 160),
    DrawerSubItemData('초등전도신학원', 161),
    DrawerSubItemData('청소년전도신학원', 162),
    DrawerSubItemData('자살예방연맹', 163),
    DrawerSubItemData('부설기관 앨범', 164),
  ], targetPageIndex: 107), // targetPageIndex를 명명된 매개변수로 전달

  DrawerMenuItemData('행정', [
    // subItems 리스트 앞에 const 추가
    DrawerSubItemData('온라인 헌금', 170),
    DrawerSubItemData('기부금 영수증', 171),
    DrawerSubItemData('문의하기', 172),
    DrawerSubItemData('자료실', 173),
  ], targetPageIndex: 4), // targetPageIndex를 명명된 매개변수로 전달
];

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  MainAppScreenState createState() => MainAppScreenState();
}

class MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  static const List<String> _pageTitles = <String>[
    '홈', // index 0
    '말씀', // index 1
    '교회 소개', // index 2
    '후대 소개', // index 3
    '행정', // index 4
    '예배 시간', // index 5
    '교회 주보', // index 6
    '교회 소식', // index 7
    '오시는 길', // index 8
    // TODO: 새로운 페이지(.dart 파일)를 만들면 여기에 제목도 추가
  ];

  final int _bottomBarItemCount = 5;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      HomePage(onNavigateToTab: _onItemTapped), // index 0
      const WordPage(), // index 1
      const ChurchIntroPage(), // index 2
      const NextgenIntroPage(), // index 3
      const AdministrationPage(), // index 4
      const WorshipTimePage(showBanner: true), // index 5
      const ChurchWeeklyPage(), // index 6
      const ChurchNewsPage(), // index 7
      const DirectionsPage(), // index 8
      // TODO: 새로운 페이지 위젯 인스턴스를 여기에 추가 (_pageTitles와 순서 일치)
    ];

    assert(_pages.length == _pageTitles.length, '페이지 목록과 제목 목록의 개수가 일치해야 합니다.');
    assert(
      _bottomBarItemCount >= 0 && _bottomBarItemCount <= _pages.length,
      '하단 바 항목 개수는 전체 페이지 개수 범위 내에 있어야 합니다.',
    );
  }

  void _onItemTapped(int? index) {
    if (index != null) {
      if (index >= 0 && index < _pages.length) {
        // 기존 페이지 범위 (0-8) 내의 유효한 인덱스인 경우
        if (_selectedIndex != index) {
          setState(() {
            _selectedIndex = index;
          });
        }
      } else {
        // 구현되지 않은 페이지 (placeholder 인덱스 >= 100)인 경우
        debugPrint('Navigation requested for unimplemented page index: $index');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('해당 메뉴는 준비 중입니다.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // --- Drawer 항목 위젯 헬퍼 함수 ---

  // 커스텀 Drawer 헤더 빌더 (이전과 동일)
  Widget _buildCustomDrawerHeader(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 8),
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // TODO: 실제 교회 로고 이미지 경로 및 크기 설정
                  // 이미지 경로를 실제 프로젝트에 맞게 수정해야 합니다.
                  // 예를 들어 'assets/images/church_logo.png'
                  // 그리고 pubspec.yaml 파일의 assets 섹션에 등록해야 합니다.
                  Image.asset(
                    // '++img/church_logo.png', // <- 이 경로를 수정하세요!
                    'assets/images/church_logo.png', // 예시 경로
                    height: 40,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.church,
                        size: 40,
                        color: Colors.white,
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '대한예수교장로회',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      Text(
                        '영광교회',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              // TODO: 로그인 페이지로 이동 로직 구현
              debugPrint('로그인하기 탭');
            },
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white54,
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '로그인이 필요합니다.',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    Text(
                      '로그인하기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Drawer 하단 연락처 정보 위젯 (이전과 동일)
  Widget _buildBottomDrawerInfo() {
    return Container(
      color: Colors.grey[800],
      padding: const EdgeInsets.all(16.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '영광교회',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '주소: (10212) 경기도 고양시 일산서구\n 덕이로 209-27(덕이동, 영광교회)',
            style: TextStyle(color: Colors.white60, fontSize: 13),
          ),
          SizedBox(height: 4),
          Text(
            'Tel: 031-911-7801\nFax: 0503-8379-4464',
            style: TextStyle(color: Colors.white60, fontSize: 13),
          ),
        ],
      ),
    );
  }

  // --- 헬퍼 함수 끝 ---

  @override
  Widget build(BuildContext context) {
    final int bottomBarSelectedIndex =
        (_selectedIndex >= 0 && _selectedIndex < _bottomBarItemCount)
            ? _selectedIndex
            : 0;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(_pageTitles[_selectedIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              debugPrint('회원 정보/로그인 아이콘 탭');
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              debugPrint('검색 아이콘 탭');
            },
          ),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // 1. 커스텀 헤더 추가
            _buildCustomDrawerHeader(context),

            // 2. Drawer 메뉴 항목들을 데이터 기반으로 빌드 (ExpansionTile 사용)
            // _drawerMenuData (1 Depth 메뉴 리스트)를 순회합니다.
            for (var menuItem in _drawerMenuData) ...[
              // ExpansionTile 위젯으로 1 Depth 메뉴 생성
              ExpansionTile(
                // 1 Depth 메뉴 헤더 (제목)
                title: Container(
                  // ==== 여기를 수정했습니다 ====
                  padding: const EdgeInsets.fromLTRB(16.0, 12.0, 0, 12.0), // 왼쪽 패딩 추가
                  // ===========================
                  child: Text(
                    menuItem.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // 기본 ExpansionTile은 왼쪽 아이콘과 오른쪽 화살표가 있습니다.
                // 이미지상 오른쪽 화살표만 있으므로 leading 위젯을 null로 지정
                leading: null,
                // 기본 ExpansionTile의 시각적 밀도 조정 (이미지와 유사하게)
                visualDensity: VisualDensity.compact, // 더 작은 패딩
                tilePadding: EdgeInsets.zero, // 기본 타일 패딩 제거 (Container에서 패딩 관리)

                // 하위 메뉴들 (ExpansionTile의 children)
                children: [
                  // 각 1 Depth 메뉴의 subItems 리스트를 순회하며 2 Depth 항목 생성
                  for (var subItem in menuItem.subItems)
                    // InkWell로 감싸서 탭 효과 및 동작 추가
                    InkWell(
                      onTap: () {
                        Navigator.pop(context); // Drawer 닫기
                        _onItemTapped(subItem.targetPageIndex); // 해당 페이지로 이동 요청
                      },
                      child: Container(
                        // 이미지상 2 Depth 항목은 회색 배경, 들여쓰기된 형태
                        color: Colors.grey[200], // 회색 배경
                        padding: const EdgeInsets.only(
                          left: 32.0, // 왼쪽 들여쓰기 패딩 (1Depth보다 더 들어가도록)
                          right: 16.0,
                          top: 10.0,
                          bottom: 10.0,
                        ),
                        width: double.infinity, // 가로 전체 채우기 (InkWell에 필요)
                        alignment: Alignment.centerLeft, // 텍스트 왼쪽 정렬
                        child: Text(
                          subItem.title,
                          style: const TextStyle(fontSize: 15), // 일반 글씨
                        ),
                      ),
                    ),
                ],
              ),
              // 각 1 Depth ExpansionTile 뒤에 구분선 추가 (이미지상 구조)
              const Divider(height: 1, thickness: 1), // 구분선 두께 추가하여 더 명확하게
            ],

            // 3. 하단 정보 추가 (리스트 끝에 위치)
            _buildBottomDrawerInfo(),
          ],
        ),
      ),

      body: IndexedStack(index: _selectedIndex, children: _pages),

      bottomNavigationBar: AppBottomNavigationBar(
        selectedIndex: bottomBarSelectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}