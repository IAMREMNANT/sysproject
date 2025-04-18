// worship_time_page.dart (다른 페이지도 동일한 구조로 파일명과 타이틀만 변경)
import 'package:flutter/material.dart';

class WordPage extends StatelessWidget {
  const WordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('말씀')),
      body: const Center(child: Text('말씀 페이지')),
      // 하단 네비게이션 바는 MainAppScreen에서 관리하므로 여기서 정의하지 않습니다.
      // bottomNavigationBar: AppBottomNavigationBar(), // 이 줄 제거
    );
  }
}
