// main_app_screen.dart

import 'package:flutter/material.dart';
// url_launcher 패키지 import
import 'package:url_launcher/url_launcher.dart';

// GaspelPage import
import 'package:churchapp/widgets/gaspel_page.dart'; // GaspelPage가 widgets 폴더에 있으므로 경로 수정

// import 되는 페이지 목록 (IndexedStack에서 사용)
import 'package:churchapp/pages/home_page.dart'; // index 0
import 'package:churchapp/pages/word_page.dart'; // index 1
import 'package:churchapp/pages/church_intro_page.dart'; // index 2
import 'package:churchapp/pages/nextgen_intro_page.dart'; // index 3
import 'package:churchapp/pages/administration_page.dart'; // index 4

// Drawer에서 직접 이동할 페이지들 (IndexedStack index 5-8 또는 Navigator.push로 이동)
import 'package:churchapp/pages/worship_time_page.dart'; // index 5
import 'package:churchapp/pages/church_weekly_page.dart'; // index 6
import 'package:churchapp/pages/church_news_page.dart'; // index 7
import 'package:churchapp/pages/directions_page.dart'; // index 8
// GaspelPage는 100번대 인덱스에 매핑되며 Navigator.push로 이동

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
  final int? targetPageIndex; // 로컬 페이지 이동 (IndexedStack index 또는 100+ placeholder)
  final String? url; // 웹 페이지 이동 URL

  // 생성자 수정: targetPageIndex와 url은 선택적 (named) 매개변수
  const DrawerSubItemData(this.title, {this.targetPageIndex, this.url});
}

// 1 Depth 주 메뉴 항목 데이터 구조
class DrawerMenuItemData {
  final String title;
  final List<DrawerSubItemData> subItems;
  final int? targetPageIndex; // 1 Depth 메뉴 자체를 탭했을 때 이동할 페이지 (선택 사항)
  final String? url; // 1 Depth 메뉴 자체를 탭했을 때 이동할 웹 페이지 (선택 사항)

  // 생성자 수정: targetPageIndex와 url은 선택적 (named) 매개변수
  const DrawerMenuItemData(this.title, this.subItems, {this.targetPageIndex, this.url});
}

// 실제 Drawer 메뉴 구조 데이터 (URL 정보 및 targetPageIndex 매핑 추가)
const List<DrawerMenuItemData> _drawerMenuData = <DrawerMenuItemData>[
  // 복음이란 - 1 Depth (101), 하위 (102: 사람의 문제, 103: 구원의 길) -> GaspelPage로 이동
  DrawerMenuItemData('복음이란', [
    // subItems 리스트 앞에 const 추가
    // targetPageIndex는 GaspelPage의 initialTabIndex로 전달될 인덱스
    DrawerSubItemData('사람의 문제', targetPageIndex: 102), // GaspelPage (0번 탭)
    DrawerSubItemData('구원의 길', targetPageIndex: 103), // GaspelPage (1번 탭)
  ], targetPageIndex: 101), // 복음이란 1 Depth 자체 탭 시 -> GaspelPage (기본 0번 탭)

  // 교회소개 - 1 Depth (2), 하위 (영광교회: 2, 예배시간: 5, 오시는 길: 8, 기타 100+)
  DrawerMenuItemData('교회소개', [
    DrawerSubItemData('영광교회', targetPageIndex: 2), // IndexedStack index 2
    DrawerSubItemData('예배시간', targetPageIndex: 5), // IndexedStack index 5
    DrawerSubItemData('섬기는 분들', targetPageIndex: 110), // Placeholder
    DrawerSubItemData('조직&전도회', targetPageIndex: 111), // Placeholder
    DrawerSubItemData('오시는 길', targetPageIndex: 8), // IndexedStack index 8
  ], targetPageIndex: 2), // IndexedStack index 2

  // 생명의 말씀 - 1 Depth (1), 하위 (영광교회 강단: 1, RUTC 방송: URL, 기도수첩: URL)
  DrawerMenuItemData('생명의 말씀', [
    DrawerSubItemData('영광교회 강단', targetPageIndex: 1), // IndexedStack index 1
    DrawerSubItemData('RUTC 방송', url: 'https://www.youtube.com/@rutctv'), // URL 이동
    DrawerSubItemData('기도수첩', url: 'https://www.youtube.com/playlist?list=PLaDAgDGeV6xPKlYTRSX5qKTEV4bnms9ah'), // URL 이동
  ], targetPageIndex: 1), // IndexedStack index 1

  // 새가족 안내 - 1 Depth (104), 하위 (새가족부 소개: 105)
  DrawerMenuItemData('새가족 안내', [
    DrawerSubItemData('새가족부 소개', targetPageIndex: 105), // Placeholder
  ], targetPageIndex: 104), // Placeholder

  // 후대사역 - 1 Depth (3), 하위 (태영아부 ~ 디모데2부: 130-136)
  DrawerMenuItemData('후대사역', [
    DrawerSubItemData('태영아부', targetPageIndex: 130), // Placeholder
    DrawerSubItemData('유아부', targetPageIndex: 131), // Placeholder
    DrawerSubItemData('유치부', targetPageIndex: 132), // Placeholder
    DrawerSubItemData('유초등부', targetPageIndex: 133), // Placeholder
    DrawerSubItemData('청소년부', targetPageIndex: 134), // Placeholder
    DrawerSubItemData('디모데1부(20~26세)', targetPageIndex: 135), // Placeholder
    DrawerSubItemData('디모데2부(26세 이상)', targetPageIndex: 136), // Placeholder
  ], targetPageIndex: 3), // IndexedStack index 3

  // 교회소식 - 1 Depth (7), 하위 (주보: 6, RUTC광고: URL, 기타 100+)
  DrawerMenuItemData('교회소식', [
    DrawerSubItemData('주보', targetPageIndex: 6), // IndexedStack index 6
    DrawerSubItemData('교회광고', targetPageIndex: 140), // Placeholder
    DrawerSubItemData('교우소식', targetPageIndex: 141), // Placeholder
    DrawerSubItemData('교회앨범', targetPageIndex: 142), // Placeholder
    DrawerSubItemData('RUTC광고', url: 'https://www.youtube.com/playlist?list=PLaDAgDGeV6xM6UaVcTtsDSXFbGm3_6WdX'), // URL 이동
    DrawerSubItemData('교회일정', targetPageIndex: 144), // Placeholder
  ], targetPageIndex: 7), // IndexedStack index 7

  // 전도/선교/훈련 - 1 Depth (106), 하위 (전도자료: URL, 훈련일정표: URL, 새가족/현장사역자: URL, 기타 100+)
  DrawerMenuItemData('전도/선교/훈련', [
    DrawerSubItemData('국내사역', targetPageIndex: 150), // Placeholder
    DrawerSubItemData('해외선교', targetPageIndex: 151), // Placeholder
    DrawerSubItemData('성도산업현장', targetPageIndex: 152), // Placeholder
    DrawerSubItemData('전도자료', url: 'https://weeashop.imweb.me/'), // URL 이동
    DrawerSubItemData('훈련일정표', url: 'https://calendar.google.com/calendar/u/0/embed?src=infooffice3@gmail.com&ctz=Asia/Seoul&pli=1'), // URL 이동
    DrawerSubItemData('새가족/현장사역자', url: 'https://www.weea.kr/'), // URL 이동
  ], targetPageIndex: 106), // Placeholder

  // 부설기관 - 1 Depth (107), 하위 (160-164)
  DrawerMenuItemData('부설기관', [
    DrawerSubItemData('Groly Remnant School', targetPageIndex: 160), // Placeholder
    DrawerSubItemData('초등전도신학원', targetPageIndex: 161), // Placeholder
    DrawerSubItemData('청소년전도신학원', targetPageIndex: 162), // Placeholder
    DrawerSubItemData('자살예방연맹', targetPageIndex: 163), // Placeholder
    DrawerSubItemData('부설기관 앨범', targetPageIndex: 164), // Placeholder
  ], targetPageIndex: 107), // Placeholder

  // 행정 - 1 Depth (4), 하위 (170-173)
  DrawerMenuItemData('행정', [
    DrawerSubItemData('온라인 헌금', targetPageIndex: 170), // Placeholder
    DrawerSubItemData('기부금 영수증', targetPageIndex: 171), // Placeholder
    DrawerSubItemData('문의하기', targetPageIndex: 172), // Placeholder
    DrawerSubItemData('자료실', targetPageIndex: 173), // Placeholder
  ], targetPageIndex: 4), // IndexedStack index 4
];


class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  MainAppScreenState createState() => MainAppScreenState();
}

class MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0; // IndexedStack의 현재 인덱스 (0-8 범위)

  // BottomNavigationBar 및 IndexedStack에서 사용할 페이지 목록 (0-8 범위)
  late final List<Widget> _pages;

  // BottomNavigationBar 및 AppBar 제목에 사용할 페이지 제목 목록 (0-8 범위)
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
  ];

  final int _bottomBarItemCount = 5; // 하단 네비게이션 바 항목 개수 (0-4 범위에 해당)

  @override
  void initState() {
    super.initState();
    // IndexedStack에서 사용할 0-8 범위의 페이지 인스턴스 생성
    _pages = <Widget>[
      HomePage(onNavigateToTab: _onItemTapped), // index 0 (BottomBar)
      const WordPage(), // index 1 (BottomBar)
      const ChurchIntroPage(), // index 2 (BottomBar)
      const NextgenIntroPage(), // index 3 (BottomBar)
      const AdministrationPage(), // index 4 (BottomBar)
      const WorshipTimePage(showBanner: true), // index 5 (Drawer direct)
      const ChurchWeeklyPage(), // index 6 (Drawer direct)
      const ChurchNewsPage(), // index 7 (Drawer direct)
      const DirectionsPage(), // index 8 (Drawer direct)
      // 100+번대 페이지들은 _pages에 포함되지 않고 Drawer에서 Navigator.push로 이동
    ];

    // _pages 리스트 길이와 _pageTitles 길이가 일치하는지 확인
    assert(_pages.length == _pageTitles.length, '페이지 목록과 제목 목록의 개수가 일치해야 합니다.');
    // 하단 바 항목 개수가 유효한지 확인
    assert(
      _bottomBarItemCount >= 0 && _bottomBarItemCount <= _pageTitles.length, // 하단 바 개수는 제목 목록 범위 내
      '하단 바 항목 개수는 전체 페이지 개수 범위 내에 있어야 합니다.',
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  // IndexedStack 내에서 페이지 이동 (0-8 범위의 인덱스만 처리)
  // 주로 BottomNavigationBar 항목 탭 또는 HomePage에서의 콜백에 의해 호출됨
  void _onItemTapped(int? index) {
    // index가 유효하고 _pages 리스트 범위 내에 있는지 확인 (0-8)
    // BottomNavigationBar 항목 인덱스(0-4) 또는 Drawer direct tap 인덱스(5-8) 처리
    if (index != null && index >= 0 && index < _pages.length) {
      if (_selectedIndex != index) {
        setState(() {
          _selectedIndex = index;
        });
        // IndexedStack 페이지 이동 시 Drawer 닫기 (선택 사항)
        // Navigator.pop(context); // 여기서는 Drawer 닫기 로직을 onTap 핸들러에 두었습니다.
      }
    } else {
       // _pages 범위를 벗어나는 인덱스(100+번대)는 이 함수에서 처리하지 않음.
       // 해당 페이지들은 Drawer onTap 핸들러에서 직접 Navigator.push 등으로 처리합니다.
       debugPrint('Navigation request ignored for index outside IndexedStack range: $index');
    }
  }

  // URL 실행 비동기 함수 (외부 브라우저로 열기)
  Future<void> _launchURL(String urlString) async {
    // URL 파싱 및 유효성 검사
    final Uri uri = Uri.parse(urlString);
    try {
      // launchUrl 메서드 호출 시 에러 핸들링 추가
      final bool launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

      // <<< 여기서 mounted 체크를 추가합니다. >>>
      if (!mounted) {
        debugPrint('Widget disposed after launching URL attempt.');
        return; // 위젯이 제거되었으면 더 이상 진행하지 않습니다.
      }
      // <<< mounted 체크 끝 >>>

      if (launched) {
        debugPrint('Successfully launched $urlString');
      } else {
        // launchUrl이 false를 반환할 때 (앱을 찾을 수 없거나 URL 형식이 잘못된 경우 등)
        debugPrint('Could not launch $urlString');
        ScaffoldMessenger.of(context).showSnackBar( // Line 225 근처
           const SnackBar(
             content: Text('해당 링크를 열 수 없습니다.'),
             duration: Duration(seconds: 2), // 메시지 표시 시간
           ),
         );
      }
    } catch (e) {
      // 예외 발생 시 처리 (예: 잘못된 URL 형식으로 Uri.parse 실패 등)
      debugPrint('Error launching URL $urlString: $e');
      // <<< catch 블록에서도 mounted 체크를 추가하는 것이 더 안전합니다. >>>
      if (!mounted) {
        debugPrint('Widget disposed after URL launch exception.');
        return; // 위젯이 제거되었으면 더 이상 진행하지 않습니다.
      }
      // <<< mounted 체크 끝 >>>
       ScaffoldMessenger.of(context).showSnackBar( // Line 235 근처
         const SnackBar(
           content: Text('잘못된 링크 형식입니다.'),
           duration: Duration(seconds: 2),
         ),
       );
    }
  }

  // --- Drawer 항목 위젯 헬퍼 함수들 ---

  // 커스텀 Drawer 헤더 빌더
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
                onPressed: () => Navigator.pop(context), // 닫기 버튼
              ),
            ],
          ),
          const Spacer(), // 남은 공간을 채워 아래 로그인 정보가 바닥에 붙도록 함
          InkWell(
            onTap: () {
              Navigator.pop(context); // Drawer 닫기
              debugPrint('로그인하기 탭'); // TODO: 로그인 페이지 이동 로직 구현
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

  // Drawer 하단 연락처 정보 위젯
  Widget _buildBottomDrawerInfo() {
    return Container(
      color: Colors.grey[800], // 배경색
      padding: const EdgeInsets.all(16.0), // 내부 패딩
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 내용 왼쪽 정렬
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

  // --- 헬퍼 함수 끝 ---

  @override
  Widget build(BuildContext context) {
    // 하단 네비게이션 바에서 현재 선택된 항목 인덱스 계산 (0-4 범위)
    final int bottomBarSelectedIndex =
        (_selectedIndex >= 0 && _selectedIndex < _bottomBarItemCount) ? _selectedIndex : 0;

    return Scaffold(
      // 앱바 (AppBar)
      appBar: AppBar(
        // 메뉴 아이콘 (Drawer 열기 버튼)
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () { Scaffold.of(context).openDrawer(); }, // Drawer 열기
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip, // 접근성 도구 팁
            );
          },
        ),
        // 앱바 제목 (현재 선택된 페이지 제목)
        // _selectedIndex가 _pageTitles의 유효 범위(0-8)를 벗어나면 기본 제목 표시
        title: Text((_selectedIndex >= 0 && _selectedIndex < _pageTitles.length) ? _pageTitles[_selectedIndex] : '교회 앱'), // 유효 범위 벗어나면 기본 제목
        // 앱바 우측 아이콘들
        actions: [
          IconButton(icon: const Icon(Icons.person), onPressed: () { debugPrint('회원 정보/로그인 아이콘 탭'); }), // TODO: 회원 정보/로그인 페이지 이동
          IconButton(icon: const Icon(Icons.search), onPressed: () { debugPrint('검색 아이콘 탭'); }), // TODO: 검색 기능 구현
        ],
      ),

      // Drawer (측면 서랍 메뉴)
      drawer: Drawer(
        // ListView를 사용하여 스크롤 가능한 메뉴 목록 생성
        child: ListView(
          padding: EdgeInsets.zero, // ListView 기본 상단/하단 패딩 제거
          children: <Widget>[
            // 1. 커스텀 헤더 추가
            _buildCustomDrawerHeader(context),

            // 2. Drawer 메뉴 항목들을 데이터 기반으로 빌드 (ExpansionTile 사용)
            for (var menuItem in _drawerMenuData) ...[ // _drawerMenuData 리스트 순회
              // ExpansionTile 위젯으로 1 Depth 메뉴 생성
              ExpansionTile(
                // 1 Depth 메뉴 헤더 (제목)
                title: Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 12.0, 0, 12.0), // 왼쪽 패딩 추가
                  child: Text(
                    menuItem.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                leading: null, // 기본 왼쪽 아이콘 제거
                visualDensity: VisualDensity.compact, // 시각적 밀도 조정
                tilePadding: EdgeInsets.zero, // 기본 타일 패딩 제거

                 // <<< 1 Depth 메뉴 자체 탭 시 로직 (onTap 제거됨) >>>
                 // ExpansionTile 위젯은 'onTap' 매개변수를 제공하지 않습니다.
                 // 1 Depth 메뉴 자체 탭 시 페이지 이동을 원하면 title 위젯을 InkWell로 감싸야 합니다.
                 // 현재는 하위 메뉴를 탭했을 때만 페이지 이동/URL 실행이 됩니다.


                // 하위 메뉴들 (ExpansionTile의 children)
                children: [
                  for (var subItem in menuItem.subItems)
                    InkWell(
                      // <<< 2 Depth 메뉴 InkWell 탭 로직 >>>
                      onTap: () {
                        Navigator.pop(context); // Drawer 닫기

                        if (subItem.url != null && subItem.url!.isNotEmpty) {
                          // URL이 정의되어 있으면 웹 페이지 열기
                          _launchURL(subItem.url!);
                        } else if (subItem.targetPageIndex != null) {
                           // targetPageIndex가 정의되어 있으면 해당 페이지로 이동
                           final int targetIndex = subItem.targetPageIndex!;

                           if (targetIndex >= 101 && targetIndex <= 103) {
                              // '복음이란' 관련 100번대 인덱스 (101, 102, 103)는 GaspelPage로 이동 (새 화면)
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   // 101 -> initialTabIndex: 101 (GaspelPage에서 0번 탭으로 매핑)
                                   // 102 -> initialTabIndex: 102 (GaspelPage에서 0번 탭으로 매핑)
                                   // 103 -> initialTabIndex: 103 (GaspelPage에서 1번 탭으로 매핑)
                                   builder: (context) => GaspelPage(initialTabIndex: targetIndex),
                                 ),
                               );
                           } else if (targetIndex >= 0 && targetIndex < _pages.length) {
                              // 0-8 범위의 인덱스는 IndexedStack으로 이동
                             _onItemTapped(targetIndex);
                           }
                           else {
                              // 정의되었지만 구현되지 않은 100+번대 Placeholder 인덱스 (101-103 제외)
                             ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('해당 메뉴는 준비 중입니다.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              debugPrint('Navigation requested for unimplemented 2 Depth page index: $targetIndex');
                           }
                        } else {
                          // URL도 targetPageIndex도 없는 경우 (데이터 오류 또는 기획 변경)
                           ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('해당 메뉴는 준비 중입니다.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                           debugPrint('Navigation requested for undefined 2 Depth menu: ${subItem.title}');
                        }
                      },
                      child: Container(
                        color: Colors.grey[200], // 회색 배경
                        padding: const EdgeInsets.only(left: 32.0, right: 16.0, top: 10.0, bottom: 10.0), // 왼쪽 들여쓰기 패딩
                        width: double.infinity, // 가로 전체 채우기
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
              const Divider(height: 1, thickness: 1),
            ],

            // 3. 하단 정보 추가 (리스트 끝에 위치)
            _buildBottomDrawerInfo(),
          ],
        ),
      ),

      // 바디 (현재 선택된 페이지 내용)
      body: IndexedStack(index: _selectedIndex, children: _pages),

      // 하단 네비게이션 바
      bottomNavigationBar: AppBottomNavigationBar(
        selectedIndex: bottomBarSelectedIndex, // 하단 바에 표시할 선택된 인덱스 (0-4 범위)
        onItemTapped: (index) {
           // 하단 바 항목 탭 시 (0-4 범위 인덱스가 넘어옴)
           // IndexedStack 페이지 이동 함수 호출
           _onItemTapped(index);
           // 하단 바 탭 시 Drawer 닫기 (선택 사항, 보통 Drawer는 열려있지 않으므로 불필요)
           // Navigator.pop(context);
        },
      ),
    );
  }
}