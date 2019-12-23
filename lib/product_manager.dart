import 'package:flutter/material.dart';
import 'package:mx_crud/models/product.dart';

import './products.dart';

class ProductManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: Products())],
    );
  }
}
