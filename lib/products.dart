import 'package:flutter/material.dart';
import 'package:mx_crud/models/product.dart';
import 'package:mx_crud/scoped-models/main_model.dart';

import 'package:scoped_model/scoped_model.dart';

import 'components/product_card_widget.dart';

class Products extends StatelessWidget {
  Widget _buildProductList(List<Product> products) {
    Widget ProductCard;
    if (products.length > 0) {
      ProductCard = ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductCardWidget(products: products, index: index);
        },
      );
    } else
      ProductCard = Center(child: Text('nothing found please add Products'));
    return ProductCard;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (contex, _, model) {
        return _buildProductList(model.displayedProduct);
      },
    );
  }
}
