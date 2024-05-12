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
                  return Text('$index');
                }),
          ),
        ],
      ),
    );
  }
}
