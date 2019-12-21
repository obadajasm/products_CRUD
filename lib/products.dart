import 'package:flutter/material.dart';

import 'components/price_tag_widget.dart';
import 'components/product_card_widget.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products([this.products = const []]);

  @override
  Widget build(BuildContext context) {
    print(products.length);
    return products.length > 0
        ? ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductCardWidget(products: products, index: index);
            },
          )
        : Center(child: Text('nothing found please add Products'));
  }
}
