// lib/home.dart

import 'package:flutter/material.dart';
import 'package:churchapp/main_app_screen.dart'; // MainAppScreen import

void main() {
  // 위젯 바인딩 초기화 (이것만 남겨둡니다. 다른 플러그인 사용 시 필요할 수 있습니다.)
  WidgetsFlutterBinding.ensureInitialized();

  // 앱 실행
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '교회 앱', // 앱 타이틀
      theme: ThemeData(
        primarySwatch: Colors.blue, // 앱 전체 기본 테마 색상
        visualDensity: VisualDensity.adaptivePlatformDensity, // 플랫폼에 따라 밀도 조정
        fontFamily: 'Pretendard', // Pretendard 폰트 사용 (pubspec.yaml 확인)
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // 앱바 배경색 흰색 (이미지와 유사)
          foregroundColor: Colors.black, // 앱바 아이콘/텍스트 색상 검정
          elevation: 1, // 앱바 그림자
        ),
      ),
      // 앱 시작 페이지를 MainAppScreen으로 설정
      home: const MainAppScreen(),
      debugShowCheckedModeBanner: false, // 디버그 배너 숨기기
    );
  }
}
