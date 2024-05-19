import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NestedListTabScreen extends StatefulWidget {
  const NestedListTabScreen({super.key});

  @override
  State<NestedListTabScreen> createState() => _NestedListTabScreenState();
}

class _NestedListTabScreenState extends State<NestedListTabScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text('List Screen'),
                pinned: true,
                floating: true,
                forceElevated: false,
              ),
            ];
          },
          body: ListView(
            padding: EdgeInsets.all(12),
            children: [
              banner(),
              searchBar(),
              tabController(),
            ],
          ),
        ),
      ),
    );
  }

  Widget banner() {
    return Container(
      height: 150,
      color: Colors.orange,
      child: Text('banner'),
      alignment: Alignment.center,
    );
  }

  Widget searchBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget tabController() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
      child: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            TabBar(
              tabs: [
                Tab(child: Text('All')),
                Tab(child: Text('On-Line')),
                Tab(child: Text('Off-Line')),
              ],
            ),
            tabView(),
          ],
        ),
      ),
    );
  }

  Widget tabView() {
    return Container(
      height: 800,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TabBarView(
          children: [
            mainListView(),
            Text('online'),
            Text('offline'),
          ],
        ),
      ),
    );
  }

  Widget mainListView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                children: [
                  // 이미지 조금 진한걸로 할 때 roundRect 적용하기
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      child: Image.network(
                        'https://t1.daumcdn.net/cfile/tistory/2327D84754754B4D17',
                      ),
                      width: 72,
                      height: 72,
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name of Shop $index',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontFamily: 'Plus_Jakarta_Sans',
                            color: Color(0xff0D141C)),
                      ),
                      Text('description of shop',
                          style: TextStyle(
                              fontFamily: 'Plus_Jakarta_Sans',
                              color: Color(0xff4F7396))),
                      Text('Category',
                          style: TextStyle(
                              fontFamily: 'Plus_Jakarta_Sans',
                              color: Color(0xff4F7396))),
                    ],
                  ),
                ],
              ),
              // Divider(height: 16),
              SizedBox(height: 25),
            ],
          );
        },
      ),
    );
  }
}
