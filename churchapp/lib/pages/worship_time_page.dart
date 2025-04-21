import 'package:flutter/material.dart';

class WorshipTimePage extends StatelessWidget {
  // 필드 선언 (변경 없음)
  final bool showBanner;

  // <<< 생성자 수정: 'required' 사용 >>>
  const WorshipTimePage({
    super.key,
    required this.showBanner, // showBanner 값을 반드시 받도록 변경
  });

  // --- 데이터 구조 (예시) ---
  static const List<Map<String, String>> _worshipTimes = [
    {'category': '주일예배', 'name': '주일 1부 예배', 'time': '주일 오전 9:00', 'location': '본 당'},
    {'category': '주일예배', 'name': '주일 2부 예배', 'time': '주일 오전 11:00', 'location': '본 당'},
    {'category': '주일예배', 'name': '주일 3부 예배', 'time': '주일 오후 2:30', 'location': '본 당'},
    {'category': '주일예배', 'note': '*매월 첫 주일은 1,2부 예배가 없고\n새생명 초청예배로 오전 10:30에 드립니다.'},
    {'category': '주중예배', 'name': '새벽 예배', 'time': '평일 오전 5:30', 'location': '소예배실'},
    {'category': '주중예배', 'name': '수요 예배', 'time': '수요일 오후 7:30', 'location': '소예배실'},
    {'category': '주중예배', 'name': '금요 예배', 'time': '금요일 오후 7:30', 'location': '소예배실'},
    {'category': '기관예배', 'name': '유아부', 'time': '주일 오전 11:00', 'location': '사랑반'},
    {'category': '기관예배', 'name': '유치부', 'time': '주일 오전 11:00', 'location': '믿음반'},
    {'category': '기관예배', 'name': '유년부', 'time': '주일 오전 11:00', 'location': '소예배실'},
    {'category': '기관예배', 'name': '초등부', 'time': '주일 오전 11:00', 'location': '소예배실'},
    {'category': '기관예배', 'name': '청소년부', 'time': '주일 오전 9:00', 'location': '소예배실'},
    {'category': '기관예배', 'name': '디모데1부', 'time': '주일 오후 1:30', 'location': '지혜반'},
    {'category': '기관예배', 'name': '디모데2부', 'time': '주일 오후 1:30', 'location': '사랑반'},
    {'category': '기관예배', 'name': '태영아부', 'time': '주일 오후 1:30', 'location': '소예배실'},
    {'category': '기관예배', 'name': '중직자&산업인', 'time': '주일 오후 1:30', 'location': '새가족실'},
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildWorshipTable(context),
        // showBanner 값에 따라 배너 표시 여부 결정 (이제 null이 될 수 없음)
        if (showBanner)
          _buildBottomBanner(),
      ],
    );
  }

  // 예배 시간 테이블 생성 위젯
  Widget _buildWorshipTable(BuildContext context) {
     String? currentCategory;
     List<Widget> tableRows = [];

     for (var item in _worshipTimes) {
       if (item['category'] != null && item['category'] != currentCategory) {
         currentCategory = item['category']!;
         tableRows.add(_buildCategoryRow(currentCategory));
       }
       if (item['name'] != null) {
         tableRows.add(_buildWorshipRow(item['name']!, item['time']!, item['location']!));
       } else if (item['note'] != null) {
         tableRows.add(_buildNoteRow(item['note']!));
       }
     }
     return Column(children: tableRows);
   }

  // 카테고리 행 빌더
  Widget _buildCategoryRow(String category) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border(bottom: BorderSide(color: Colors.grey[400]!)),
      ),
      child: Text(
        category,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        textAlign: TextAlign.center,
      ),
      width: double.infinity,
    );
  }

  // 예배 정보 행 빌더
  Widget _buildWorshipRow(String name, String time, String location) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(name, style: const TextStyle(fontSize: 14)),
          ),
          Expanded(
            flex: 2,
            child: Text(time, style: const TextStyle(fontSize: 14), textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 1,
            child: Text(location, style: const TextStyle(fontSize: 14, color: Colors.grey), textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }

  // 참고사항 행 빌더
  Widget _buildNoteRow(String note) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      width: double.infinity,
      child: Text(
        note,
        style: TextStyle(fontSize: 12, color: Colors.red[700]),
      ),
    );
  }

  // 하단 배너 빌더
  Widget _buildBottomBanner() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Image.asset(
        'img/BottomBanner.png', // 실제 경로 확인 및 pubspec.yaml 등록 필요
        width: double.infinity,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 60,
            color: Colors.orange[100],
            alignment: Alignment.center,
            child: const Text('배너 이미지를 불러올 수 없습니다.'),
          );
        },
      ),
    );
  }
}