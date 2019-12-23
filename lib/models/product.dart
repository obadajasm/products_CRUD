import 'package:flutter/cupertino.dart';

class Product {
  final String title;
  final String description;
  final double price;
  final String imageURL;
  final bool isFavotirte;

  Product(
      {@required this.title,
      @required this.description,
      @required this.imageURL,
      @required this.price,
      this.isFavotirte = false});
}
