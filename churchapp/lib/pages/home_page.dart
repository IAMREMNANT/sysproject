// home_page.dart

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart'; // flip_card 패키지 import
// 불필요한 import들은 모두 제거합니다.

class HomePage extends StatefulWidget {
  // MainAppScreen에서 네비게이션 요청을 보낼 콜백 함수
  // Drawer/Quick Menu 항목 탭 시 호출됩니다.
  final ValueChanged<int>? onNavigateToTab;

  const HomePage({super.key, this.onNavigateToTab});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // 이 위젯은 더 이상 Scaffold를 가지지 않습니다.
  // 따라서 AppBar, Drawer 정의는 MainAppScreen으로 이동합니다.

  // Quick 메뉴 아이템 탭 시 해당 페이지로 이동 (콜백 사용)
  // 이 함수는 Quick Menu UI를 빌드하는 데 사용됩니다.
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

  // Drawer 항목 탭 시 해당 페이지로 이동 (콜백 사용)
  // 이 함수는 MainAppScreen의 Drawer를 빌드하는 데 사용될 수 있습니다.
  // HomePageState 내부에 정의되어 있으므로, 이 클래스 밖에서 사용하려면
  // static으로 만들거나 별도 파일로 분리해야 할 수 있습니다.
  // 현재 위치에서는 HomePageState 인스턴스를 통해 접근해야 합니다.
  // 가장 좋은 방법은 Drawer 위젯 자체를 MainAppScreen으로 옮기고,
  // 그곳에서 Drawer 항목의 onTap 콜백을 구현하는 것입니다.
  // (MainAppScreenState 내부에 이 로직을 두는 것이 자연스러움)
  // 아래 코드는 Drawer 항목 UI 자체만 반환하도록 변경했습니다.
  // onTap 로직은 이 함수를 사용하는 곳(MainAppScreen)에서 제공해야 합니다.
  ListTile buildDrawerItem(
    IconData icon,
    String title,
    int targetIndex,
    BuildContext context,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      // onTap 로직은 MainAppScreen에서 구현될 것입니다.
      // 예: onTap: () { Navigator.pop(context); widget.onNavigateToTab?.call(targetIndex); }
      // 따라서 onTap: () {} 또는 onTap: null 로 비워두고,
      // MainAppScreen에서 Drawer를 만들 때 이 함수를 호출하고 onTap 콜백을 연결해야 합니다.
      onTap: () {
        // 여기서 context는 ListTile이 빌드되는 위젯 트리 Context입니다.
        // Drawer를 닫는 로직은 MainAppScreen의 Scaffold에 연결된 Drawer에서
        // 실행되어야 합니다.
        Navigator.pop(context); // Drawer 닫기
        // 부모에게 페이지 전환 요청
        widget.onNavigateToTab?.call(targetIndex);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // HomePage는 더 이상 Scaffold를 반환하지 않고,
    // MainAppScreen의 Scaffold body에 들어갈 내용만 반환합니다.
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 2. 메인 배너 (경로 확인, pubspec.yaml 등록 필수)
          Image.asset(
            'img/MainBanner.png', // 예: img 폴더 대신 assets/images 사용
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
                // Quick 메뉴 아이템 탭 시 해당 페이지로 이동 (콜백 사용)
                _buildQuickMenuItem(Icons.schedule, '예배시간', 5),
                _buildQuickMenuItem(Icons.article, '교회주보', 6),
                _buildQuickMenuItem(Icons.campaign, '교회소식', 7),
                _buildQuickMenuItem(Icons.flag, '오시는 길', 8),
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
                const SizedBox(height: 10),
                // --- 이미지 삽입 위치 (경로 확인, pubspec.yaml 등록 필수) ---
                Image.asset(
                  'img/msg_250316.png', // 예: assets/images 사용
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Text('말씀 이미지를 불러오지 못했습니다.'));
                  },
                ),
                const SizedBox(height: 10),
                // 말씀 내용 Container...
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
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
                // TODO: 더 많은 소식 항목 추가 (리스트뷰 등으로 변경 고려)
              ],
            ),
          ),

          const Divider(height: 1, color: Colors.grey),

          // 4. 전도/선교/훈련 섹션 (플립 카드)
          Padding(
            padding: const EdgeInsets.all(16.0), // 좌우 패딩 추가
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '전도/선교/훈련',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // --- 플립 카드 레이아웃 수정 ---
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // 가로 스크롤 활성화
                  // Row를 SingleChildScrollView로 직접 감쌉니다.
                  child: Row(
                    // Row의 mainAxisAlignment는 SingleChildScrollView 내에서
                    // 자식 총 너비가 화면 너비보다 클 때는 크게 의미 없습니다.
                    // 자식 총 너비가 화면 너비보다 작을 때만 spaceEvenly 등이 작동합니다.
                    // 명시적인 간격을 위해 SizedBox를 사용합니다.
                    mainAxisAlignment:
                        MainAxisAlignment.start, // 시작점에 정렬 (스크롤 시 자연스러움)
                    children: <Widget>[
                      _buildFlipCard('전도 자료', 'img/card_back_1.png'), // 경로 확인
                      const SizedBox(width: 10), // 카드 사이 간격
                      _buildFlipCard('선교 현황', 'img/card_back_2.png'), // 경로 확인
                      const SizedBox(width: 10), // 카드 사이 간격
                      _buildFlipCard('훈련 일정', '/img/card_back_3.png'), // 경로 확인
                      // TODO: 필요에 따라 카드 추가 및 SizedBox 간격 추가
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 5. 하단 배너 (경로 확인, pubspec.yaml 등록 필수)
          Image.asset(
            'img/BottomBanner.png', // 예: assets/images 사용
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Text('하단 배너 이미지를 불러오지 못했습니다.'));
            },
          ),
          const SizedBox(height: 20), // 하단 네비바에 가려지지 않도록 공간 추가
        ],
      ),
    );
  }

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
                overflow: TextOverflow.ellipsis, // 텍스트 넘침 방지
                maxLines: 1, // 한 줄로 제한
              ),
              Text(
                date,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ),
        // TODO: 소식 항목 탭 기능 추가 (Navigator.push 등으로 상세 페이지 이동)
      ],
    );
  }

  // 플립 카드 위젯 생성 함수
  Widget _buildFlipCard(String frontText, String backImagePath) {
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
            child: Padding(
              // 텍스트가 너무 길 경우를 대비해 Padding 추가
              padding: const EdgeInsets.all(8.0),
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
        ),
        back: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              backImagePath, // 전달받은 이미지 경로 사용 (pubspec.yaml 등록 필수)
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
