import 'package:flutter/material.dart';
import 'package:mx_crud/components/price_tag_widget.dart';
import 'package:mx_crud/models/product.dart';
import 'package:mx_crud/models/product.dart';
import 'package:mx_crud/scoped-models/main_model.dart';
import 'package:mx_crud/ui_elements/title_defualt_widget.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  ProductPage(this.product);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.title),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Image.network(product.imageURL),
              TitleDefualtWidget(
                title: product.title,
              ),
              Text(product.description),
              PriceTagWidget(
                price: product.price.toString(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Details'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  child: Text('Delete'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('are you sure'),
                          content: Text('this action cant be undone'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('CANCEL'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            FlatButton(
                              child: Text('DELETE'),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context, true);
                              },
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
