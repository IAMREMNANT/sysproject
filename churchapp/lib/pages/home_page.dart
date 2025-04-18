import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart'; // flip_card 패키지 import
// AppBottomNavigationBar는 MainAppScreen에서 관리하므로 여기서 임포트 안 합니다.
// import 'package:churchapp/widgets/app_bottom_navigation_bar.dart';

// Quick Menu/Drawer에서 이동할 페이지들은 MainAppScreen에서 관리하므로
// 여기서는 더 이상 직접 import 하지 않습니다.
//import 'package:churchapp/pages/worship_time_page.dart';
//import 'package:churchapp/pages/church_weekly_page.dart';
//import 'package:churchapp/pages/church_news_page.dart';
//import 'package:churchapp/pages/directions_page.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int>? onNavigateToTab;
  const HomePage({super.key, this.onNavigateToTab});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // Quick 메뉴 아이템 탭 시 해당 페이지로 이동 (Navigator 대신 콜백 사용)
  Widget _buildQuickMenuItem(IconData icon, String label, int targetIndex) {
    return InkWell(
      onTap: () {
        // 콜백 함수가 null이 아니고, 전달받았으면 호출합니다.
        // MainAppScreen에게 targetIndex 페이지를 보여달라고 요청합니다.
        widget.onNavigateToTab?.call(targetIndex);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[200],
            child: Icon(icon, size: 30, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // Drawer 항목 탭 시 해당 페이지로 이동 (Navigator 대신 콜백 사용)
  ListTile _buildDrawerItem(IconData icon, String title, int targetIndex) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context); // Drawer 닫기
        // 콜백 함수가 null이 아니고, 전달받았으면 호출합니다.
        widget.onNavigateToTab?.call(targetIndex);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // HomePage 자체에 Scaffold를 포함하여 AppBar를 가집니다.
    return Scaffold(
      // 1. App Bar (HomePage에만 필요하므로 여기에 정의)
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Drawer는 이 Scaffold에 연결됩니다.
                Scaffold.of(context).openDrawer(); // Drawer 열기
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // TODO: 회원 정보/로그인 화면 이동 (Navigator 사용)
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: 검색 기능 (Navigator 사용)
            },
          ),
        ],
        // title: Text('교회 앱'), // 이미지에 타이틀 없음
      ),
      // Drawer (햄버거 버튼 메뉴) - HomePage Scaffold에 연결
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue, // 드로어 헤더 색상
              ),
              child: Text(
                '메뉴',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            // Drawer 항목에서 Navigator.push 대신 콜백 사용
            _buildDrawerItem(Icons.home, '홈', 0), // 홈은 보통 0번 인덱스라고 가정
            _buildDrawerItem(Icons.calendar_today, '예배 시간', 5), // 예: 1번 인덱스
            _buildDrawerItem(Icons.article, '교회 주보', 6), // 예: 2번 인덱스
            _buildDrawerItem(Icons.campaign, '교회 소식', 7), // 예: 3번 인덱스
            _buildDrawerItem(Icons.flag, '오시는 길', 8), // 예: 4번 인덱스
            // TODO: Add more menu items and navigation logic
          ],
        ),
      ),
      // body (HomePage의 내용만 담당, 하단 바는 MainAppScreen에서 관리)
      // body (HomePage의 내용만 담당, 하단 바는 MainAppScreen에서 관리)
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 2. 메인 배너 (경로 확인)
            Image.asset(
              'img/MainBanner.png', // pubspec.yaml에 등록된 경로와 일치해야 함
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Text('메인 배너 이미지를 불러오지 못했습니다.'));
              },
            ),

            // 3. Quick 메뉴
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  // Quick 메뉴 아이템 탭 시 해당 페이지로 이동 (Navigator 대신 콜백 사용)
                  _buildQuickMenuItem(
                    Icons.schedule,
                    '예배시간',
                    5,
                  ), // 예: 1번 인덱스로 이동
                  _buildQuickMenuItem(
                    Icons.article,
                    '교회주보',
                    6,
                  ), // 예: 2번 인덱스로 이동
                  _buildQuickMenuItem(
                    Icons.campaign,
                    '교회소식',
                    7,
                  ), // 예: 3번 인덱스로 이동
                  _buildQuickMenuItem(Icons.flag, '오시는 길', 8), // 예: 4번 인덱스로 이동
                ],
              ),
            ),

            const Divider(height: 1, color: Colors.grey),

            // 생명의 말씀 섹션
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '생명의 말씀',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10), // 제목 아래 공간
                  // --- 이미지 삽입 위치 ---
                  Image.asset(
                    'img/msg_250316.png', // 프로젝트 내 img 폴더에 있는 이미지 파일 경로
                    width: double.infinity, // 가로 전체 채우기
                    fit: BoxFit.cover, // 이미지 비율 유지하며 채우기
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Text('말씀 이미지를 불러오지 못했습니다.'),
                      ); // 오류 메시지
                    },
                  ),
                  const SizedBox(height: 10), // 이미지 아래 공간
                  // 말씀 내용 Container...
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      // const 추가 가능
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '영적 싸움 (213)',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '주의 강림과 죽은 자의 부활',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('설교자: 강태홍 목사', style: TextStyle(fontSize: 15)),
                        Text('일시: 2025.03.16', style: TextStyle(fontSize: 15)),
                        Text(
                          '성구: 데살로니가전서 4장 13~18절',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Colors.grey),

            // 교회 소식 섹션
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '교회 소식',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildNewsItem('안내', '신년 특별 새벽기도회 안내', 'YYYY.MM.DD'),
                  const Divider(height: 16),
                  _buildNewsItem('소식', '김복음 권사님의 자녀 최오복의 결혼예배', 'YYYY.MM.DD'),
                  const Divider(height: 16),
                  _buildNewsItem('안내', '선교주일 특별헌금 안내', 'YYYY.MM.DD'),
                  // TODO: 더 많은 소식 항목 추가
                ],
              ),
            ),

            const Divider(height: 1, color: Colors.grey),

            // 4. 전도/선교/훈련 섹션 (플립 카드)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // 이 컬럼 자체는 제목을 왼쪽 정렬
                children: [
                  const Text(
                    '전도/선교/훈련',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // --- 여기부터 수정 ---
                  LayoutBuilder(
                    // 부모(Padding)의 최대 너비를 얻기 위해 사용
                    builder: (context, constraints) {
                      // 플립 카드 하나의 너비
                      const double cardWidth = 100;
                      // 카드 사이의 기본 간격 (스크롤될 때 사용)
                      const double cardSpacing = 10;
                      // 카드의 개수 (현재 3개)
                      const int cardCount = 3;

                      // 카드들의 총 최소 너비 + 카드 사이 간격의 총합
                      final double minContentWidth =
                          (cardWidth * cardCount) +
                          (cardSpacing * (cardCount - 1));

                      // LayoutBuilder가 제공하는 사용 가능한 최대 너비 (Padding 내부 너비)
                      final double availableWidth = constraints.maxWidth;

                      // Row가 가져야 할 너비: 사용 가능 너비 vs 최소 내용 너비 중 더 큰 값 (스크롤 때문에)
                      final double rowWidth =
                          availableWidth > minContentWidth
                              ? availableWidth
                              : minContentWidth;

                      // Row의 mainAxisAlignment: 사용 가능 너비가 충분하면 균등 분배, 아니면 시작점 정렬
                      final MainAxisAlignment rowAlignment =
                          availableWidth > minContentWidth
                              ? MainAxisAlignment
                                  .spaceEvenly // 사용 가능 너비 > 최소 너비 => 균등 분배
                              : MainAxisAlignment
                                  .start; // 사용 가능 너비 <= 최소 너비 => 왼쪽 정렬 (스크롤 가능)

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          // SingleChildScrollView의 자식인 Row의 너비를 강제 지정
                          width: rowWidth,
                          child: Row(
                            mainAxisAlignment: rowAlignment, // 위에서 결정된 정렬 방식 사용
                            children: <Widget>[
                              _buildFlipCard(
                                '전도 자료',
                                'img/card_back_1.png',
                              ), // 경로 확인
                              // 스크롤 모드일 때만 간격 추가 (spaceEvenly 모드일 때는 Row가 간격 처리)
                              if (rowAlignment == MainAxisAlignment.start)
                                const SizedBox(width: cardSpacing),
                              _buildFlipCard(
                                '선교 현황',
                                'img/card_back_2.png',
                              ), // 경로 확인
                              if (rowAlignment == MainAxisAlignment.start)
                                const SizedBox(width: cardSpacing),
                              _buildFlipCard(
                                '훈련 일정',
                                'img/card_back_3.png',
                              ), // 경로 확인
                              // TODO: 필요에 따라 카드 추가
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // 5. 하단 배너 (경로 확인)
            Image.asset(
              'img/BottomBanner.png', // pubspec.yaml에 등록된 경로와 일치해야 함
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Text('하단 배너 이미지를 불러오지 못했습니다.'));
              },
            ),
            const SizedBox(height: 20), // 하단 네비바에 가려지지 않도록 공간 추가
          ],
        ),
      ),
      // 하단 네비게이션 바는 MainAppScreen에서 관리하므로 여기서는 제거합니다.
      // bottomNavigationBar: AppBottomNavigationBar(...), // 이 줄 제거
    );
  }

  // Quick 메뉴 아이템 위젯 생성 함수 (Navigator.push 사용)

  // 교회 소식 항목 위젯 생성 함수
  Widget _buildNewsItem(String category, String title, String date) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            category,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                date,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 플립 카드 위젯 생성 함수
  Widget _buildFlipCard(String frontText, String backImagePath) {
    // 이 함수는 State 클래스 내부에 그대로 유지 (StatefulWidget에 속하므로)
    return SizedBox(
      width: 100,
      height: 120,
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        flipOnTouch: true,
        front: Container(
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              frontText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        back: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              backImagePath, // 전달받은 이미지 경로 사용
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Text('이미지 로드 실패'));
              },
            ),
          ),
        ),
      ),
    );
  }
}
