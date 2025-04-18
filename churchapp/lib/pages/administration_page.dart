// worship_time_page.dart (다른 페이지도 동일한 구조로 파일명과 타이틀만 변경)
import 'package:flutter/material.dart';

class AdministrationPage extends StatelessWidget {
  const AdministrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('선교현황')),
      body: const Center(child: Text('선교현황 페이지')),
      // 하단 네비게이터 바는 여기서 제외하거나, 부모 위젯에서 관리
      // bottomNavigationBar: AppBottomNavigationBar(), // <-- 이렇게 하위 페이지에서 직접 넣으면 중복됨.
    );
  }
}
