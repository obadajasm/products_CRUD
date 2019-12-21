import 'package:flutter/material.dart';
import 'package:mx_crud/components/price_tag_widget.dart';
import 'package:mx_crud/ui_elements/title_defualt_widget.dart';

import 'address_widget.dart';

class ProductCardWidget extends StatelessWidget {
  ProductCardWidget({
    Key key,
    @required this.products,
    this.index,
  }) : super(key: key);

  final List<Map<String, dynamic>> products;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(products[index]['image']),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TitleDefualtWidget(title: products[index]['title']),
                ),
                PriceTagWidget(
                  price: products[index]['price'].toString(),
                ),
              ],
            ),
            AddressWidget(address: 'lattakia'),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  color: Theme.of(context).accentColor,
                  icon: Icon(Icons.info),
                  onPressed: () {
                    Navigator.pushNamed<bool>(context, '/product/$index');
                  },
                ),
                IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
