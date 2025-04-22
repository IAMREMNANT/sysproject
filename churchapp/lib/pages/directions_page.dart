// lib/pages/directions_page.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


// --- 버스 시간표 데이터 구조 및 데이터 --- (동일)
class BusScheduleEntry {
  final String place;
  final String time;
  BusScheduleEntry(this.place, this.time);
}

class BusRouteSchedule {
  final String routeInfo;
  final List<BusScheduleEntry> schedule;
  final String? additionalNote;
  BusRouteSchedule(this.routeInfo, this.schedule, {this.additionalNote});
}

final List<BusRouteSchedule> busSchedules = [
  BusRouteSchedule(
    '■ 1호차(5400) - 주일 1부 예배 (탄현, 교하)\n서우열 목사 ☎ 010-2806-1568',
    [
      BusScheduleEntry('탄현역 1번 출구', '08:20'),
      BusScheduleEntry('교하8단지(청석마을) 후문', '08:30'),
      BusScheduleEntry('교하9단지 정문 소방서 옆', '08:32'),
      BusScheduleEntry('교회도착(예상시간)', '08:45'),
    ],
  ),
  BusRouteSchedule(
    '■ 2호차(9939) - 주일 1부 예배 (화정)\n임영섭 전도사 ☎ 010-8449-1373',
    [
      BusScheduleEntry('옥빛마을 15단지', '07:55'),
      BusScheduleEntry('성원일레븐 교앙토당본', '08:00'),
      BusScheduleEntry('성원일레븐 농협사정', '08:05'),
      BusScheduleEntry('교회도착(예상시간)', '08:30'),
    ],
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
  ),
];

const String finalBusNote = '차량운행이 필요하신 분은 담당자에게 문의 바랍니다.';

// <<< 교회 위치 위도/경도 및 마커 정의 >>>
// 교회의 위도와 경도 (구글 지도 참고)
const LatLng _churchLocation = LatLng(37.695690, 126.738304);

// 지도에 표시할 마커들
final Set<Marker> _markers = {
  Marker(
    markerId: const MarkerId('churchLocation'),
    position: _churchLocation,
    infoWindow: const InfoWindow(title: '영광교회', snippet: '오시는 길'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), // 마커 색상
  ),
};

// <<< 초기 카메라 위치 설정 >>>
const CameraPosition _initialCameraPosition = CameraPosition(
  target: _churchLocation, // 교회가 중앙에 오도록
  zoom: 16, // 적절한 초기 줌 레벨
);


class DirectionsPage extends StatefulWidget {
  const DirectionsPage({super.key});

  @override
  State<DirectionsPage> createState() => _DirectionsPageState();
}

class _DirectionsPageState extends State<DirectionsPage> {
  // <<< WebView 로딩 상태 변수 제거 (GoogleMap은 자체 로딩 인디케이터 있음) >>>
  // bool _isLoadingMap = true;

  // <<< WebViewController 제거 >>>
  // late final WebViewController _controller;

  // GoogleMapController (필요시 추가 제어)
  // GoogleMapController? _mapController; // 필요한 경우 주석 해제

  @override
  void initState() {
    super.initState();
    debugPrint('DirectionsPage initState');

    // <<< WebView 관련 초기화 로직 모두 제거 >>>
    // late final PlatformWebViewControllerCreationParams params; ... _controller = WebViewController.fromPlatformCreationParams(params); ... _controller..setJavaScriptMode...;
  }

  @override
  void dispose() {
    // <<< WebViewController dispose 제거 >>>
    // _controller.dispose();
    // _mapController?.dispose(); // GoogleMapController 사용시 해제
    super.dispose();
    debugPrint('DirectionsPage dispose');
  }

  // <<< WebView 콜백 함수들 제거 >>>
  // void _onDocumentLoadFailed(...) { ... }
  // void _onDocumentLoaded(...) { ... }
  // void _onPageChanged(...) { ... }
  // void _goToPreviousPage() { ... }
  // void _goToNextPage() { ... }


  // 정보 항목 빌더 (동일)
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
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(content, style: const TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 버스 노선별 시간표 섹션 빌더 (동일)
  Widget _buildBusScheduleSection(BusRouteSchedule route) {
    final List<TableRow> tableRows = [
      TableRow(
        children: [
          TableCell(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.grey[200],
              child: const Text('장소', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ),
          ),
          TableCell(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.grey[200],
              child: const Text('시간', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ),
          ),
        ],
      ),
    ];

    for (var entry in route.schedule) {
      tableRows.add(
        TableRow(
          children: [
            TableCell(child: Padding(padding: const EdgeInsets.all(8.0), child: Text(entry.place, style: const TextStyle(fontSize: 15)))),
            TableCell(child: Padding(padding: const EdgeInsets.all(8.0), child: Text(entry.time, style: const TextStyle(fontSize: 15)))),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(route.routeInfo, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Table(
            border: TableBorder.all(color: Colors.grey[400]!),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
            },
            children: tableRows,
          ),
        ),
        if (route.additionalNote != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
            child: Text(route.additionalNote!, style: const TextStyle(fontSize: 14)),
          ),
        const SizedBox(height: 24),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 지도 섹션 (타이틀, 구분선, 간격 - 동일)
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text('지도', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 1, color: Colors.grey),
          const SizedBox(height: 16),

          // Google Map 표시 영역 (수정)
          Center(
            child: SizedBox(
              height: 300, // 높이 고정 (조절 가능)
              width: double.infinity, // 가로 전체 사용
              // <<< GoogleMap 위젯 사용 >>>
              child: GoogleMap(
                initialCameraPosition: _initialCameraPosition, // 초기 카메라 위치
                markers: _markers, // 마커들 설정
                mapType: MapType.normal, // 지도 타입 (일반, 위성 등)
                myLocationEnabled: true, // 내 위치 버튼 표시 (권한 필요)
                myLocationButtonEnabled: true, // 내 위치 버튼 활성화
                zoomControlsEnabled: true, // 줌 컨트롤 버튼 표시
                onMapCreated: (GoogleMapController controller) {
                   // _mapController = controller; // GoogleMapController 사용시 연결
                   // GoogleMap 자체에 로딩 인디케이터가 내장되어 있으므로 별도의 로딩 상태 관리가 필수는 아님
                   // 만약 로딩 완료 후 특정 작업을 해야 한다면 여기서 수행
                   debugPrint('Google Map Created');
                },
                // GoogleMap은 onPageFinished/onWebResourceError 같은 콜백은 제공하지 않음
              ),
            ),
          ),
          const SizedBox(height: 16), // 간격

          // 주소, 연락처, 대중교통 항목 (동일)
          _buildInfoRow(Icons.directions_car, '주소', '(10212) 경기도 고양시 일산서구 덕이로 209-27\n(덕이동, 영광교회)'),
          const Divider(height: 1, color: Colors.grey),
          _buildInfoRow(Icons.phone, '연락처', '(Tel) 031-911-7801\n(Fax) 0503-8379-4464'),
          const Divider(height: 1, color: Colors.grey),
          _buildInfoRow(Icons.directions_bus, '대중교통', '일반버스 : 2, 5, 66, 150, 151, 200, 700, 7733\n좌석버스 : 9701, 9707, 8880'),
          const Divider(height: 1, color: Colors.grey),

          // 영광교회 버스 운영 시간표 섹션 (타이틀, 구분선, 간격 - 동일)
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text('영광교회 버스 운영 시간표', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 1, color: Colors.grey),
          const SizedBox(height: 16),

          // 버스 시간표 표 동적으로 생성 (동일)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var route in busSchedules) _buildBusScheduleSection(route),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Center(
                  child: Text(
                    finalBusNote,
                    style: TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),

          // 하단 배너 이미지 (동일)
          Image.asset(
            'img/BottomBanner.png',
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Text('하단 배너 이미지를 불러오지 못했습니다.'));
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}