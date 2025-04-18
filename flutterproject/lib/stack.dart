// 위젯을 겹치는 방법

import 'package:flutter/material.dart';

class Stackscreen extends StatelessWidget {
  const Stackscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stackscreen'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.yellow,
        child: Stack(
          children: [
            Container(
              width: 150,
              height: 150,
              color: Colors.blue,
            ),
            Container(
              width: 150,
              height: 150,
              margin: const EdgeInsets.only(top: 50, left: 50),
              color: Colors.purple,
            ),
            Container(
              width: 150,
              height: 150,
              margin: const EdgeInsets.only(top: 100, left: 100),
              color: Colors.redAccent,
            ),
            Container(
              width: 150,
              height: 150,
              margin: const EdgeInsets.only(top: 150, left: 150),
              color: Colors.green,
            ),
          ], // Stack
        ), // Container
      ),
    );
  }
}
