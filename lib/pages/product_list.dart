import 'package:flutter/material.dart';
import 'package:mx_crud/models/product.dart';
import 'package:mx_crud/pages/product_edit.dart';
import 'package:mx_crud/scoped-models/product_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductModel>(builder: (context, _, model) {
      return ListView.builder(
        itemCount: model.products.length,
        itemBuilder: (context, index) {
          return Dismissible(
            onDismissed: (dir) {
              if (dir == DismissDirection.endToStart) {
                model.selectProduct(index);
                model.deleteProduct();
              }
            },
            key: Key(model.products[index].title),
            background: Container(
              color: Colors.red,
            ),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                      backgroundImage:
                          AssetImage(model.products[index].imageURL)),
                  title: Text(model.products[index].title),
                  subtitle: Text('\$ ${model.products[index].title}'),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.edit,
                    ),
                    onPressed: () {
                      model.selectProduct(index);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ProductEditPage();
                      }));
                    },
                  ),
                ),
                Divider(
                  height: 16.0,
                )
              ],
            ),
          );
        },
      );
    });
  }
}
