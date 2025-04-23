import 'package:flutter/material.dart';

class Gaspel01Page extends StatelessWidget {
  const Gaspel01Page({super.key});

  @override
  Widget build(BuildContext context) {
    // 이 위젯은 TabBarView의 자식으로 사용되므로, Scaffold, AppBar, BottomNavigationBar를 포함하지 않습니다.
    return SingleChildScrollView( // 내용이 길어질 수 있으므로 스크롤 가능하게 함
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 전체적으로 왼쪽 정렬
        children: [
          // 3. "혹시 이런 문제로 고민하지 않으십니까?" 섹션
          _buildProblemSection(),
          const SizedBox(height: 30), // 섹션 간 간격

          // 4. "만일?" 섹션
          _buildWhatIfSection(),
          const SizedBox(height: 30), // 섹션 간 간격

          // 5. "당신은 정말 행복하십니까?" 섹션
          _buildHappinessSection(),
          const SizedBox(height: 40), // 하단 여백 (스크롤 하단에 공간 추가)
        ],
      ),
    );
  }

  // --- 위젯 빌더 헬퍼 함수들 ---
  // _buildProblemSection, _buildProblemItem, _buildWhatIfSection, _buildHappinessSection 함수는 아래 정의됩니다.


  // --- 3. "혹시 이런 문제로 고민하지 않으십니까?" 섹션 ---
  Widget _buildProblemSection() {
    // 문제 항목 데이터 (예시 - 이미지 참고하여 작성)
    const List<Map<String, String>> problems = [
      {'title': '인생의 의미', 'text': '열심히 살았고 성공했는데도 불구하고 무엇 때문에 사는 지 의미를 찾을 수 없고 이해할 수 없는 허무와 공허 가운데 방황하고 있지는 않습니까?'},
      {'title': '영적행동', 'text': '나도 모르는 사이에 인터넷, 음란, 도박, 알코올, 게임, 마약 등에 중독되어 가정과 경제, 인간관계 부분에서 고통당하고 있지는 않습니까?'},
      {'title': '저주재앙', 'text': '그토록 노력하고 최선을 다했는데도 불구하고 특별한 이유와 원인도 없이 가정, 직장, 사업에 어려움이 계속되는 않습니까?'},
      {'title': '정신문제', 'text': '과중한 스트레스와 우울증으로 삶의 의욕을 잃고, 자살충동을 느끼며 밤마다 불면증과 악몽, 가위눌림에 시달리고 있지는 않습니까?'},
      {'title': '가정불화', 'text': '부부간의 갈등과 자녀의 문제 등으로 불면, 초조, 가출, 탈선 등을 경험하고 있지는 않습니까?'},
      {'title': '종교생활', 'text': '종교를 갖고 있는데도 불구하고 참된 기쁨과 평안이 없으며, 죄책감과 귀신에 고통을 당하거나 문제 앞에서 좌절하고 낙심하고 있지는 않습니까?'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center( // 이미지상 제목이 중앙에 가까움
            child: Text(
              '혹시 이런 문제로 고민하지 않으십니까?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),

          // 문제 항목 리스트
          Column( // 문제 항목들을 수직으로 배치
            children: problems.map((problem) => _buildProblemItem(problem['title']!, problem['text']!)).toList(),
          ),
        ],
      ),
    );
  }

  // 문제 항목 개별 위젯
  Widget _buildProblemItem(String title, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0), // 항목 아래 간격
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[100], // 배경색
        borderRadius: BorderRadius.circular(8.0), // 둥근 모서리
      ),
      child: Row( // 아이콘(없지만 공간) + 텍스트 내용
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이미지상 왼쪽의 육각형 아이콘 영역 (임시 공간)
          // TODO: 실제 육각형 아이콘 이미지나 CustomPaint로 교체 필요
          Container(
            width: 40, // 육각형 아이콘 너비와 유사하게
            height: 40, // 육각형 아이콘 높이와 유사하게
            margin: const EdgeInsets.only(right: 16.0), // 아이콘과 텍스트 사이 간격
            decoration: BoxDecoration(
               color: Colors.blueAccent, // 육각형 배경색 (예시)
               shape: BoxShape.circle, // 임시로 원형으로 표시
             ),
             child: const Center( // 번호 또는 아이콘 표시
                child: Icon(Icons.question_mark, color: Colors.white, size: 24), // 예시 아이콘
              ),
          ),

          // 텍스트 내용 영역
          Expanded( // 남은 공간 모두 차지
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(fontSize: 14, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 4. "만일?" 섹션 ---
  Widget _buildWhatIfSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row( // "만일?" 텍스트와 설명 텍스트를 좌우로 배치
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "만일?" 텍스트
          const Padding(
            padding: EdgeInsets.only(right: 16.0), // 오른쪽 간격
            child: Text(
              '만일?',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),

          // 설명 텍스트 블록
          Expanded( // 남은 공간 모두 차지
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '만일 이런 문제들을 빨리 해결 받지 않으면 심각한 일에 부딪히게 됩니다.\n왜냐하면 당신은 참 사람의 모습을 갖지 못하고 상실된 모습으로 살아가고 있기 때문입니다.\n하나님을 떠난 인간은 반드시 죽고 멸망을 받습니다(히브리서9:27).\n그러나 당신은 죄인이기 때문에 스스로 이런 문제들을 해결할 수 없습니다.\n(로마서3:23) 예는 모든 사람이 죄를 범하였으매\n하나님의 영광에 이르지 못하더니는 사실을 알리고 있습니다.\n(로마서 3:10) 예는 이 세상에 의인이 하나도 없음을 알리고 있습니다.\n(이사야64:6) 예 하나님을 모르는 선행이 얼마나 무의미한 것인가를 알려주고 있습니다.\n거짓 없이 참 대답을 해보십시오.',
                  style: TextStyle(fontSize: 14, height: 1.6),
                ),
                const SizedBox(height: 16),
                 // TODO: 이미지 하단에 작은 글씨 텍스트 추가 (필요시)
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 5. "당신은 정말 행복하십니까?" 섹션 ---
  Widget _buildHappinessSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row( // 텍스트와 이미지를 좌우로 배치
        crossAxisAlignment: CrossAxisAlignment.center, // 요소들 수직 중앙 정렬
        children: [
          // 텍스트
          const Expanded( // 텍스트가 남은 공간 모두 차지
            flex: 2,
            child: Text(
              '당신은 정말 행복하십니까?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(width: 16), // 텍스트와 이미지 사이 간격

          // 이미지
          Expanded( // 이미지가 남은 공간 모두 차지
             flex: 1,
             child: AspectRatio( // 이미지 비율 유지
               aspectRatio: 1.0,
               child: Container(
                 decoration: const BoxDecoration( // const 가능
                    // TODO: 실제 이미지 경로로 교체
                    image: DecorationImage(
                       image: AssetImage('img/hands_image_placeholder.png'), // 이미지 경로
                       fit: BoxFit.contain,
                     ),
                 ), 
               ),
             ),
           ),
        ],
      ),
    );
  }
}