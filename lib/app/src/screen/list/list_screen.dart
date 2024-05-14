import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<String> lstShop = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop List'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            width: MediaQuery.of(context).size.width,
            height: 48,
          ),
          Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: 48,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Image.network(
                                  'https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20230516_56%2F1684202845985xPlS1_JPEG%2F2289333851333054_1602512952.JPG&type=sc960_832'),
                              width: 72,
                              height: 72,
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name of Shop',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                Text('description of shop'),
                                Text('Category'),
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
