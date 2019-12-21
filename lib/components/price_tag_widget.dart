import 'package:flutter/material.dart';

class PriceTagWidget extends StatelessWidget {
  PriceTagWidget({
    Key key,
    @required this.price,
  }) : super(key: key);

  String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(5)),
      child: Text(
        '$price \$',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
