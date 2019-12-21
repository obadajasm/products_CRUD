import 'package:flutter/material.dart';
import 'package:mx_crud/pages/product_edit.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String, dynamic>> _product;
  final Function updateProduct;
  final Function deleteProduct;
  ProductListPage(this._product, this.updateProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _product.length,
      itemBuilder: (context, index) {
        return Dismissible(
          onDismissed: (dir) {
            if (dir == DismissDirection.endToStart) deleteProduct(index);
          },
          key: Key(_product[index]['title']),
          background: Container(
            color: if (Disimm)Colors.red,
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                  leading: CircleAvatar(
                      backgroundImage: AssetImage(_product[index]['image'])),
                  title: Text(_product[index]['title']),
                  subtitle: Text('\$ ${_product[index]['title']}'),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.edit,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ProductEditPage(
                          product: _product[index],
                          updateProduct: updateProduct,
                          index: index,
                        );
                      }));
                    },
                  )),
              Divider(
                height: 16.0,
              )
            ],
          ),
        );
      },
    );
  }
}
