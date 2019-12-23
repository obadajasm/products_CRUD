import 'package:flutter/material.dart';
import 'package:mx_crud/models/product.dart';
import 'package:mx_crud/scoped-models/product_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'components/price_tag_widget.dart';
import 'components/product_card_widget.dart';

class Products extends StatelessWidget {
  Widget _buildProductList(List<Product> products) {
    return products.length > 0
        ? ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductCardWidget(products: products, index: index);
            },
          )
        : Center(child: Text('nothing found please add Products'));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductModel>(
      builder: (contex, _, model) {
        return _buildProductList(model.displayedProduct);
      },
    );
  }
}
