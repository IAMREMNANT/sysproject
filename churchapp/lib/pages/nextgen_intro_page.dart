import 'package:flutter/material.dart';

class NextgenIntroPage extends StatelessWidget {
  const NextgenIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('후대 소개')),
      body: const Center(child: Text('후대 소개 페이지')),
      // 하단 네비게이터 바는 MainAppScreen에서 관리하므로 여기에 없습니다.
    );
  }
}
