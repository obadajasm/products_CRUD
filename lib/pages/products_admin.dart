import 'package:flutter/material.dart';
import 'package:mx_crud/models/product.dart';

import 'package:mx_crud/pages/product_edit.dart';
import 'package:mx_crud/pages/product_list.dart';

class ProudctsAdminPage extends StatelessWidget {
  final Function _deleteProduct;
  final Function _updateProduct;
  final Function _addProduct;
  final List<Product> _product;
  ProudctsAdminPage(this._addProduct, this._deleteProduct, this._updateProduct,
      this._product);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Choose'),
              ),
              ListTile(
                leading: Icon(Icons.shop),
                title: Text('All Products'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Manage Products'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Manage Product', icon: Icon(Icons.create)),
              Tab(text: 'My Product', icon: Icon(Icons.list))
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ProductEditPage(addProduct: _addProduct),
            ProductListPage(_product, _updateProduct, _deleteProduct)
          ],
        ),
      ),
    );
  }
}
