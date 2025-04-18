// worship_time_page.dart (다른 페이지도 동일한 구조로 파일명과 타이틀만 변경)
import 'package:flutter/material.dart';

class WorshipTimePage extends StatelessWidget {
  const WorshipTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 이제 자체 Scaffold와 AppBar를 가지지 않고, 순수하게 body 내용만 반환합니다.
    return const Center(
      child: Text(
        '예배 시간 페이지\n(AppBar와 BottomNavigationBar는 MainAppScreen에서 관리)',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
