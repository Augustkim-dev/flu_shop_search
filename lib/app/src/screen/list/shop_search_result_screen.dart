import 'package:flutter/material.dart';

class ShopSearchResultScreen extends StatefulWidget {
  const ShopSearchResultScreen({super.key});

  @override
  State<ShopSearchResultScreen> createState() => _ShopSearchResultScreenState();
}

class _ShopSearchResultScreenState extends State<ShopSearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Search Result'),
      ),
    );
  }
}
