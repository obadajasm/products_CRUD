import 'package:flutter/material.dart';

class AddressWidget extends StatelessWidget {
  String address;
  AddressWidget({
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Text(address),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(width: 2, color: Colors.grey)),
    );
  }
}
