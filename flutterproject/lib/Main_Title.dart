// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutterproject/stack.dart';  // stack.dart에 정의된 Stackscreen 클래스
import 'colum_row.dart';                     // colum_row.dart에 정의된 ColumRowscreen 클래스

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // _selectedIndex값:
  // 0: 홈 화면 ("Hello World")
  // 1: Stackscreen
  // 2: ColumRowscreen
  int _selectedIndex = 0;
  
  // _pages 리스트: 인덱스 0은 홈, 1은 Stack, 2는 Column Row입니다.
  final List<Widget> _pages = <Widget>[
    const Center(
      child: Text(
        "Hello World",
        style: TextStyle(fontSize: 24),
      ),
    ),
    const Stackscreen(),    // stack.dart에서 정의된 Stackscreen (Scaffold 없이 콘텐트 위젯으로 작성)
    const ColumRowscreen(), // colum_row.dart에서 정의된 ColumRowscreen (Scaffold 없이 콘텐트 위젯으로 작성)
  ];
  
  // BottomNavigationBar의 두 항목: 인덱스 0 → _pages[1], 인덱스 1 → _pages[2]
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index + 1;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 제목을 터치하면 홈(index 0)으로 이동하도록 처리합니다.
        title: InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
          child: const Text("Test Title"),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header Part'),
            ),
            ListTile(
              title: Text('Menu 1'),
            ),
          ],
        ),
      ),
      // IndexedStack을 사용하여 _selectedIndex에 따라 화면을 전환합니다.
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      // 하단의 네비게이션 바: Home탭은 없으므로 2개 항목만 사용합니다.
      bottomNavigationBar: BottomNavigationBar(
        // 현재 선택된 항목: _selectedIndex가 0이면 홈 화면이지만,
        // 인덱스는 0 또는 1 (즉, _selectedIndex - 1)으로 변환하여 사용합니다.
        currentIndex: _selectedIndex > 0 ? _selectedIndex - 1 : 0,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.widgets),
            label: 'Stack Screen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_column),
            label: 'Column Row',
          ),
        ],
      ),
    );
  }
}
