import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const AppBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    // 이 위젯은 MaterialApp에서 제공하는 기본적인 위젯들만 사용하므로 material.dart 외에는 필요 없습니다.
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book), // 말씀 아이콘 적당한 것으로 선택
          label: '말씀',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people), // 교회소개 아이콘
          label: '교회소개',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group), // 후대소개 아이콘
          label: '후대소개',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt), // 행정 아이콘
          label: '행정',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue[800], // 선택된 아이템 색상
      unselectedItemColor: Colors.grey, // 선택되지 않은 아이템 색상
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed, // 아이템이 4개 이상일 때 고정되도록 설정
    );
  }
}
