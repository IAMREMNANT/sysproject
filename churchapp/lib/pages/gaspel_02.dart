// lib/pages/gaspel_02.dart (구원의 길 탭 내용)

import 'package:flutter/material.dart';

// 클래스 이름 변경 (Gaspel02Page -> Gaspel02Content)
class Gaspel02Content extends StatelessWidget {
  const Gaspel02Content({super.key});

  @override
  Widget build(BuildContext context) {
    // 이 위젯은 TabBarView의 자식으로 사용되므로, Scaffold, AppBar, BottomNavigationBar를 포함하지 않습니다.
    return SingleChildScrollView( // 내용이 길어질 수 있으므로 스크롤 가능하게 함
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 전체적으로 왼쪽 정렬
        children: [
          // 1. "원래의 인간" 섹션
          _buildOriginalHumanSection(),
          const SizedBox(height: 30), // 섹션 간 간격

          // 2. "문제가 생김" 섹션
          _buildProblemAroseSection(),
          const SizedBox(height: 30), // 섹션 간 간격

          // 3. "유일한 해결책 - 예수 그리스도" 섹션
          _buildSolutionSection(),
          const SizedBox(height: 30), // 섹션 간 간격

          // 4. "예수 | 구원자" 섹션
          _buildJesusSaviorSection(),
          const SizedBox(height: 20), // 간격

          // 5. "그리스도 | 기름부음 받은 자" 섹션
          _buildChristAnointedSection(),
          const SizedBox(height: 30), // 섹션 간 간격

          // 6. "생명을 주는 소중한 이야기" 섹션
          _buildStoryOfLifeSection(),
          const SizedBox(height: 30), // 섹션 간 간격

          // 7. "하나님 자녀의 5가지 확신" 섹션
          _buildFiveCertaintiesSection(),
          const SizedBox(height: 30), // 섹션 간 간격

          // 8. "그리스도인의 신앙생활" 섹션
          _buildChristianFaithLifeSection(),
          const SizedBox(height: 40), // 하단 여백 (스크롤 하단에 공간 추가)
        ],
      ),
    );
  }

  // --- 위젯 빌더 헬퍼 함수들 ---
  // 이전 Gaspel02Page 코드에서 아래 헬퍼 함수들을 복사하여 여기에 붙여넣습니다.


  // 1. "원래의 인간" 섹션
  Widget _buildOriginalHumanSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('원래의 인간', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(height: 20, thickness: 1),
          const Text(
            '만물 가운데 유일하게 하나님의 형상대로 지음 받았으며,\n하나님과 더불어 행복하게 살도록 창조되었습니다. (창1:27-28)\n물고기는 물 속에, 새는 공중에서, 나무는 땅 속에 뿌리를 내리고 살아야 행복하듯\n인간은 하나님과 함께 살아야 진정한 행복을 누리게 됩니다.\n이것이 하나님의 창조 원리입니다.',
            style: TextStyle(fontSize: 15, height: 1.6),
          ),
          const SizedBox(height: 16),
          // TODO: 하나님-인간 관계 다이어그램 이미지 또는 CustomPaint로 교체
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('하나님', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 50, width: 1, color: Colors.black),
                        Row(
                          children: [
                             Container(width: 25, height: 1, color: Colors.black),
                            const Text('창1:27-28(하나님의 형상)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            Container(width: 25, height: 1, color: Colors.black),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          color: Colors.brown[300],
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('예수 그리스도', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                              Text('롬5:8, 갈2:20, 롬8:1-2', style: TextStyle(fontSize: 12, color: Colors.white70)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    const Text('인간', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 4),
                const Text('(원래의 모습)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                const Text('(죄와 저주 가운데)', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 2. "문제가 생김" 섹션
  Widget _buildProblemAroseSection() {
    // 문제점 항목 데이터 (이미지 참고)
    const List<Map<String, String>> problemPoints = [
      {'title': '마귀의 자식', 'text': '하나님과 함께 해야 할 인간이 하나님을 떠나 마귀의 지배를 받게 되었습니다. (요8:44)'},
      {'title': '마귀의 종노릇', 'text': '죄는 하나님을 떠나게 만드는 원죄와 죄를 지을 수밖에 없는 습관적인 죄와\n죄의 결과로 오는 고통의 문제입니다. (롬3:23)'},
      {'title': '하나님 떠난 저주', 'text': '하나님을 떠난 인간은 반드시 죽고 멸망 받을 수밖에 없게 되었습니다. (롬6:23)'},
      {'title': '우상 숭배', 'text': '하나님 아닌 다른 것을 섬기게 되며 결국 정신 문제와 육신의 고통을 겪게 됩니다. (고전10:20)'},
      {'title': '정신 문제', 'text': '불안, 공허, 허무, 정신병, 노이로제, 우울증, 불면증 등 정신적인 문제와\n죄악은 배경과 지식과 상관없이 방황하며 자꾸 망해갑니다. (엡2:3)'},
      {'title': '육신의 고통', 'text': '불치병, 우환, 질고, 가위, 악몽에 시달리며 백약이 무효하며 고통당하게 되며\n실패와 갈등을 겪게 됩니다. (롬8:4-8)'},
      {'title': '죽음과 지옥심판', 'text': '하나님을 부인하고 현실에만 집착하다가 결국은 죽음 이후 지옥의 영원한 심판을 받게 됩니다. (눅16:19-31)'},
      {'title': '영적 유산', 'text': '결국 이 고통과 저주가 나 문제로만 끝나는 것이 아니라 또 다시 후대에게 대물림 됩니다. (출20:4-5)'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('문제가 생김', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(height: 20, thickness: 1),
          Column( // 문제점 항목들을 수직으로 배치
            crossAxisAlignment: CrossAxisAlignment.start,
            children: problemPoints.map((point) => _buildProblemPoint(point['title']!, point['text']!)).toList(),
          ),
        ],
      ),
    );
  }

  // 문제점 개별 항목 위젯
  Widget _buildProblemPoint(String title, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 4),
        Text(text, style: const TextStyle(fontSize: 14, height: 1.6, color: Colors.grey)),
        const SizedBox(height: 12),
      ],
    );
  }

  // 3. "유일한 해결책 - 예수 그리스도" 섹션
  Widget _buildSolutionSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('유일한 해결책 - 예수 그리스도', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(height: 20, thickness: 1),
          const Text(
            '많은 사람들이 종교, 선행, 돈, 노력, 과학, 철학 등을 통해 행복을 찾고\n하나님을 만나려고 노력하지만 인간 스스로의 죄와 방법으로는 결코 하나님을 만날 수 없습니다.\n복음은 하나님께서 죄의 언약의 몸을 입고 이 땅에 오셔서 우리를 구원하신 것입니다.\n그분이 바로 \'예수 그리스도\'이십니다.',
            style: TextStyle(fontSize: 15, height: 1.6),
          ),
          const SizedBox(height: 16),
          // TODO: 하나님-인간-예수 그리스도 다이어그램 이미지 또는 CustomPaint로 교체
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('하나님', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 50, width: 1, color: Colors.black),
                        Row(
                          children: [
                             Container(width: 25, height: 1, color: Colors.black),
                            const Text('창1:27-28(하나님의 형상)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            Container(width: 25, height: 1, color: Colors.black),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          color: Colors.brown[300],
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('예수 그리스도', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                              Text('롬5:8, 갈2:20, 롬8:1-2', style: TextStyle(fontSize: 12, color: Colors.white70)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    const Text('인간', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 4),
                const Text('(원래의 모습)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                const Text('(죄와 저주 가운데)', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 4. "예수 | 구원자" 섹션
  Widget _buildJesusSaviorSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('예수 | 구원자 \'이름, 마1:21\'', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(height: 20, thickness: 1),
          const Text(
            '나의 죄를 대신하여 십자가에 피 흘려 죽으심으로 해결하심\n제 삼일 만에 부활하심으로 사탄 마귀의 권세를 완전히 멸하심\n곧 인간이 절대 해결할 수 없는 근본 문제를 완전히 해결하셨습니다.\n누구든지 예수 그리스도를 진정으로 믿고 영접하여 구원을 얻습니다.\n(롬10:13, 롬10:9-10, 요1:12, 계3:20, 요일5:1, 요일5:12, 롬8:1-2, 요19:30, 행4:12, 마28:18)',
            style: TextStyle(fontSize: 15, height: 1.6),
          ),
           const SizedBox(height: 16),
           const Text(
             '이때 하나님의 자녀 된 신분과 권세, 축복을 얻게 됩니다.\n지금 이 시간 진실한 마음으로 아래의 기도를 따라 하시길 바랍니다.',
             style: TextStyle(fontSize: 15, height: 1.6),
           ),
            const SizedBox(height: 16),
           // TODO: 영접 기도문 텍스트 박스 또는 카드로 교체
           Container(
             padding: const EdgeInsets.all(16.0),
             color: Colors.grey[100],
             child: const Text(
               '영접기도\n전능하신 주님, 나는 죄인입니다. 어디서 왔다가, 왜 살며, 어디로 가는지 알지 못하고 방황하며 살았습니다.\n그런 나를 사랑하셔서 하나님께서 육신을 입으시고 이 땅에 오셔서 십자가에서 나의 모든 죄를 대신 지시고 십자가에 죽으셨습니다.\n십자가의 보혈과 부활의 능력으로 지금 이 자리에 임재 하신 주님, 저의 마음의 문을 활짝 엽니다.\n저의 심령 속에 나의 주, 나의 하나님으로 영원히 모셔 들입니다. 내 안에 들어오셔서 저를 다스리시고 인도하여 주옵소서.\n지금부터 영원까지 나의 주인이 되시고, 나의 하나님 되셔서 나를 인도하여 주옵소서. 예수님의 이름으로 기도합니다. 아멘.',
               style: TextStyle(fontSize: 14, height: 1.6),
             ),
           ),
        ],
      ),
    );
  }

  // 5. "그리스도 | 기름부음 받은 자" 섹션
  Widget _buildChristAnointedSection() {
     return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('그리스도 | 기름부음 받은 자 \'직분, 마16:16\'', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(height: 20, thickness: 1),
          // TODO: 만왕의 왕, 참 제사장, 참 선지자 각 역할 설명 텍스트 추가
          const Text('이름 뜻 : 그리스도 (헬), 메시아 (히) - 기름부음 받은 자 (직분)', style: TextStyle(fontSize: 15, height: 1.6)),
           const SizedBox(height: 8),
           const Text('하나님 만나는 유일한 길 되신 참 선지자 (요14:6, 엡2:1-8)', style: TextStyle(fontSize: 15, height: 1.6)),
            const SizedBox(height: 8),
           const Text('죄와 저주에서 해방시키신 참 제사장 (롬8:1-2, 벧전2:9)', style: TextStyle(fontSize: 15, height: 1.6)),
           const SizedBox(height: 8),
           const Text('사탄 마귀의 권세를 꺾으신 만왕의 왕 (요19:30, 요일3:8)', style: TextStyle(fontSize: 15, height: 1.6)),
           const SizedBox(height: 8),
           const Text('이 세 가지 직분을 합쳐 그리스도라고 합니다.', style: TextStyle(fontSize: 15, height: 1.6)),
        ],
      ),
    );
  }


  // 6. "생명을 주는 소중한 이야기" 섹션
  Widget _buildStoryOfLifeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('생명을 주는 소중한 이야기', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(height: 20, thickness: 1),
          const Text('구원받은 당신은 7가지 축복을 받았습니다.', style: TextStyle(fontSize: 15, height: 1.6)),
          const SizedBox(height: 8),
          // 7가지 축복 목록 (번호 매기기 Text로 직접 구현)
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1.이제 당신은 하나님의 자녀입니다. (요1:12)', style: TextStyle(fontSize: 14, height: 1.6)),
              Text('2.성령께서 함께 하시며 인도하십니다. (고전3:16, 요일2:13)', style: TextStyle(fontSize: 14, height: 1.6)),
              Text('3.하나님께서 당신의 기도에 응답하십니다. (요16:24, 눅11:13)', style: TextStyle(fontSize: 14, height: 1.6)),
              Text('4.예수님의 권세로 흑암 세력을 꺾을 수 있는 권세가 주어졌습니다. (눅10:19-20, 막3:15)', style: TextStyle(fontSize: 14, height: 1.6)),
              Text('5.하나님께서 천사를 보내어 지켜주십니다. (히1:14)', style: TextStyle(fontSize: 14, height: 1.6)),
              Text('6.천국 시민권을 소유한 하나님 나라의 백성으로 이 땅에서도 그 축복을 누립니다. (빌3:20, 엡2:6)', style: TextStyle(fontSize: 14, height: 1.6)),
              Text('7.복음으로 세계를 정복하는 세계 복음화, 전도의 축복을 받았습니다. (행1:8, 마28:18-20)', style: TextStyle(fontSize: 14, height: 1.6)),
            ],
          ),
        ],
      ),
    );
  }

  // 7. "하나님 자녀의 5가지 확신" 섹션
  Widget _buildFiveCertaintiesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('하나님 자녀의 5가지 확신을 갖길 바랍니다.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(height: 20, thickness: 1),
          // 5가지 확신 목록 (번호 매기기 Text로 직접 구현)
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1.구원의 확신 (요일5:11-13)', style: TextStyle(fontSize: 14, height: 1.6)),
              Text('2.인도의 확신 (잠3:5-6)', style: TextStyle(fontSize: 14, height: 1.6)),
              Text('3.승리의 확신 (고전10:13)', style: TextStyle(fontSize: 14, height: 1.6)),
              Text('4.기도 응답의 확신 (렘33:1-3)', style: TextStyle(fontSize: 14, height: 1.6)),
              Text('5.사죄의 확신 (요일1:9)', style: TextStyle(fontSize: 14, height: 1.6)),
            ],
          ),
        ],
      ),
    );
  }

  // 8. "그리스도인의 신앙생활" 섹션
  Widget _buildChristianFaithLifeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('그리스도인의 신앙생활', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(height: 20, thickness: 1),
          const Text(
            '예수 그리스도를 영접한 당신은 새로운 생명을 얻었습니다.\n하나님을 의지하며 하나님이 기뻐하시는 삶 속으로 인도 받으시기 바랍니다.\n①주일에 한번 시간과 장소를 정해서 성경 공부를 통해 그리스도를 더 알아 가시기 바랍니다.\n② 또한 구원받은 성도로서 교회에 출석하여 예배의 축복을 누리시기 바랍니다.',
            style: TextStyle(fontSize: 15, height: 1.6),
          ),
        ],
      ),
    );
  }
}