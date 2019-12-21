import 'package:flutter/material.dart';

class TitleDefualtWidget extends StatelessWidget {
  const TitleDefualtWidget({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 26, fontWeight: FontWeight.bold, fontFamily: 'Oswald'),
    );
  }
}
