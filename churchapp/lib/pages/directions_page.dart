// lib/pages/directions_page.dart

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart'; // 3.x.x 버전

// --- 버스 시간표 데이터 구조 및 데이터 ---

// 버스 시간표 항목 데이터 구조
class BusScheduleEntry {
  final String place;
  final String time;
  BusScheduleEntry(this.place, this.time);
}

// 버스 노선별 스케줄 데이터 구조
class BusRouteSchedule {
  // 이미지에 있는 각 표의 상단 정보 (예: 1호차, 운전자, 전화번호)
  final String routeInfo;
  final List<BusScheduleEntry> schedule;
  // 이미지의 각 표 하단 추가 설명 (예: 예배 후 출발 시간)
  final String? additionalNote;

  BusRouteSchedule(this.routeInfo, this.schedule, {this.additionalNote});
}

// 실제 버스 시간표 데이터 (이미지 내용을 기반으로 작성)
// 이미지의 4개 표를 각 BusRouteSchedule 객체로 표현
final List<BusRouteSchedule> busSchedules = [
  BusRouteSchedule(
    '■ 1호차(5400) - 주일 1부 예배 (탄현, 교하)\n서우열 목사 ☎ 010-2806-1568',
    [
      BusScheduleEntry('탄현역 1번 출구', '08:20'),
      BusScheduleEntry('교하8단지(청석마을) 후문', '08:30'),
      BusScheduleEntry('교하9단지 정문 소방서 옆', '08:32'),
      BusScheduleEntry('교회도착(예상시간)', '08:45'),
    ],
    additionalNote: null, // 이 노선은 추가 설명이 없습니다.
  ),
  BusRouteSchedule(
    '■ 2호차(9939) - 주일 1부 예배 (화정)\n임영섭 전도사 ☎ 010-8449-1373',
    [
      BusScheduleEntry('옥빛마을 15단지', '07:55'),
      BusScheduleEntry('성원일레븐 교앙토당본', '08:00'), // 이미지 텍스트 다시 확인 후 수정 필요 가능
      BusScheduleEntry('성원일레븐 농협사정', '08:05'), // 이미지 텍스트 다시 확인 후 수정 필요 가능
      BusScheduleEntry('교회도착(예상시간)', '08:30'),
    ],
    additionalNote: null, // 이 노선은 추가 설명이 없습니다.
  ),
  BusRouteSchedule(
    '■ 1호차(5400) - 주일 2부 예배 (문산)\n김형만 장로 ☎ 010-8765-6172',
    [
      BusScheduleEntry('파주읍 봉서4리', '09:50'),
      BusScheduleEntry('문산 선유 주공', '10:00'),
      BusScheduleEntry('금촌 성원 APT', '10:20'),
      BusScheduleEntry('교하운정주공2단지', '10:30'),
    ],
    additionalNote: '*예배 후 교회 출발 : 13:00',
  ),
  BusRouteSchedule(
    '■ 2호차(9939) - 주일 2부 예배 (화정)\n정인영 집사 ☎ 010-7187-6365',
    [
      BusScheduleEntry('은빛5단지내슈퍼 앞', '09:40'),
      BusScheduleEntry('화정 롯데마트', '09:45'),
      BusScheduleEntry('햇빛마을18단지', '09:50'),
      BusScheduleEntry('주엽 롯데 마트', '10:15'),
      BusScheduleEntry('일산정보산업고 옆', '10:25'),
    ],
    additionalNote: null, // 이 노선은 추가 설명이 없습니다.
  ),
];

// 이미지 하단의 최종 안내 문구
const String finalBusNote = '차량운행이 필요하신 분은 담당자에게 문의 바랍니다.';

// --- 데이터 정의 끝 ---

class DirectionsPage extends StatefulWidget {
  const DirectionsPage({super.key});

  @override
  State<DirectionsPage> createState() => _DirectionsPageState();
}

class _DirectionsPageState extends State<DirectionsPage> {
  // _isLoadingMap 변수는 setState로 값이 변경되므로 final이 될 수 없습니다.
  bool _isLoadingMap = true; // 맵 로딩 상태 표시

  @override
  void initState() {
    super.initState();
    debugPrint('DirectionsPage initState');
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('DirectionsPage dispose');
  }

  // WebView 페이지 로딩 완료 시 호출될 함수
  void _onPageFinished(String url) {
    debugPrint('Page finished loading: $url');
    // 위젯이 마운트된 상태에서만 setState 호출
    if (mounted) {
      setState(() {
        _isLoadingMap = false; // 로딩 완료 시 로딩 인디케이터 숨김
      });
    }
  }

  // WebView 웹 리소스 로딩 오류 시 호출될 함수 (3.x.x 버전)
  void _onWebResourceError(WebResourceError error) {
    // 3.x.x 버전의 WebResourceError에는 'url' 속성이 없을 수 있습니다.
    debugPrint('''
        Page loading error:
          Error Code: ${error.errorCode}
          Description: ${error.description}
          ErrorType: ${error.errorType}
          // 3.x.x 버전에서는 오류 발생 URL을 여기서 바로 얻기 어려울 수 있습니다.
      ''');
    // 에러 발생 시 로딩 상태 변경 (로딩 인디케이터 숨김 등)
    if (mounted) {
      setState(() {
        _isLoadingMap = false; // 에러 발생 시에도 로딩 중지
      });
    }
  }

  // 정보 항목 (주소, 연락처, 대중교통)을 생성하는 헬퍼 함수 (이전과 동일)
  Widget _buildInfoRow(IconData icon, String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[200],
            child: Icon(icon, size: 24, color: Colors.black87),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(content, style: const TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 버스 노선별 시간표 섹션을 생성하는 위젯 헬퍼 함수
  Widget _buildBusScheduleSection(BusRouteSchedule route) {
    // 표의 헤더 (장소, 시간)
    final List<TableRow> tableRows = [
      TableRow(
        children: [
          TableCell(
            child: Container(
              // Container로 배경색 및 패딩 적용
              padding: const EdgeInsets.all(8.0),
              color: Colors.grey[200], // 헤더 배경색
              child: const Text(
                '장소',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
          TableCell(
            child: Container(
              // Container로 배경색 및 패딩 적용
              padding: const EdgeInsets.all(8.0),
              color: Colors.grey[200], // 헤더 배경색
              child: const Text(
                '시간',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    ];

    // 스케줄 항목들을 TableRow로 변환하여 추가
    for (var entry in route.schedule) {
      tableRows.add(
        TableRow(
          children: [
            TableCell(
              child: Padding(
                // 개별 셀 패딩
                padding: const EdgeInsets.all(8.0),
                child: Text(entry.place, style: const TextStyle(fontSize: 15)),
              ),
            ),
            TableCell(
              child: Padding(
                // 개별 셀 패딩
                padding: const EdgeInsets.all(8.0),
                child: Text(entry.time, style: const TextStyle(fontSize: 15)),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 노선 정보 (1호차, 2호차 정보, 운전자, 전화번호)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // 좌우 패딩
          child: Text(
            route.routeInfo,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),

        // 시간표 테이블
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // 좌우 패딩
          child: Table(
            border: TableBorder.all(color: Colors.grey[400]!), // 테이블 전체 테두리
            columnWidths: const {
              // 컬럼 너비 지정 (예시: 장소 2배, 시간 1배 비율)
              0: FlexColumnWidth(2), // 장소 컬럼
              1: FlexColumnWidth(1), // 시간 컬럼
            },
            children: tableRows,
          ),
        ),
        // 추가 설명 (예: 예배 후 출발 시간)
        if (route.additionalNote != null)
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              left: 16.0,
              right: 16.0,
            ), // 좌우 패딩 추가
            child: Text(
              route.additionalNote!,
              style: const TextStyle(fontSize: 14),
            ),
          ),

        const SizedBox(height: 24), // 각 노선 섹션 하단 간격
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 지도 섹션 (이전과 동일)
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              '지도',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              height: 300,
              width: double.infinity,
              child: Stack(
                children: [
                  // webview_flutter 3.x.x 버전의 WebView 사용
                  WebView(
                    initialUrl:
                        'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3157.021643684198!2d126.73660291215549!3d37.695690742545125!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357c8f51a6b81507%3A0xd640b53dd4b4a20c!2z7JiB6rSR6rWQ7ZqM!5e0!3m2!1sko!2skr!4v1745139609342!5m2!1sko!2skr',
                    javascriptMode: JavascriptMode.unrestricted,
                    navigationDelegate: (NavigationRequest request) {
                      debugPrint('Navigating to ${request.url}');
                      if (request.url.startsWith(
                        'https://www.google.com/maps/embed',
                      )) {
                        return NavigationDecision.navigate; // 지도 URL은 허용
                      }
                      // TODO: 외부 링크를 클릭했을 때 앱 내에서 열지, 외부 브라우저로 열지 등을 결정
                      // 예를 들어, 다른 모든 URL은 차단할 수 있습니다.
                      // return NavigationDecision.prevent; // 다른 URL 이동 차단
                      return NavigationDecision.navigate; // 기본적으로 허용
                    },
                    onPageFinished: _onPageFinished, // 정의한 함수 연결
                    onWebResourceError: _onWebResourceError, // 정의한 함수 연결
                    // 3.x.x 버전의 다른 속성들...
                  ),
                  // 로딩 인디케이터
                  if (_isLoadingMap)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 주소, 연락처, 대중교통 항목 (이전과 동일)
          _buildInfoRow(
            Icons.directions_car,
            '주소',
            '(10212) 경기도 고양시 일산서구 덕이로 209-27\n(덕이동, 영광교회)',
          ),
          const Divider(height: 1, color: Colors.grey),
          _buildInfoRow(
            Icons.phone,
            '연락처',
            '(Tel) 031-911-7801\n(Fax) 0503-8379-4464',
          ),
          const Divider(height: 1, color: Colors.grey),
          _buildInfoRow(
            Icons.directions_bus,
            '대중교통',
            '일반버스 : 2, 5, 66, 150, 151, 200, 700, 7733\n좌석버스 : 9701, 9707, 8880',
          ),
          const Divider(height: 1, color: Colors.grey),

          // 영광교회 버스 운영 시간표 섹션 (이미지 대신 표로 구현)
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              '영광교회 버스 운영 시간표',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          const SizedBox(height: 16),

          // --- 버스 시간표 표 동적으로 생성 ---
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 각 노선별 스케줄 섹션을 빌드
              // busSchedules 리스트를 순회하며 _buildBusScheduleSection 호출
              for (var route in busSchedules) _buildBusScheduleSection(route),

              // 최종 안내 문구
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Center(
                  // 이미지에서는 왼쪽 정렬이지만, 텍스트가 길면 중앙 정렬이 나을 수도 있습니다.
                  child: Text(
                    finalBusNote,
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          Colors
                              .red, // 붉은색 계열 (예: Colors.red, Colors.deepOrange 등)
                      fontWeight: FontWeight.bold, // 굵게
                      fontStyle: FontStyle.italic, // 기울임
                    ),
                    textAlign: TextAlign.center, // 필요시 TextAlign.start로 변경
                  ),
                ),
              ),
            ],
          ),
          // --- 버스 시간표 표 구현 끝 ---

          // 하단 배너 이미지 (이전과 동일)
          Image.asset(
            'img/BottomBanner.png',
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Text('하단 배너 이미지를 불러오지 못했습니다.'));
            },
          ),
          const SizedBox(height: 20), // 하단 네비게이션 바에 가려지지 않도록 충분한 공간 추가
        ],
      ),
    );
  }
}
