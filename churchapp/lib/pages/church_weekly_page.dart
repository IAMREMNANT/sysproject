import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// 데이터 모델 (주보 정보)
class WeeklyInfo {
  final String date;
  final String title;
  final String sermonTitle;
  final String sermonPassage;
  final String pdfAssetPath; // 앱 에셋 내 PDF 파일 경로

  const WeeklyInfo({
    required this.date,
    required this.title,
    required this.sermonTitle,
    required this.sermonPassage,
    required this.pdfAssetPath,
  });
}

class ChurchWeeklyPage extends StatefulWidget {
  const ChurchWeeklyPage({super.key});

  @override
  State<ChurchWeeklyPage> createState() => _ChurchWeeklyPageState();
}

class _ChurchWeeklyPageState extends State<ChurchWeeklyPage> with TickerProviderStateMixin {
  late TabController _tabController;
  // 주보 목록 데이터 (예시 - 실제로는 API에서 가져와야 함)
  // PDF 파일은 프로젝트 루트의 church_weekly 폴더에 있다고 가정하고 경로 수정
  final List<WeeklyInfo> _weeklyList = [
    WeeklyInfo(date: '2025년 4월 6일', title: '[주보]2025년 00주차', sermonTitle: '영적싸움(216) 평강의 하나님', sermonPassage: '데살로니가전서 5:19~28', pdfAssetPath: 'church_weekly/church_weekly_250406.pdf'),
    WeeklyInfo(date: '2025년 3월 30일', title: '[주보]2025년 00주차', sermonTitle: '영적싸움(215) 하나님의 뜻', sermonPassage: '데살로니가전서 5:12~18', pdfAssetPath: 'church_weekly/church_weekly_250330.pdf'),
    WeeklyInfo(date: '2025년 3월 23일', title: '[주보]2025년 00주차', sermonTitle: '영적싸움(214) 재림과 우리가 할 일', sermonPassage: '데살로니가전서 5:1~11', pdfAssetPath: 'church_weekly/church_weekly_250323.pdf'),
    // TODO: API 연동 시, 실제 주보 목록을 여기에 로드해야 합니다.
  ];

  int _currentWeeklyIndex = 0; // 현재 선택된 주보 (탭) 인덱스

  // PDF 뷰어 컨트롤러 추가
  final PdfViewerController _pdfViewerController = PdfViewerController();
  // <<< Line 44 오류 해결: _totalPages 필드 삭제 >>>
  // int _totalPages = 0; // 이 줄 삭제

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _weeklyList.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    // PdfViewerController는 dispose할 필요 없음
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentWeeklyIndex = _tabController.index;
        // 탭 변경 시 PDF 뷰어를 첫 페이지로 이동
        _pdfViewerController.jumpToPage(1);
      });
    }
  }

  // PDF 로드 실패 시 콜백
  void _onDocumentLoadFailed(PdfDocumentLoadFailedDetails details) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('주보 파일을 불러오지 못했습니다: ${details.description}'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // 문서 로드 완료 시 전체 페이지 수 업데이트 (필드 삭제로 인해 로직도 삭제)
  // 만약 다른 목적으로 전체 페이지 수가 필요하다면 필드를 다시 추가하고 사용해야 합니다.
  void _onDocumentLoaded(PdfDocumentLoadedDetails details) {
     // setState(() { // _totalPages 필드 삭제로 인해 이 로직도 삭제
     //   _totalPages = details.document.pages.count;
     // });
     // print('PDF 로드 완료. 총 페이지: ${details.document.pages.count}'); // 확인용 출력은 가능
  }

   // 페이지 변경 시 현재 페이지 업데이트 (상태로 유지하지 않아도 됨)
   void _onPageChanged(PdfPageChangedDetails details) {
     // _pdfViewerController.pageNumber가 자동으로 업데이트됨.
     // 만약 페이지가 변경될 때마다 어떤 로직을 수행해야 한다면 여기에 추가
   }

   // PDF 페이지 이동 함수 (컨트롤러 사용) - 이 함수들은 더 이상 호출되지 않으므로 삭제
   // void _goToPreviousPage() { ... }
   // void _goToNextPage() { ... }


  @override
  Widget build(BuildContext context) {
    if (_weeklyList.isEmpty) {
      return const Center(child: Text('주보 목록을 불러오는 중... 또는 데이터 없음'));
    }

    final currentWeekly = _weeklyList[_currentWeeklyIndex];

    return Scaffold(
      body: Column(
        children: [
          // 1. 탭 바 영역 (주보 날짜)
          Container(
            color: Colors.grey[200],
            child: TabBar(
              controller: _tabController,
              tabs: _weeklyList.map((weekly) => Tab(text: weekly.date)).toList(),
              isScrollable: true,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[600],
              indicatorColor: Colors.black,
              indicatorWeight: 3.0,
            ),
          ),

          // 2. 탭 뷰 영역 (각 탭의 콘텐츠)
          Expanded(
            child: ListView(
              children: [
                _buildWeeklyInfoCard(currentWeekly),

                // 2-2. PDF 뷰어 영역
                _buildPdfViewer(currentWeekly.pdfAssetPath),

                // 2-3. PDF 페이지네이션 정보 및 컨트롤 (모두 삭제됨)
                // _buildPdfPaginationInfo(), // 페이징 정보 삭제
                // _buildPdfPageControls(), // 페이지 이동 버튼 삭제

                // 2-4. 하단 배너 이미지
                _buildBottomBanner(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 위젯 빌더 헬퍼 함수들 ---
  // _buildWeeklyInfoCard, _buildPdfViewer, _buildBottomBanner 함수만 남기고,
  // _buildPdfPaginationInfo, _buildPdfPageControls 함수는 삭제되었습니다.
  // _totalPages 필드를 사용하던 _onDocumentLoaded 콜백 내 로직도 삭제 또는 수정되었습니다.


  Widget _buildWeeklyInfoCard(WeeklyInfo weekly) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(weekly.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(weekly.sermonTitle, style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 4),
            Text(weekly.sermonPassage, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  Widget _buildPdfViewer(String pdfPath) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6, // 높이 조절 필요
      child: SfPdfViewer.asset(
        pdfPath,
        controller: _pdfViewerController,
        onDocumentLoadFailed: _onDocumentLoadFailed,
        onDocumentLoaded: _onDocumentLoaded, // 이 콜백 자체를 연결 해제해도 무방
        onPageChanged: _onPageChanged,       // 이 콜백 자체를 연결 해제해도 무방
      ),
    );
  }

  // _buildPdfPaginationInfo 함수는 삭제되었습니다.
  // _buildPdfPageControls 함수는 삭제되었습니다.

  // 하단 배너 빌더
  Widget _buildBottomBanner() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: Image.asset(
        'img/BottomBanner.png', // pubspec.yaml과 일치하는 경로
        width: double.infinity,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 60, color: Colors.orange[100], alignment: Alignment.center,
            child: const Text('배너 이미지를 불러올 수 없습니다.'),
          );
        },
      ),
    );
  }

}