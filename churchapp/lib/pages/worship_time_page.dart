// lib/pages/worship_time_page.dart

import 'package:flutter/material.dart';

// --- 예배 시간표 데이터 구조 및 데이터 ---

// 각 예배/기관별 항목 데이터 구조 (이름, 시간, 장소)
class WorshipEntry {
  final String name;
  final String time;
  final String location;
  const WorshipEntry(this.name, this.time, this.location);
}

// 예배 시간표 섹션별 데이터 구조 (제목, 항목 목록, 추가 설명)
class WorshipSection {
  final String heading; // 예: '주일예배', '주중예배'
  final List<WorshipEntry> entries;
  final String? additionalNote; // 섹션 하단 추가 설명 (예: *매월 첫 주일은...)

  const WorshipSection(this.heading, this.entries, {this.additionalNote});
}

// 실제 예배 시간표 데이터 (이미지 내용을 기반으로 작성)
const List<WorshipSection> worshipSchedules = [
  WorshipSection('주일예배', [
    WorshipEntry('주일 1부 예배', '주일 오전 9:00', '본 당'),
    WorshipEntry('주일 2부 예배', '주일 오전 11:00', '본 당'),
    WorshipEntry('주일 3부 예배', '주일 오후 2:30', '본 당'),
  ], additionalNote: '*매월 첫 주일은 1,2부 예배가 없고\n 새생명 초청예배로 오전 10:30에 드립니다.'),
  WorshipSection(
    '주중예배',
    [
      WorshipEntry('새벽 예배', '평일 오전 5:30', '소예배실'),
      WorshipEntry('수요 예배', '수요일 오후 7:30', '소예배실'),
      WorshipEntry('금요 예배', '금요일 오후 7:30', '소예배실'),
    ],
    additionalNote: null, // 이 섹션은 추가 설명이 없습니다.
  ),
  // 이미지에서 '주일예배' 제목 아래 또 다른 표가 있는데, 이는 부서/기관 예배일 수 있습니다.
  //heading을 동일하게 '주일예배'로 하되, 필요시 다른 제목으로 구분 가능합니다.
  WorshipSection(
    '기관예배', // 또는 '주일 부서/기관 예배' 등 다른 제목으로 구분 가능
    [
      WorshipEntry('유아부', '주일 오전 11:00', '사랑반'),
      WorshipEntry('유치부', '주일 오전 11:00', '믿음반'),
      WorshipEntry('유년부', '주일 오전 11:00', '소예배실'),
      WorshipEntry('초등부', '주일 오전 11:00', '소예배실'),
      WorshipEntry('청소년부', '주일 오전 9:00', '소예배실'),
      WorshipEntry('디모데1부', '주일 오후 1:30', '지혜반'),
      WorshipEntry('디모데2부', '주일 오후 1:30', '사랑반'),
      WorshipEntry('태영아부', '주일 오후 1:30', '소예배실'),
      WorshipEntry('중직자&산업인', '주일 오후 1:30', '새가족실'),
    ],
    additionalNote: null, // 이 섹션은 추가 설명이 없습니다.
  ),
];

// --- 데이터 정의 끝 ---

class WorshipTimePage extends StatelessWidget {
  const WorshipTimePage({super.key});

  // 예배 시간표 섹션을 빌드하는 헬퍼 위젯
  Widget _buildWorshipSection(WorshipSection section) {
    // 각 항목 (예배 이름, 시간, 장소)을 TableRow로 변환
    final List<TableRow> tableRows =
        section.entries.map((entry) {
          return TableRow(
            children: [
              TableCell(
                // 예배 이름
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 8.0,
                  ),
                  child: Text(entry.name, style: const TextStyle(fontSize: 15)),
                ),
              ),
              TableCell(
                // 예배 시간
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 8.0,
                  ),
                  child: Text(
                    entry.time,
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ), // 시간은 이미지에서 회색으로 보입니다.
                ),
              ),
              TableCell(
                // 예배 장소
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 8.0,
                  ),
                  child: Text(
                    entry.location,
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ), // 장소도 이미지에서 회색으로 보입니다.
                ),
              ),
            ],
          );
        }).toList();

    return IntrinsicHeight(
      // Row의 자식들이 같은 높이를 가지도록 합니다.
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.stretch, // 자식 위젯들이 부모의 세로 공간을 채우도록 스트레치
        children: [
          // 왼쪽 헤딩 부분 (예: 주일예배)
          Container(
            width: 100, // 이미지상 대략적인 고정 너비
            color: Colors.grey[100], // 이미지상 배경색 (옅은 회색)
            alignment: Alignment.center, // 내용을 중앙 정렬
            child: RotatedBox(
              // 텍스트를 세로로 회전 (필요시)
              quarterTurns: 0, // 회전하지 않음. 이미지상으로는 세로가 아니라 가로로 글씨가 길게 써진 형태입니다.
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  section.heading,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ), // 이미지상 굵은 글씨
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          // 오른쪽 내용 부분 (시간표 목록)
          Expanded(
            // 남은 공간 전체 사용
            child: Column(
              // 목록 항목들과 추가 설명을 세로로 쌓습니다.
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Table(
                  // 컬럼 너비 지정 (예시: 이름, 시간, 장소 비율 조정)
                  columnWidths: const {
                    0: FlexColumnWidth(2), // 이름 컬럼 (더 넓게)
                    1: FlexColumnWidth(1.5), // 시간 컬럼
                    2: FlexColumnWidth(1), // 장소 컬럼 (가장 좁게)
                  },
                  // 각 행 사이의 수평선은 Table 위젯에서 직접 제공하지 않습니다.
                  // 각 TableRow의 Padding 안에 Divider를 넣거나,
                  // Table 대신 Column과 Row 조합으로 각 항목을 직접 만들고 그 사이에 Divider를 넣을 수 있습니다.
                  // 여기서는 Table로 기본 구조를 잡고, 셀 패딩만 적용합니다.
                  children: tableRows,
                ),
                // 섹션 하단 추가 설명 (*매월 첫 주일은...)
                if (section.additionalNote != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0), // 이미지상 패딩
                    child: Text(
                      section.additionalNote!,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ), // 이미지상 작은 회색 글씨
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 자식 위젯들을 시작점(왼쪽)에 정렬
        children: <Widget>[
          // "예배안내" 타이틀 섹션
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '예배안내',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8), // 텍스트와 아이콘 사이 간격
                Icon(Icons.schedule, size: 24), // 시계/시간 관련 아이콘
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.grey), // 섹션 구분선
          const SizedBox(height: 16), // 구분선 아래 간격
          // --- 예배 시간표 섹션들 동적으로 생성 ---
          Column(
            // 예배 시간표 섹션들을 세로로 쌓습니다.
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // 자식 섹션들이 가로 전체를 채우도록 스트레치
            children: [
              for (var section in worshipSchedules) // 각 섹션 데이터를 순회
                _buildWorshipSection(section), // 섹션 빌더 함수 호출
            ],
          ),

          // --- 예배 시간표 섹션 구현 끝 ---
          const SizedBox(height: 16), // 예배 시간표 섹션 하단 간격
          const Divider(height: 1, color: Colors.grey), // 전체 섹션 구분선 (이미지 참고)
          const SizedBox(height: 16), // 구분선 아래 간격
          // 하단 배너 이미지 (directions_page와 동일)
          Image.asset(
            'img/BottomBanner.png', // 하단 배너 이미지 파일 경로
            width: double.infinity, // 가로 전체 채우기
            fit: BoxFit.cover, // 이미지 비율 유지하며 채우기
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Text('하단 배너 이미지를 불러오지 못했습니다.'),
              ); // 이미지 로드 실패 시 메시지
            },
          ),
          const SizedBox(height: 20), // 하단 네비게이션 바에 가려지지 않도록 충분한 공간 추가
        ],
      ),
    );
  }
}
