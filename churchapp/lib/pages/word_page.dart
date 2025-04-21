import 'package:flutter/material.dart';
// worship_time_page.dart 파일이 있는 실제 경로로 수정해주세요.
// 이 페이지에 showBanner 파라미터 추가 및 조건부 렌더링 구현이 필요합니다.
import 'package:churchapp/pages/worship_time_page.dart';

// 데이터 모델 (예시)
class SermonData {
  final String number;
  final String date;
  final String title;
  final String subtitle; // 예: 성경 구절
  final String preacher;

  const SermonData({
    required this.number,
    required this.date,
    required this.title,
    required this.subtitle,
    required this.preacher,
  });
}

class WordPage extends StatefulWidget {
  const WordPage({super.key});

  @override
  State<WordPage> createState() => _WordPageState();
}

class _WordPageState extends State<WordPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['주일 1, 2부', '원단메시지', '새벽헌신예배'];

  // 검색 관련 상태
  String? _selectedSearchOption = '제목'; // 드롭다운 초기값
  final TextEditingController _searchController = TextEditingController();

  // 페이지네이션 관련 상태
  int _currentPage = 1;
  final int _totalPages = 8; // 총 페이지 수 (예시 - API 연동 시 동적으로 변경)

  // 테이블 데이터 (예시 - 실제로는 API 등에서 가져와야 함)
  final List<SermonData> _sermonList = List.generate(
    15,
    (index) => SermonData(
      number: (605 - index).toString(),
      date: '25-${(30 - index).toString().padLeft(2, '0')}-30',
      title: '영적싸움(${216 - index}) 평강의 하나님',
      subtitle: '데살로니가전서 5:19~28',
      preacher: '강태흥',
    ),
  );


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _changePage(int newPage) {
    if (newPage >= 1 && newPage <= _totalPages && newPage != _currentPage) {
      setState(() { _currentPage = newPage; });
    }
  }

  void _performSearch() {
    FocusScope.of(context).unfocus();
    setState(() { _currentPage = 1; });
  }

  // --- 다이얼로그 표시 함수 수정 ---
  void _showWorshipTimeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          // <<< 1. 배경색 흰색으로 변경 >>>
          backgroundColor: Colors.white,
          // title: const Text('예배 시간 안내'), // 필요시 주석 해제
          contentPadding: const EdgeInsets.all(16.0),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              // <<< 2. 배너 숨기기 위한 파라미터 전달 >>>
              // !!! 중요: WorshipTimePage 클래스에 showBanner 파라미터 및
              //          해당 파라미터에 따른 조건부 렌더링 로직을 추가해야 합니다.
              child: WorshipTimePage(showBanner: false),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('닫기'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // 다이얼로그 닫기
              },
            ),
          ],
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(15.0)
           ),
        );
      },
    );
  }
  // --- 다이얼로그 표시 함수 끝 ---


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 1. 탭 바 영역
          Container(
            color: Colors.grey[200],
            child: TabBar(
              controller: _tabController,
              tabs: _tabs.map((String name) => Tab(text: name)).toList(),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[600],
              indicatorColor: Colors.black,
              indicatorWeight: 3.0,
              onTap: (index) {
                 setState(() {
                   _currentPage = 1;
                   _searchController.clear();
                 });
              },
            ),
          ),

          // 2. 탭 뷰 영역
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _tabs.map((String tabName) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTitleSection(), // 수정됨 (InkWell 추가)
                      _buildSearchSection(),
                      _buildTableHeader(),
                      _buildDataTable(),
                      if (_sermonList.isNotEmpty && _totalPages > 1)
                         _buildPagination(),
                      _buildBottomBanner(), // 여기는 페이지의 배너 (팝업과 무관)
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // --- 위젯 빌더 헬퍼 함수들 ---

  // "예배안내" 박스영역 수정 (InkWell 추가)
  Widget _buildTitleSection() {
    return InkWell(
      onTap: () {
        _showWorshipTimeDialog(context);
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Row(
          children: [
            Text('예배안내', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            Icon(Icons.access_time_filled_rounded, color: Colors.black, size: 24),
          ],
        ),
      ),
    );
  }

  // 검색 영역 빌더
  Widget _buildSearchSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
             height: 40,
             decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedSearchOption,
                items: <String>['제목', '설교자', '본문']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(fontSize: 14)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() { _selectedSearchOption = newValue; });
                },
                 style: const TextStyle(color: Colors.black, fontSize: 14),
                 icon: const Icon(Icons.arrow_drop_down),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: '검색어를 입력하세요',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                   hintStyle: TextStyle(fontSize: 14),
                ),
                style: const TextStyle(fontSize: 14),
                onSubmitted: (_) => _performSearch(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: _performSearch,
             style: ElevatedButton.styleFrom(
               backgroundColor: Colors.grey[300],
               foregroundColor: Colors.black,
               minimumSize: const Size(60, 40),
               elevation: 1,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(4.0)
               )
             ),
            child: const Text('검색'),
          ),
        ],
      ),
    );
  }

  // 테이블 헤더 빌더
  Widget _buildTableHeader() {
    const headerStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
    const textAlign = TextAlign.center;
    return Container(
       decoration: BoxDecoration(
         border: Border(
           top: BorderSide(color: Colors.grey[400]!),
           bottom: BorderSide(color: Colors.grey[400]!),
         ),
         color: Colors.grey[200],
       ),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: const Row(
        children: [
          SizedBox(width: 50, child: Text('번호', style: headerStyle, textAlign: textAlign)),
          SizedBox(width: 100, child: Text('날짜', style: headerStyle, textAlign: textAlign)),
          Expanded(child: Text('제목', style: headerStyle, textAlign: textAlign)),
          SizedBox(width: 80, child: Text('설교자', style: headerStyle, textAlign: textAlign)),
        ],
      ),
    );
  }

  // 데이터 테이블 빌더
  Widget _buildDataTable() {
    if (_sermonList.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(50),
        alignment: Alignment.center,
        child: const Text('표시할 데이터가 없습니다.'),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _sermonList.length,
      itemBuilder: (context, index) {
        final sermon = _sermonList[index];
        return _buildDataRow(sermon);
      },
    );
  }

  // 데이터 행(Row) 빌더
  Widget _buildDataRow(SermonData sermon) {
    const cellStyle = TextStyle(fontSize: 14);
    const textAlign = TextAlign.center;
    return InkWell(
      onTap: () { /* 행 클릭 로직 */ },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
        ),
        child: Row(
          children: [
            SizedBox(width: 50, child: Text(sermon.number, style: cellStyle, textAlign: textAlign)),
            SizedBox(width: 100, child: Text(sermon.date, style: cellStyle, textAlign: textAlign)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sermon.title, style: cellStyle.copyWith(fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 3),
                    Text(sermon.subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600]), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ),
            SizedBox(width: 80, child: Text(sermon.preacher, style: cellStyle, textAlign: textAlign)),
          ],
        ),
      ),
    );
  }

  // 페이지네이션 컨트롤 빌더
  Widget _buildPagination() {
    const int maxVisiblePages = 5;
    int startPage = 1;
    int endPage = _totalPages;
    if (_totalPages > maxVisiblePages) {
      startPage = _currentPage - (maxVisiblePages ~/ 2);
      if (startPage < 1) startPage = 1;
      endPage = startPage + maxVisiblePages - 1;
      if (endPage > _totalPages) {
        endPage = _totalPages;
        startPage = endPage - maxVisiblePages + 1;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           IconButton(icon: const Icon(Icons.first_page, size: 24), onPressed: _currentPage > 1 ? () => _changePage(1) : null, tooltip: '첫 페이지', splashRadius: 20, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
           IconButton(icon: const Icon(Icons.chevron_left, size: 24), onPressed: _currentPage > 1 ? () => _changePage(_currentPage - 1) : null, tooltip: '이전 페이지', splashRadius: 20, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
          for (int i = startPage; i <= endPage; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: TextButton(
                onPressed: () => _changePage(i),
                style: TextButton.styleFrom(
                  minimumSize: const Size(32, 32), padding: EdgeInsets.zero,
                  backgroundColor: _currentPage == i ? Colors.grey[300] : Colors.transparent,
                  foregroundColor: Colors.black, side: BorderSide(color: Colors.grey[400]!),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                ),
                child: Text('$i', style: const TextStyle(fontSize: 14)),
              ),
            ),
          IconButton(icon: const Icon(Icons.chevron_right, size: 24), onPressed: _currentPage < _totalPages ? () => _changePage(_currentPage + 1) : null, tooltip: '다음 페이지', splashRadius: 20, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
          IconButton(icon: const Icon(Icons.last_page, size: 24), onPressed: _currentPage < _totalPages ? () => _changePage(_totalPages) : null, tooltip: '마지막 페이지', splashRadius: 20, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
        ],
      ),
    );
  }

  // 하단 배너 빌더 (이 배너는 WordPage 자체의 배너이며, 팝업과 무관)
  Widget _buildBottomBanner() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: Image.asset(
        'assets/images/world_mission_banner.png', // 실제 경로 확인 및 pubspec.yaml 등록 필요
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

} // _WordPageState 클래스 끝