// main_app_screen.dart

import 'package:flutter/material.dart';
// <<< url_launcher 패키지 import 추가 >>>
import 'package:url_launcher/url_launcher.dart';


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
  headerMajorTappable,
  itemIndented,
  divider,
}

// 2 Depth 하위 메뉴 항목 데이터 구조 (url 필드 추가)
class DrawerSubItemData {
  final String title;
  final int? targetPageIndex; // 로컬 페이지 이동 (0-8 또는 >=100)
  // <<< url 필드 추가 >>>
  final String? url; // 웹 페이지 이동 URL

  // 생성자 수정: url 필드 추가
  const DrawerSubItemData(this.title, {this.targetPageIndex, this.url});
}

// 1 Depth 주 메뉴 항목 데이터 구조 (동일)
class DrawerMenuItemData {
  final String title;
  final List<DrawerSubItemData> subItems;
  final int? targetPageIndex; // 1 Depth 메뉴 자체를 탭했을 때 이동할 페이지 (선택 사항)
  // TODO: 1 Depth 메뉴 자체도 웹 페이지로 이동하고 싶다면 여기에 url 필드 추가

  const DrawerMenuItemData(this.title, this.subItems, {this.targetPageIndex});
}

// 실제 Drawer 메뉴 구조 데이터 (URL 정보 추가)
const List<DrawerMenuItemData> _drawerMenuData = <DrawerMenuItemData>[
  DrawerMenuItemData('복음이란', [
    DrawerSubItemData('사람의 문제', targetPageIndex: 102),
    DrawerSubItemData('구원의 길', targetPageIndex: 103),
  ], targetPageIndex: 101),

  DrawerMenuItemData('교회소개', [
    DrawerSubItemData('영광교회', targetPageIndex: 2),
    DrawerSubItemData('예배시간', targetPageIndex: 5),
    DrawerSubItemData('섬기는 분들', targetPageIndex: 110),
    DrawerSubItemData('조직&전도회', targetPageIndex: 111),
    DrawerSubItemData('오시는 길', targetPageIndex: 8),
  ], targetPageIndex: 2),

  DrawerMenuItemData('생명의 말씀', [
    DrawerSubItemData('영광교회 강단', targetPageIndex: 1),
    // <<< RUTC 방송 URL 추가 >>>
    DrawerSubItemData('RUTC 방송', url: 'https://www.youtube.com/@rutctv'),
    // <<< 기도수첩 URL 추가 >>>
    DrawerSubItemData('기도수첩', url: 'https://www.youtube.com/playlist?list=PLaDAgDGeV6xPKlYTRSX5qKTEV4bnms9ah'),
  ], targetPageIndex: 1),

  DrawerMenuItemData('새가족 안내', [
    DrawerSubItemData('새가족부 소개', targetPageIndex: 105),
  ], targetPageIndex: 104),

  DrawerMenuItemData('후대사역', [
    DrawerSubItemData('태영아부', targetPageIndex: 130),
    DrawerSubItemData('유아부', targetPageIndex: 131),
    DrawerSubItemData('유치부', targetPageIndex: 132),
    DrawerSubItemData('유초등부', targetPageIndex: 133),
    DrawerSubItemData('청소년부', targetPageIndex: 134),
    DrawerSubItemData('디모데1부(20~26세)', targetPageIndex: 135),
    DrawerSubItemData('디모데2부(26세 이상)', targetPageIndex: 136),
  ], targetPageIndex: 3),

  DrawerMenuItemData('교회소식', [
    DrawerSubItemData('주보', targetPageIndex: 6),
    DrawerSubItemData('교회광고', targetPageIndex: 140),
    DrawerSubItemData('교우소식', targetPageIndex: 141),
    DrawerSubItemData('교회앨범', targetPageIndex: 142),
    // <<< RUTC 광고 URL 추가 >>>
    DrawerSubItemData('RUTC광고', url: 'https://www.youtube.com/playlist?list=PLaDAgDGeV6xM6UaVcTtsDSXFbGm3_6WdX'),
    DrawerSubItemData('교회일정', targetPageIndex: 144),
  ], targetPageIndex: 7),

  DrawerMenuItemData('전도/선교/훈련', [
    DrawerSubItemData('국내사역', targetPageIndex: 150),
    DrawerSubItemData('해외선교', targetPageIndex: 151),
    DrawerSubItemData('성도산업현장', targetPageIndex: 152),
    // <<< 전도자료 URL 추가 >>>
    DrawerSubItemData('전도자료', url: 'https://weeashop.imweb.me/'),
    // <<< 훈련일정표 URL 추가 >>>
    DrawerSubItemData('훈련일정표', url: 'https://calendar.google.com/calendar/u/0/embed?src=infooffice3@gmail.com&ctz=Asia/Seoul&pli=1'),
    // <<< 새가족/현장사역자 URL 추가 >>>
    DrawerSubItemData('새가족/현장사역자', url: 'https://www.weea.kr/'),
  ], targetPageIndex: 106),

  DrawerMenuItemData('부설기관', [
    DrawerSubItemData('Groly Remnant School', targetPageIndex: 160),
    DrawerSubItemData('초등전도신학원', targetPageIndex: 161),
    DrawerSubItemData('청소년전도신학원', targetPageIndex: 162),
    DrawerSubItemData('자살예방연맹', targetPageIndex: 163),
    DrawerSubItemData('부설기관 앨범', targetPageIndex: 164),
  ], targetPageIndex: 107),

  DrawerMenuItemData('행정', [
    DrawerSubItemData('온라인 헌금', targetPageIndex: 170),
    DrawerSubItemData('기부금 영수증', targetPageIndex: 171),
    DrawerSubItemData('문의하기', targetPageIndex: 172),
    DrawerSubItemData('자료실', targetPageIndex: 173),
  ], targetPageIndex: 4),
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

  // 내부 페이지 이동 로직 (IndexedStack 사용)
  void _onItemTapped(int? index) {
    if (index != null && index >= 0 && index < _pages.length) {
      // 기존 페이지 범위 (0-8) 내의 유효한 인덱스인 경우에만 이동
      if (_selectedIndex != index) {
        setState(() {
          _selectedIndex = index;
        });
      }
    }
    // placeholder 인덱스 (>=100)나 기타 유효하지 않은 인덱스는
    // Drawer onTap 핸들러에서 직접 처리하거나 무시합니다.
  }

  // <<< URL 실행 비동기 함수 추가 >>>
  Future<void> _launchURL(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    if (!await canLaunchUrl(uri)) {
       debugPrint('Could not launch $urlString');
       ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('해당 링크를 열 수 없습니다.'),
            duration: Duration(seconds: 2),
          ),
        );
    } else {
       // 새 브라우저 창으로 URL 열기
       await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
  // <<< URL 실행 비동기 함수 끝 >>>


  // --- Drawer 항목 위젯 헬퍼 함수들 ---

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
                  Image.asset(
                    'assets/images/church_logo.png', // 예시 경로, 실제 경로 확인 및 pubspec.yaml 등록 필요
                    height: 40,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.church, size: 40, color: Colors.white);
                    },
                  ),
                  const SizedBox(width: 8),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('대한예수교장로회', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      Text('영광교회', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
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
              debugPrint('로그인하기 탭');
            },
            child: const Row(
              children: [
                CircleAvatar(radius: 18, backgroundColor: Colors.white54, child: Icon(Icons.person, color: Colors.white, size: 20)),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('로그인이 필요합니다.', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    Text('로그인하기', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
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
          Text('영광교회', style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('주소: (10212) 경기도 고양시 일산서구\n 덕이로 209-27(덕이동, 영광교회)', style: TextStyle(color: Colors.white60, fontSize: 13)),
          SizedBox(height: 4),
          Text('Tel: 031-911-7801\nFax: 0503-8379-4464', style: TextStyle(color: Colors.white60, fontSize: 13)),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final int bottomBarSelectedIndex =
        (_selectedIndex >= 0 && _selectedIndex < _bottomBarItemCount) ? _selectedIndex : 0;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () { Scaffold.of(context).openDrawer(); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(_pageTitles[_selectedIndex]),
        actions: [
          IconButton(icon: const Icon(Icons.person), onPressed: () { debugPrint('회원 정보/로그인 아이콘 탭'); }),
          IconButton(icon: const Icon(Icons.search), onPressed: () { debugPrint('검색 아이콘 탭'); }),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _buildCustomDrawerHeader(context),
            for (var menuItem in _drawerMenuData) ...[
              ExpansionTile(
                title: Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 12.0, 0, 12.0),
                  child: Text(menuItem.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                leading: null,
                visualDensity: VisualDensity.compact,
                tilePadding: EdgeInsets.zero,
                children: [
                  for (var subItem in menuItem.subItems)
                    InkWell(
                      // <<< Drawer 항목 탭 로직 수정 >>>
                      onTap: () {
                        Navigator.pop(context); // Drawer 닫기

                        if (subItem.url != null && subItem.url!.isNotEmpty) {
                          // URL이 정의되어 있으면 웹 페이지 열기
                          _launchURL(subItem.url!);
                        } else if (subItem.targetPageIndex != null) {
                          // targetPageIndex가 정의되어 있으면 로컬 페이지 이동
                           _onItemTapped(subItem.targetPageIndex);
                        } else {
                          // URL도 targetPageIndex도 없으면 준비중 메시지 등 표시 (선택 사항)
                           ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('해당 메뉴는 준비 중입니다.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                           debugPrint('Navigation requested for unimplemented or undefined menu: ${subItem.title}');
                        }
                      },
                      child: Container(
                        color: Colors.grey[200],
                        padding: const EdgeInsets.only(left: 32.0, right: 16.0, top: 10.0, bottom: 10.0),
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Text(subItem.title, style: const TextStyle(fontSize: 15)),
                      ),
                    ),
                ],
              ),
              const Divider(height: 1, thickness: 1),
            ],
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