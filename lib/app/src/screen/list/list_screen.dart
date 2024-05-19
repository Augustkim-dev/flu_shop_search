import 'dart:ffi';
import 'package:flu_shop_search/app/src/widget/textfiled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<String> lstShop = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: TextFormFieldCustom(
                hintText: 'Search Shop',
                isPasswordField: false,
                isReadOnly: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                validator: (value) => inputSearchValidator(value),
                controller: _searchController,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Suggest Shop List',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  fontFamily: 'Plus_Jakarta_Sans'),
            ),
            SizedBox(height: 8),
            Expanded(
              child: mainListView(),
            ),
          ],
        ),
      ),
    );
  }

  inputSearchValidator(value) {
    // 검색 필드 검증 함수
    if (value.isEmpty) {
      return '검색어를 입력해주세요';
    }
    return null;
  }

  Widget mainListView() {
    return ListView.builder(
      itemCount: 10,
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name of Shop',
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
    );
  }
}
