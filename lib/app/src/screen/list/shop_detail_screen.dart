import 'package:flutter/material.dart';
import 'package:flu_shop_search/app/src/model/shop_model.dart';

class ShopDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ShopModel shopModel =
        ModalRoute.of(context)!.settings.arguments as ShopModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(shopModel.str_shop_name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(shopModel.str_shop_name, style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            Text(shopModel.str_desc),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
