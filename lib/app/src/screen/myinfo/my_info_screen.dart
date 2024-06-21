import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyInfoScreen extends StatelessWidget {
  const MyInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Info')),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text('로그인정보표시'),
            ),
            SizedBox(height: 24),
            Container(
              width: double.infinity,
              height: 250,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text('자기소개 영역'),
            ),
            SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text('나의 샵 바로가기'),
            ),
          ],
        ),
      ),
    );
  }
}
