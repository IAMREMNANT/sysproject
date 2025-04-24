// main_app_screen.dart

import 'package:flutter/material.dart';
// url_launcher 패키지 import
import 'package:url_launcher/url_launcher.dart';

// <<< GaspelPage import 제거 >>>
// import 'package:churchapp/widgets/gaspel_page.dart'; // 이 줄 삭제

// <<< GospelMessagePage import 추가 >>>
import 'package:churchapp/pages/gospel_message_page.dart'; // 새로운 메인 페이지 import

// import 되는 페이지 목록 (IndexedStack에서 사용)
import 'package:churchapp/pages/home_page.dart'; // index 0

// <<< WordPage는 index 1이 아니라 다른 인덱스로 밀리거나 gospel_message_page가 WordPage를 대체함 >>>
// 이미지상 복음메세지가 말씀 페이지와 같은 자리에 옵니다.
// 따라서 IndexedStack에서 WordPage가 있던 index 1 자리에 GospelMessagePage를 넣습니다.
// 원래 WordPage는 Drawer에서 '영광교회 강단' 메뉴를 통해 접근하도록 유지합니다.
import 'package:churchapp/pages/word_page.dart'; // index 1 (Drawer direct)

import 'package:churchapp/pages/church_intro_page.dart'; // index 2
import 'package:churchapp/pages/nextgen_intro_page.dart'; // index 3
import 'package:churchapp/pages/administration_page.dart'; // index 4

// Drawer에서 직접 이동할 페이지들 (IndexedStack index 5-8 또는 Navigator.push로 이동)
import 'package:churchapp/pages/worship_time_page.dart'; // index 5
import 'package:churchapp/pages/church_weekly_page.dart'; // index 6
import 'package:churchapp/pages/church_news_page.dart'; // index 7
import 'package:churchapp/pages/directions_page.dart'; // index 8
// GospelMessagePage는 index 1 에 포함됨

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

  const DrawerSubItemData(this.title, {this.targetPageIndex, this.url});
}

// 1 Depth 주 메뉴 항목 데이터 구조
class DrawerMenuItemData {
  final String title;
  final List<DrawerSubItemData> subItems;
  final int? targetPageIndex; // 1 Depth 메뉴 자체를 탭했을 때 이동할 페이지 (선택 사항)
  final String? url; // 1 Depth 메뉴 자체를 탭했을 때 이동할 웹 페이지 (선택 사항)

  const DrawerMenuItemData(this.title, this.subItems, {this.targetPageIndex, this.url});
}

// 실제 Drawer 메뉴 구조 데이터 (URL 정보 및 targetPageIndex 매핑 추가)
const List<DrawerMenuItemData> _drawerMenuData = <DrawerMenuItemData>[
  // 복음이란 - 1 Depth (101), 하위 (102: 사람의 문제, 103: 구원의 길)
  // 모두 IndexedStack index 1 (GospelMessagePage)으로 이동
  DrawerMenuItemData('복음이란', [
    const DrawerSubItemData('사람의 문제', targetPageIndex: 1), // IndexedStack index 1 (GospelMessagePage)
    const DrawerSubItemData('구원의 길', targetPageIndex: 1), // IndexedStack index 1 (GospelMessagePage)
  ], targetPageIndex: 1), // 복음이란 1 Depth 자체 탭 시 -> IndexedStack index 1

  // 교회소개 - 1 Depth (2), 하위 (영광교회: 2, 예배시간: 5, 오시는 길: 8, 기타 100+)
  DrawerMenuItemData('교회소개', [
    const DrawerSubItemData('영광교회', targetPageIndex: 2), // IndexedStack index 2
    const DrawerSubItemData('예배시간', targetPageIndex: 5), // IndexedStack index 5
    const DrawerSubItemData('섬기는 분들', targetPageIndex: 110), // Placeholder
    const DrawerSubItemData('조직&전도회', targetPageIndex: 111), // Placeholder
    const DrawerSubItemData('오시는 길', targetPageIndex: 8), // IndexedStack index 8
  ], targetPageIndex: 2), // IndexedStack index 2

  // 생명의 말씀 - 1 Depth (1), 하위 (영광교회 강단: 1, RUTC 방송: URL, 기도수첩: URL)
  // WordPage는 이제 Drawer에서 영광교회 강단을 통해 IndexedStack index 1로 이동
  // 이미지상 '말씀' 페이지 인덱스 1은 복음 메세지 페이지가 가져가므로, 영광교회 강단은 다른 인덱스 고려 또는 직접 _onItemTapped(1) 호출
  // '영광교회 강단'을 통해 원래 '말씀' 페이지(WordPage)로 이동하려면, WordPage를 IndexedStack에 다른 인덱스로 넣거나
  // Drawer에서 직접 _onItemTapped(1)을 호출하도록 해야 합니다. (현재 index 1은 복음메세지)
  // 여기서는 '영광교회 강단' 메뉴를 탭하면 WordPage(원래 말씀 페이지)로 이동하도록 하고, IndexedStack에서 index 1은 GospelMessagePage가 가져가도록 합니다.
  // 따라서 _pages 리스트에 WordPage가 다시 index 1이 아닌 다른 곳에 있어야 합니다.
  // 복잡해지므로, WordPage를 IndexedStack에 그대로 두고 (index 1), GospelMessagePage는 Drawer 메뉴에서만 접근하도록 하겠습니다.
  // 아니면, GospelMessagePage가 index 1을 대체하고, WordPage는 Drawer에서만 접근 가능한 인덱스로 옮깁니다.

  // <<< 제안: IndexedStack index 1은 GospelMessagePage로 변경. WordPage는 IndexedStack에서 제거하고 Drawer에서만 접근 가능한 인덱스 부여 >>>
  // _pages 리스트 및 _pageTitles 리스트 수정 필요.
  // 하지만 기존 _pageTitles에 '말씀'이 index 1로 고정되어 있습니다.
  // 가장 간단한 방법은 _pageTitles를 유지하고, _pages 리스트에서 index 1에 GospelMessagePage를 넣고,
  // 기존 WordPage는 Drawer에서만 접근하도록 하는 것입니다.

  // <<< 수정: _pageTitles의 '말씀' (index 1)은 이제 GospelMessagePage를 가리킵니다. WordPage는 다른 인덱스로 이동하거나 IndexedStack에서 제외합니다. >>>
  // _pages 리스트 초기화 부분을 수정합니다.

  DrawerMenuItemData('생명의 말씀', [
    // '영광교회 강단'은 원래 말씀 페이지(WordPage)로 이동하도록 (WordPage의 새 인덱스 필요)
    // WordPage가 IndexedStack에 그대로 index 1로 있다고 가정하고, GospelMessagePage는 101번대로 이동하는게 단순할 수 있습니다.
    // 하지만 이미지 구조상 GospelMessagePage가 index 1인게 자연스럽습니다.
    // WordPage를 IndexedStack에서 제외하고, Drawer에서만 접근하도록 하겠습니다. (예: index 115)
    const DrawerSubItemData('영광교회 강단', targetPageIndex: 115), // WordPage로 이동 (Placeholder)
    const DrawerSubItemData('RUTC 방송', url: 'https://www.youtube.com/@rutctv'), // URL 이동
    const DrawerSubItemData('기도수첩', url: 'https://www.youtube.com/playlist?list=PLaDAgDGeV6xPKlYTRSX5qKTEV4bnms9ah'), // URL 이동
  ], targetPageIndex: 115), // IndexedStack index 1 (복음메세지)가 아닌 WordPage로 이동 (Placeholder)

  // 새가족 안내 - 1 Depth (104), 하위 (새가족부 소개: 105)
  DrawerMenuItemData('새가족 안내', [
    const DrawerSubItemData('새가족부 소개', targetPageIndex: 105), // Placeholder
  ], targetPageIndex: 104), // Placeholder

  // 후대사역 - 1 Depth (3), 하위 (태영아부 ~ 디모데2부: 130-136)
  DrawerMenuItemData('후대사역', [
    const DrawerSubItemData('태영아부', targetPageIndex: 130), // Placeholder
    const DrawerSubItemData('유아부', targetPageIndex: 131), // Placeholder
    const DrawerSubItemData('유치부', targetPageIndex: 132), // Placeholder
    const DrawerSubItemData('유초등부', targetPageIndex: 133), // Placeholder
    const DrawerSubItemData('청소년부', targetPageIndex: 134), // Placeholder
    const DrawerSubItemData('디모데1부(20~26세)', targetPageIndex: 135), // Placeholder
    const DrawerSubItemData('디모데2부(26세 이상)', targetPageIndex: 136), // Placeholder
  ], targetPageIndex: 3), // IndexedStack index 3

  // 교회소식 - 1 Depth (7), 하위 (주보: 6, RUTC광고: URL, 기타 100+)
  DrawerMenuItemData('교회소식', [
    const DrawerSubItemData('주보', targetPageIndex: 6), // IndexedStack index 6
    const DrawerSubItemData('교회광고', targetPageIndex: 140), // Placeholder
    const DrawerSubItemData('교우소식', targetPageIndex: 141), // Placeholder
    const DrawerSubItemData('교회앨범', targetPageIndex: 142), // Placeholder
    const DrawerSubItemData('RUTC광고', url: 'https://www.youtube.com/playlist?list=PLaDAgDGeV6xM6UaVcTtsDSXFbGm3_6WdX'), // URL 이동
    const DrawerSubItemData('교회일정', targetPageIndex: 144), // Placeholder
  ], targetPageIndex: 7), // IndexedStack index 7

  // 전도/선교/훈련 - 1 Depth (106), 하위 (전도자료: URL, 훈련일정표: URL, 새가족/현장사역자: URL, 기타 100+)
  DrawerMenuItemData('전도/선교/훈련', [
    const DrawerSubItemData('국내사역', targetPageIndex: 150), // Placeholder
    const DrawerSubItemData('해외선교', targetPageIndex: 151), // Placeholder
    const DrawerSubItemData('성도산업현장', targetPageIndex: 152), // Placeholder
    const DrawerSubItemData('전도자료', url: 'https://weeashop.imweb.me/'), // URL 이동
    const DrawerSubItemData('훈련일정표', url: 'https://calendar.google.com/calendar/u/0/embed?src=infooffice3@gmail.com&ctz=Asia/Seoul&pli=1'), // URL 이동
    const DrawerSubItemData('새가족/현장사역자', url: 'https://www.weea.kr/'), // URL 이동
  ], targetPageIndex: 106), // Placeholder

  // 부설기관 - 1 Depth (107), 하위 (160-164)
  DrawerMenuItemData('부설기관', [
    const DrawerSubItemData('Groly Remnant School', targetPageIndex: 160), // Placeholder
    const DrawerSubItemData('초등전도신학원', targetPageIndex: 161), // Placeholder
    const DrawerSubItemData('청소년전도신학원', targetPageIndex: 162), // Placeholder
    const DrawerSubItemData('자살예방연맹', targetPageIndex: 163), // Placeholder
    const DrawerSubItemData('부설기관 앨범', targetPageIndex: 164), // Placeholder
  ], targetPageIndex: 107), // Placeholder

  // 행정 - 1 Depth (4), 하위 (170-173)
  DrawerMenuItemData('행정', [
    const DrawerSubItemData('온라인 헌금', targetPageIndex: 170), // Placeholder
    const DrawerSubItemData('기부금 영수증', targetPageIndex: 171), // Placeholder
    const DrawerSubItemData('문의하기', targetPageIndex: 172), // Placeholder
    const DrawerSubItemData('자료실', targetPageIndex: 173), // Placeholder
  ], targetPageIndex: 4), // IndexedStack index 4
];


class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  MainAppScreenState createState() => MainAppScreenState();
}

class MainAppScreenState extends State<MainAppScreen> {
  // IndexedStack의 현재 인덱스 (0-8 범위)
  // _selectedIndex가 100 이상이 될 일은 없습니다 (IndexedStack 페이지 인덱스만 저장).
  int _selectedIndex = 0;

  // BottomNavigationBar 및 IndexedStack에서 사용할 페이지 목록 (0-8 범위)
  // IndexedStack에 직접 넣는 페이지들만 여기에 정의합니다.
  // Drawer에서 Navigator.push로 이동하는 페이지(100+번대)는 여기에 포함하지 않습니다.
  // GospelMessagePage가 index 1에 포함됩니다. WordPage는 IndexedStack에서 제외.
  late final List<Widget> _indexedStackPages;

  // BottomNavigationBar 및 AppBar 제목에 사용할 페이지 제목 목록 (0-8 범위)
  static const List<String> _pageTitles = <String>[
    '홈', // index 0
    '복음 메세지', // index 1 (<- '말씀' 대신 '복음 메세지'로 변경)
    '교회 소개', // index 2
    '후대 소개', // index 3
    '행정', // index 4
    '예배 시간', // index 5
    '교회 주보', // index 6
    '교회 소식', // index 7
    '오시는 길', // index 8
    // WordPage는 _pageTitles에 없습니다.
  ];

  final int _bottomBarItemCount = 5; // 하단 네비게이션 바 항목 개수 (0-4 범위에 해당)

  @override
  void initState() {
    super.initState();
    // IndexedStack에서 사용할 0-8 범위의 페이지 인스턴스 생성
    // GospelMessagePage가 index 1에 포함됩니다.
    // WordPage는 IndexedStack에서 제외됩니다.
    _indexedStackPages = <Widget>[
      HomePage(onNavigateToTab: _onItemTapped), // index 0 (BottomBar)
      const GospelMessagePage(), // <<< index 1 (BottomBar, '복음 메세지') >>>
      const ChurchIntroPage(), // index 2 (BottomBar)
      const NextgenIntroPage(), // index 3 (BottomBar)
      const AdministrationPage(), // index 4 (BottomBar)
      const WorshipTimePage(showBanner: true), // index 5 (Drawer direct)
      const ChurchWeeklyPage(), // index 6 (Drawer direct)
      const ChurchNewsPage(), // index 7 (Drawer direct)
      const DirectionsPage(), // index 8 (Drawer direct)
      // WordPage (원래 index 1)는 IndexedStack에서 제외됩니다.
      // 100+번대 페이지들은 _pages에 포함되지 않고 Drawer에서 Navigator.push로 이동
    ];

    // _indexedStackPages 리스트 길이와 _pageTitles 길이가 일치하는지 확인 (둘 다 9개)
    assert(_indexedStackPages.length == _pageTitles.length, 'IndexedStack 페이지 목록과 제목 목록의 개수가 일치해야 합니다.');
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
    // index가 유효하고 _indexedStackPages 리스트 범위 내에 있는지 확인 (0-8)
    // BottomNavigationBar 항목 인덱스(0-4) 또는 Drawer direct tap 인덱스(5-8) 처리
    if (index != null && index >= 0 && index < _indexedStackPages.length) {
      if (_selectedIndex != index) {
        setState(() {
          _selectedIndex = index;
        });
        // IndexedStack 페이지 이동 시 Drawer 닫기 (선택 사항)
        // Navigator.pop(context); // 여기서는 Drawer 닫기 로직을 onTap 핸들러에 두었습니다.
      }
    } else {
       // _indexedStackPages 범위를 벗어나는 인덱스(100+번대)는 이 함수에서 처리하지 않음.
       // 해당 페이지들은 Drawer onTap 핸들러에서 직접 Navigator.push 등으로 처리합니다.
       debugPrint('Navigation request ignored for index outside IndexedStack range: $index');
    }
  }

  // URL 실행 비동기 함수 (외부 브라우저로 열기) - 유지
  Future<void> _launchURL(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    try {
      final bool launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!mounted) { debugPrint('Widget disposed after launching URL attempt.'); return; }
      if (launched) {
        debugPrint('Successfully launched $urlString');
      } else {
        debugPrint('Could not launch $urlString');
        if (!mounted) { debugPrint('Widget disposed after URL launch failure.'); return; }
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('해당 링크를 열 수 없습니다.'), duration: Duration(seconds: 2)));
      }
    } catch (e) {
      debugPrint('Error launching URL $urlString: $e');
      if (!mounted) { debugPrint('Widget disposed after URL launch exception.'); return; }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('잘못된 링크 형식입니다.'), duration: Duration(seconds: 2)));
    }
  }

  // --- Drawer 항목 위젯 헬퍼 함수들 ---

  // 커스텀 Drawer 헤더 빌더 - 유지
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
                  Image.asset('assets/images/church_logo.png', height: 40, errorBuilder: (context, error, stackTrace) { return const Icon(Icons.church, size: 40, color: Colors.white); }),
                  const SizedBox(width: 8),
                  const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ Text('대한예수교장로회', style: TextStyle(color: Colors.white70, fontSize: 12)), Text('영광교회', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)), ]),
                ],
              ),
              IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context)),
            ],
          ),
          const Spacer(),
          InkWell(onTap: () { Navigator.pop(context); debugPrint('로그인하기 탭'); }, child: const Row(children: [ CircleAvatar(radius: 18, backgroundColor: Colors.white54, child: Icon(Icons.person, color: Colors.white, size: 20)), SizedBox(width: 8), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ Text('로그인이 필요합니다.', style: TextStyle(color: Colors.white70, fontSize: 12)), Text('로그인하기', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)), ]), ]), ),
        ],
      ),
    );
  }

  // Drawer 하단 연락처 정보 위젯 - 유지
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

  // --- 헬퍼 함수 끝 ---

  @override
  Widget build(BuildContext context) {
    // 하단 네비게이션 바에서 현재 선택된 항목 인덱스 계산 (0-4 범위)
    final int bottomBarSelectedIndex =
        (_selectedIndex >= 0 && _selectedIndex < _bottomBarItemCount) ? _selectedIndex : 0;

    return Scaffold(
      // 앱바 (AppBar)
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) { return IconButton(icon: const Icon(Icons.menu), onPressed: () { Scaffold.of(context).openDrawer(); }, tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip); }),
        // 앱바 제목 (현재 선택된 페이지 제목)
        // _selectedIndex가 _pageTitles의 유효 범위(0-8)를 벗어나면 기본 제목 표시
        title: Text((_selectedIndex >= 0 && _selectedIndex < _pageTitles.length) ? _pageTitles[_selectedIndex] : '교회 앱'),
        actions: [
          IconButton(icon: const Icon(Icons.person), onPressed: () { debugPrint('회원 정보/로그인 아이콘 탭'); }),
          IconButton(icon: const Icon(Icons.search), onPressed: () { debugPrint('검색 아이콘 탭'); }),
        ],
      ),

      // Drawer (측면 서랍 메뉴)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _buildCustomDrawerHeader(context),
            for (var menuItem in _drawerMenuData) ...[
              ExpansionTile(
                title: Container(padding: const EdgeInsets.fromLTRB(16.0, 12.0, 0, 12.0), child: Text(menuItem.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                leading: null, visualDensity: VisualDensity.compact, tilePadding: EdgeInsets.zero,

                 // 1 Depth 메뉴 자체 탭 시 로직 (onTap 제거됨)


                children: [
                  for (var subItem in menuItem.subItems)
                    InkWell(
                      // <<< 2 Depth 메뉴 InkWell 탭 로직 >>>
                      onTap: () {
                        Navigator.pop(context); // Drawer 닫기

                        if (subItem.url != null && subItem.url!.isNotEmpty) {
                          _launchURL(subItem.url!);
                        } else if (subItem.targetPageIndex != null) {
                           final int targetIndex = subItem.targetPageIndex!;

                           // 복음이란 관련 100번대 인덱스 (101, 102, 103)는 GospelMessagePage (index 1)로 이동
                           if (targetIndex >= 101 && targetIndex <= 103) {
                               // _onItemTapped 호출하여 IndexedStack index 1로 이동
                               _onItemTapped(1);
                               // GospelMessagePage 내부에서 initialTabIndex 처리 로직은 이제 필요 없습니다.
                               // GospelMessagePage는 항상 기본 탭(0)으로 시작합니다.
                               // specific tab deep-linking from Drawer to IndexedStack tab is complex
                           }
                           // IndexedStack 범위의 인덱스 (0-8)는 IndexedStack으로 이동
                           else if (targetIndex >= 0 && targetIndex < _indexedStackPages.length) {
                             _onItemTapped(targetIndex);
                           }
                           // 정의되었지만 구현되지 않은 100+번대 Placeholder 인덱스 (101-103 제외)
                           else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('해당 메뉴는 준비 중입니다.'), duration: Duration(seconds: 2)));
                              debugPrint('Navigation requested for unimplemented 2 Depth page index: $targetIndex');
                           }
                        } else {
                           // URL도 targetPageIndex도 없는 경우 (데이터 오류 또는 기획 변경)
                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('해당 메뉴는 준비 중입니다.'), duration: Duration(seconds: 2)));
                           debugPrint('Navigation requested for undefined 2 Depth menu: ${subItem.title}');
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

      // 바디 (현재 선택된 페이지 내용)
      body: IndexedStack(index: _selectedIndex, children: _indexedStackPages),

      // 하단 네비게이션 바
      bottomNavigationBar: AppBottomNavigationBar(
        selectedIndex: bottomBarSelectedIndex,
        onItemTapped: (index) {
           _onItemTapped(index);
        },
      ),
    );
  }
}