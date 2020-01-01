import 'package:flutter/cupertino.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageURL;
  final bool isFavotirte;
  final String userEmail;
  final String userId;

  Product(
      {@required this.title,
      @required this.description,
      @required this.imageURL,
      @required this.price,
      @required this.userEmail,
      @required this.userId,
      @required this.id,
      this.isFavotirte = false});
}
