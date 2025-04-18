import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Church App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Church App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // 검색 기능 구현
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // 프로필 관련 기능 구현
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 상단 메인배너. assets 폴더 내 img/Main Banner.png 파일을 불러옵니다.
            Image.asset(
              'img/MainBanner.png',
              width: 412,
              height: 280,
            ),
            const SizedBox(height: 10),
            // 추가 콘텐츠 예시: 중앙에 환영 메시지
            const Center(
              child: Text(
                'Welcome to our Church App!',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // 홈으로 이동
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Messages'),
              onTap: () {
                // 메시지 관련 동작
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // 설정 관련 동작
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      // Removed duplicate body parameter
    );
  }
}
