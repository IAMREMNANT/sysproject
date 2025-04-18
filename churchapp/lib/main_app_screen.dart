// main_app_screen.dart 파일 수정

import 'package:flutter/material.dart';
// import 되는 페이지 목록
import 'package:churchapp/pages/home_page.dart'; // 홈 페이지 import
import 'package:churchapp/pages/word_page.dart'; // 말씀 페이지 import
import 'package:churchapp/pages/church_intro_page.dart'; // 교회소개 페이지 import
import 'package:churchapp/pages/nextgen_intro_page.dart'; // 후대소개 페이지 import
import 'package:churchapp/pages/administration_page.dart'; // 행정 페이지 import

// Quick Menu/Drawer에서 이동할 페이지들 import
import 'package:churchapp/pages/worship_time_page.dart'; // 예배 시간 페이지 import
import 'package:churchapp/pages/church_weekly_page.dart'; // 교회 주보 페이지 import
import 'package:churchapp/pages/church_news_page.dart'; // 교회 소식 페이지 import
import 'package:churchapp/pages/directions_page.dart'; // 오시는 길 페이지 import

import 'package:churchapp/widgets/app_bottom_navigation_bar.dart'; // 하단 네비게이션 바 위젯 import

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  MainAppScreenState createState() => MainAppScreenState();
}

class MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0; // 현재 선택된 탭의 인덱스 (전체 페이지 인덱스)

  // MainAppScreen이 관리할 모든 페이지 목록
  late final List<Widget> _pages;

  // 각 페이지에 해당하는 AppBar 제목 목록 (AppBar 사용하는 경우)
  static const List<String> _pageTitles = <String>[
    '홈', // index 0 (HomePage)
    '말씀', // index 1 (WordPage)
    '교회 소개', // index 2 (ChurchIntroPage)
    '후대 소개', // index 3 (NextgenIntroPage)
    '행정', // index 4 (AdministrationPage)
    // Quick Menu/Drawer에서 이동할 페이지들 (새로운 인덱스 부여)
    '예배 시간', // index 5 (WorshipTimePage)
    '교회 주보', // index 6 (ChurchWeeklyPage)
    '교회 소식', // index 7 (ChurchNewsPage)
    '오시는 길', // index 8 (DirectionsPage)
    // TODO: 다른 메뉴 항목 페이지가 있다면 여기에 추가하고 인덱스를 부여합니다.
  ];

  // AppBottomNavigationBar가 가질 아이템의 개수 (예: 5개)
  // AppBottomNavigationBar 위젯 내부에서 정의된 items 리스트의 실제 개수와 일치해야 합니다.
  final int _bottomBarItemCount = 5; // 홈, 말씀, 교회소개, 후대소개, 행정 5개라고 가정

  @override
  void initState() {
    super.initState();
    // _pages 리스트 초기화
    _pages = <Widget>[
      HomePage(onNavigateToTab: _onItemTapped), // index 0
      const WordPage(), // index 1
      const ChurchIntroPage(), // index 2
      const NextgenIntroPage(), // index 3
      const AdministrationPage(), // index 4
      const WorshipTimePage(), // index 5
      const ChurchWeeklyPage(), // index 6
      const ChurchNewsPage(), // index 7
      const DirectionsPage(), // index 8
      // TODO: 다른 페이지들도 여기에 추가
    ];

    assert(_pages.length == _pageTitles.length, '페이지 목록과 제목 목록의 개수가 일치해야 합니다.');
    // AppBottomNavigationBar 항목 개수와 메인 페이지 항목 개수의 일관성 확인 (선택 사항)
    assert(
      _bottomBarItemCount <= _pages.length,
      '하단 바 항목 개수는 전체 페이지 개수보다 많을 수 없습니다.',
    );
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // AppBottomNavigationBar에게 전달할 selectedIndex 결정
    // _selectedIndex가 하단 바 아이템의 유효한 인덱스 범위(0부터 _bottomBarItemCount-1) 내에 있으면 그대로 사용
    // 범위를 벗어나면 (예: 퀵 메뉴/드로어에서 인덱스 5, 6, 7, 8로 이동 시)
    // 하단 바에는 어떤 아이템도 선택되지 않도록 하거나, 기본값(예: 0번 홈)을 선택하도록 할 수 있습니다.
    // BottomNavigationBar는 보통 selectedIndex가 items.length보다 작아야 하므로,
    // 범위를 벗어나는 경우 0을 전달하는 것이 안전합니다.
    final int bottomBarSelectedIndex =
        (_selectedIndex >= 0 && _selectedIndex < _bottomBarItemCount)
            ? _selectedIndex // 유효 범위 내이면 해당 인덱스 사용
            : 0; // 유효 범위를 벗어나면 0번(홈)을 선택한 것으로 표시 (또는 다른 기본값)
    // 주의: -1 등을 전달하면 BottomNavigationBar에서 오류가 날 수 있습니다.

    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_selectedIndex]), // AppBar 제목은 전체 페이지 인덱스 따라 변경
        // ... actions 등 다른 AppBar 속성 ...
      ),

      body: IndexedStack(
        index: _selectedIndex, // IndexedStack은 전체 페이지 인덱스 사용 (0-8)
        children: _pages,
      ),

      bottomNavigationBar: AppBottomNavigationBar(
        // 여기에 수정된 bottomBarSelectedIndex를 전달
        selectedIndex: bottomBarSelectedIndex,
        onItemTapped: _onItemTapped, // 탭 시 전체 페이지 인덱스 변경 함수 호출
        // AppBottomNavigationBar 위젯 내부의 items 리스트는 정확히 _bottomBarItemCount 개수로 정의되어야 합니다.
        // 예: items: [item0, item1, item2, item3, item4]
      ),
    );
  }
}
