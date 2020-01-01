import 'package:flutter/material.dart';
import 'package:mx_crud/models/product.dart';
import 'package:mx_crud/pages/product_edit.dart';
import 'package:mx_crud/scoped-models/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatefulWidget {
  final MainModel model;
  ProductListPage(this.model);
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    widget.model.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, _, model) {
      return ListView.builder(
        itemCount: model.products.length,
        itemBuilder: (context, index) {
          return Dismissible(
            onDismissed: (dir) {
              if (dir == DismissDirection.endToStart) {
                model.selectProduct(model.products[index].id);
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
                          NetworkImage(model.products[index].imageURL)),
                  title: Text(model.products[index].title),
                  subtitle: Text('${model.products[index].title}'),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.edit,
                    ),
                    onPressed: () {
                      model.selectProduct(model.products[index].id);
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
