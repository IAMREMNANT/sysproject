import 'package:flutter/material.dart';

class ChurchIntroPage extends StatelessWidget {
  const ChurchIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold는 상태나 자식 때문에 const 불가
    return Scaffold(
      body: SingleChildScrollView( // SingleChildScrollView는 const 불가
        // Column은 자식 중 일부가 const가 아니므로 const 불가
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // const 가능
          children: [
            // 빌더 함수 호출 시 const 제거 (함수 이름 앞에 const 붙이는 오류 해결)
            _buildTopSection(),
            const SizedBox(height: 30), // const 가능
            _buildVisionSection(),
            const SizedBox(height: 40), // const 가능
            _buildPastorIntroSection(),
            const SizedBox(height: 40), // const 가능
            _buildGrowthSummarySection(), // 이 함수는 전체가 const 위젯 반환 가능하므로 호출 시 const 가능
            const SizedBox(height: 20), // const 가능
            _buildTimelineSection(),
            const SizedBox(height: 40), // const 가능
          ],
        ),
      ),
    );
  }

  // --- 1. 상단 소개글 및 이미지 섹션 ---
  // 내부 Row의 일부 자식 때문에 이 함수 자체는 const 위젯을 반환하기 어렵습니다.
  Widget _buildTopSection() {
    return Padding( // Padding은 const 가능
      padding: const EdgeInsets.all(16.0), // const 가능
      child: Row( // Row는 Expanded 때문에 const 불가
        crossAxisAlignment: CrossAxisAlignment.start, // const 가능
        children: [
          Expanded( // Expanded는 const 불가
            flex: 3, // const 가능
            // Column은 자식들이 모두 const 가능하므로 Column도 const 가능
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start, // const 가능
              children: [
                Text('경기도 고양시 일산서구 덕이동에 위치한'), // const 가능
                SizedBox(height: 4), // const 가능
                Text('영광교회는', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), // const 가능
                SizedBox(height: 16), // const 가능
                Text('강태흥 목사님을 중심으로 모든 교역자와 중직자, 전 성도들이 하나가 되어 전도와 선교, 후대사역에 방향을 맞추고 예수 사랑, 예수 생명, 예수 능력으로 충만한 응답을 누리고 있는 교회입니다.', style: TextStyle(fontSize: 15, height: 1.6)), // const 가능
                SizedBox(height: 16), // const 가능
                Text('고양시와 파주시가 맞닿아 있는 곳에 위치한 영광교회는 고양, 김포, 파주, 수도권을 살리기 위한 200 전도지교회 운동과 2만 전도제자가 일어나기를 소망하며, 모든 성도가 각자의 현장에서 153운동(100명이상 기도, 50명이상 복음 증거, 3명이상 교회화)과 ‘전도자의 삶’을 실천하고 있으며 이 응답을 모든 성도가 누릴 수 있도록 낮 12시와 저녁 9시에 목사님과 각 기관장, 구역장들이 성도들에게 문자메시지로 기도제목을 알리고 있습니다.', style: TextStyle(fontSize: 15, height: 1.6)), // const 가능
                SizedBox(height: 16), // const 가능
                Text('또한 매주일 오후 태영아 전도학교에서 세계복음화를 위한 3대 언약 전수의 중요성과 필요성을 나누고 있습니다.', style: TextStyle(fontSize: 15, height: 1.6)), // const 가능
                SizedBox(height: 16), // const 가능
                Text('뿐만 아니라 교회의 부설기관으로 GRS(Glory Remnant School) 선교원을 운영하여 영아부터 유치부까지의 후대를 복음엘리트로 양육하고 있습니다.', style: TextStyle(fontSize: 15, height: 1.6)), // const 가능
                SizedBox(height: 16), // const 가능
                Text('영광교회는 고양, 김포, 파주, 수도권 지역에 2만 전도제자를 세우고 200장로를 중심으로 200현장에 지교회를 세워 현장과 후대를 살리기 위해 세우신 교회입니다.', style: TextStyle(fontSize: 15, height: 1.6)), // const 가능
              ],
            ),
          ),
          const SizedBox(width: 20), // const 가능
          Expanded( // Expanded는 const 불가
            flex: 2, // const 가능
            child: AspectRatio( // AspectRatio는 const 불가
              aspectRatio: 1.0, // const 가능
              // Container는 decoration 때문에 const 불가
              child: Container(
                // Decoration 앞의 const 제거 유지
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8), bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)), // const 가능                  
                  image: const DecorationImage(
                     image: AssetImage('img/church_collage_placeholder.png'), // const 가능
                     fit: BoxFit.cover, // const 가능
                   ),
                ),
                 // 이미지 없을 때 배경색 표시용 (DecoratedBox 자체는 const 불가)
                 child: const DecoratedBox( // DecoratedBox는 decoration 때문에 const 불가
                   decoration: BoxDecoration(color:  Color(0xFFFEF7FF)), // const 가능
                 )
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- 2. 목회비전 섹션 ---
  // 내부 Row의 일부 자식 때문에 이 함수 자체는 const 위젯을 반환하기 어렵습니다.
  Widget _buildVisionSection() {
    return Padding( // Padding은 const 가능
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // const 가능
      // Column은 자식들 때문에 const 불가
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // const 가능
        children: [
          const Text('목회비전', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), // const 가능
          const SizedBox(height: 16), // const 가능
          SingleChildScrollView( // SingleChildScrollView는 const 불가
            scrollDirection: Axis.horizontal, // const 가능
            // Row는 자식들 때문에 const 불가 (_buildVisionItem 호출)
            child: Row(
              children: [
                // _buildVisionItem 호출은 const 불가 (매번 다른 인자 전달)
                _buildVisionItem('01', '그리스도 언약 안에서 참행복을 발견하고 그 행복을 삶에서 누리는 성도', Colors.indigo[700]!),
                _buildVisionItem('02', '훈련을 통해 온 성도가 각자의 현장에서 전도제자의 축복을 누리는 교회', Colors.blueGrey[600]!),
                _buildVisionItem('03', '2만 전도제자, 200장로, 200지교회를 세워 현장을 살리는 교회', Colors.green[700]!),
                _buildVisionItem('04', '북방 26개국, 및 유럽, 중남미에 선교사를 돕고 한가정이 한선교사를 파송하는 교회', Colors.teal[700]!),
                _buildVisionItem('05', '후대를 복음 가진 엘리트로 양육하여 영적정상의 자리에 세우는 교회', Colors.brown[600]!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 개별 목회비전 아이템 위젯
  // 인자로 동적인 값이 오므로 이 함수 자체는 const 위젯을 반환하기 어렵습니다.
  Widget _buildVisionItem(String number, String text, Color color) {
    return Container( // Container는 color 때문에 const 불가
      width: 150, // const 가능
      height: 150, // const 가능
      margin: const EdgeInsets.only(right: 12.0), // const 가능
      padding: const EdgeInsets.all(16.0), // const 가능
      decoration: BoxDecoration( // BoxDecoration은 color 때문에 const 불가
        color: color, // const 불가
        shape: BoxShape.circle, // const 가능
      ),
      // <<< Column 및 자식 Text 앞의 const 제거 (동적 인자 사용) >>>
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // const 가능
        children: [
          // number, text 인자를 사용하므로 Text는 const 불가
          Text(number, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)), // TextStyle은 const 가능
          const SizedBox(height: 8), // const 가능
          Text(text, style: const TextStyle(fontSize: 14, color: Colors.white, height: 1.4), textAlign: TextAlign.center), // TextStyle, TextAlign은 const 가능
        ],
      ),
    );
  }

  // --- 3. 담임목사 소개 섹션 ---
  // 내부 Row의 일부 자식 때문에 이 함수 자체는 const 위젯을 반환하기 어렵습니다.
  Widget _buildPastorIntroSection() {
    return Padding( // Padding은 const 가능
      padding: const EdgeInsets.all(16.0), // const 가능
      child: Row( // Row는 CircleAvatar 때문에 const 불가
        crossAxisAlignment: CrossAxisAlignment.start, // const 가능
        children: [
          // CircleAvatar는 radius, backgroundImage 때문에 const 불가
          CircleAvatar(
             radius: 60, // const 가능
             backgroundColor: Colors.grey[300], // const 불가 (색상 룩업)
             backgroundImage: const AssetImage('img/pastor_photo.png'), // const 가능
           ),
           const SizedBox(width: 20), // const 가능
           Expanded( // Expanded는 const 불가
             // Column은 자식들 때문에 const 불가
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start, // const 가능
               children: [
                 const Text('강태흥 담임목사', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), // const 가능
                 const SizedBox(height: 8), // const 가능
                 // Text 내용은 const 가능하나 style 때문에 const 불가
                 Text( // Text는 style 때문에 const 불가
                   '서울장신 신학과(Mar. 1982)\n장로회 신학대학교 신대원 목연과(Mar. 1986)\n서울 강남노회(통합)에서 목사안수(Nov. 1988)\n세계 복음화 상임위원회 상임 위원(Oct. 2004)\n세계 복음화 Remnant 총국장(Aug. 2005)',
                   style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.6), // const 불가 (Colors.grey[700])
                 ),
                 const SizedBox(height: 16), // const 가능
                 const Divider(), // const 가능
                 const SizedBox(height: 16), // const 가능
                 const Text(
                   '저희 교회는 예수님만이 인간의 모든 문제를 해결하실 수 있는 그리스도의 언약과 하나님의 마지막 소원은 온 땅에 복음이 증거 되는 것이라는 세계 복음화의 언약, 그리고 다음 세대를 짊어지고 나갈 우리 후대를 향한 언약을 붙잡고 고양시와 파주시 복음화를 위해 세워졌습니다.',
                   style: TextStyle(fontSize: 15, height: 1.6), // const 가능
                 ),
                 const SizedBox(height: 12), // const 가능
                 const Text(
                   '이 일을 위하여 이제 온라인에서도 저희 교회를 만나실 수 있도록 이 홈페이지가 우리 교회 성도들의 화합과 교류의 장이 될 뿐만 아니라 우리 교회에 관심을 갖고 방문하시는 모든 분들에게 좋은 소식을 전하는 곳이 되기를 바랍니다. 언제나 하나님의 함께 하심이 있기를 기도합니다.',
                   style: TextStyle(fontSize: 15, height: 1.6), // const 가능
                 ),
                 const Align( // Align은 const 가능
                    alignment: Alignment.bottomRight, // const 가능
                    child: Padding( // Padding은 const 가능
                      padding: EdgeInsets.only(top: 8.0), // const 가능
                      // Icon color 때문에 const 불가
                      child: Icon(Icons.edit_outlined, color: Colors.grey), // const 가능
                    ),
                  ),
               ],
             ),
           ),
        ],
      ),
    );
  }

  // --- 4. 성장 요약 섹션 ---
  // 이 함수 전체는 const 위젯을 반환합니다.
  Widget _buildGrowthSummarySection() {
    return const Padding( // Padding과 EdgeInsets는 const 가능
      padding: EdgeInsets.symmetric(horizontal: 16.0), // const 가능
      child: Column( // Column 자식들이 모두 const 가능
        crossAxisAlignment: CrossAxisAlignment.start, // const 가능
        children: [
          Text('영광교회 성장 요약', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), // const 가능
          SizedBox(height: 16), // const 가능
          Text( // const 가능
            '1987년 강남에서 시작된 영광교회는 1996년 일산으로 이전하며 본격적인 성장을 시작했습니다.',
            style: TextStyle(fontSize: 15, height: 1.6), // const 가능
          ),
          SizedBox(height: 12), // const 가능
          Text( // const 가능
            '2004년 성전 건축을 통해 새로운 도약의 발판을 마련했으며, 이후 7개의 지교회를 설립하며 지역사회 복음화에 힘써왔습니다.',
             style: TextStyle(fontSize: 15, height: 1.6), // const 가능
          ),
          SizedBox(height: 12), // const 가능
           Text( // const 가능
             '2019년부터는 선교와 교육에 더욱 집중하며 지속적인 발전을 이어가고 있습니다.',
             style: TextStyle(fontSize: 15, height: 1.6), // const 가능
           ),
        ],
      ),
    );
  }

  // --- 5. 교회 연혁 타임라인 섹션 ---
  // 내부 Row의 일부 자식 때문에 이 함수 자체는 const 위젯을 반환하기 어렵습니다.
  Widget _buildTimelineSection() {
    return Padding( // Padding은 const 가능 (SingleChildScrollView 때문에 Padding을 여기서 분리)
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // const 가능
      child: SingleChildScrollView( // SingleChildScrollView는 const 불가
        scrollDirection: Axis.horizontal, // const 가능
        padding: EdgeInsets.symmetric(vertical: 24.0), // const 가능
        // Row는 자식들 때문에 const 불가 (_buildTimelineCard 호출)
        child: Row(
           crossAxisAlignment: CrossAxisAlignment.start, // const 가능
          children: [
            // _buildTimelineCard 호출은 const 불가 (매번 다른 인자 전달)
            _buildTimelineCard(
              title: '교회 창립',
              date: '1987년 10월 11일',
              description: '서울시 강남구 포이동에서\n강태흥 전도사가 담임목사로 부임하여\n영광교회 창립',
            ),
            _buildTimelineCard(
              title: '일산 이전',
              date: '1996년 5월',
              description: '고양시 일산서구 마두동 857-2로\n영광교회 확장 이전',
            ),
            _buildTimelineCard(
              title: '성전 건축',
              date: '2004년',
              description: '현 위치(덕이동)에\n새 성전 건축 및 입당',
               isLast: false, // const 가능
            ),
             _buildTimelineCard(
              title: '선교/교육 집중',
              date: '2019년',
              description: '선교 및 교육 사역 강화\n지속적인 발전 추구',
               isLast: true, // const 가능
            ),
          ],
        ),
      ),
    );
  }

  // 개별 타임라인 카드 위젯 (단순화 버전)
  // 인자로 동적인 값이 오므로 이 함수 자체는 const 위젯을 반환하기 어렵습니다.
  Widget _buildTimelineCard({
    required String title,
    required String date,
    required String description,
    bool isLast = false,
  }) {
    // Column은 자식들 때문에 const 불가
    return Column(
       mainAxisSize: MainAxisSize.min, // const 가능
      children: [
         Container( // Container는 decoration 때문에 const 불가
           width: 200, // const 가능
           margin: const EdgeInsets.only(right: 30.0), // const 가능
           padding: const EdgeInsets.all(16.0), // const 가능
           // BoxDecoration은 color/boxShadow 때문에 const 불가
           decoration: BoxDecoration(
             color: Colors.grey[100], // const 불가 (색상 룩업)
             borderRadius: const BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0), bottomLeft: Radius.circular(12.0), bottomRight: Radius.circular(12.0)), // const 가능
             boxShadow: [
                BoxShadow( // BoxShadow 자체는 const 가능
                  color: Color.fromARGB(51, 128, 128, 128), // const 가능
                  spreadRadius: 1, // const 가능
                  blurRadius: 3, // const 가능
                  offset: Offset(0, 2), // const 가능
                ),
              ],
           ),
           // Column은 자식들 때문에 const 불가
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start, // const 가능
             children: [
               // <<< Text 위젯 앞의 const 제거 (동적 인자 사용) >>>
               Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), // TextStyle은 const 가능
               const SizedBox(height: 4), // const 가능
               Text(date, style: TextStyle(fontSize: 13, color: Colors.grey[700])), // const 불가 (Colors.grey[700])
               const SizedBox(height: 12), // const 가능
               Text(description, style: const TextStyle(fontSize: 14, height: 1.5)), // TextStyle은 const 가능
             ],
           ),
         ),
         const SizedBox(height: 8), // const 가능
         Row( // Row는 자식들 때문에 const 불가
           children: [
             Container( // Container는 decoration 때문에 const 불가
               height: 12, width: 12, // const 가능
               decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle), // const 가능
             ),
             if (!isLast) // const 불가 (bool 변수 사용)
                Container( // Container는 color 때문에 const 불가
                  height: 2, // const 가능
                  width: 218, // const 가능
                  color: Colors.black, // const 가능
                  margin: EdgeInsets.only(left: 0), // const 가능
                ),
             if (isLast) // const 불가 (bool 변수 사용)
                const SizedBox(width: 30), // const 가능
           ],
         ),
       ],
    );
  }
}