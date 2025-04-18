import 'package:flutter/material.dart';

class ColumRowscreen extends StatelessWidget {
  const ColumRowscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Column&Row Screen'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 2,
                  color: Colors.blue,
                ),
                const SizedBox(height: 0), // 상자 사이 간격 추가 (원하는 경우)
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 2,
                  color: Colors.red,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 100,
                  color: Colors.green,
                ),
                const SizedBox(height: 0), // 상자 사이 간격 추가 (원하는 경우)
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 100,
                  color: Colors.purple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
