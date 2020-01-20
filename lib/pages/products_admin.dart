import 'package:flutter/material.dart';

import 'package:mx_crud/pages/product_edit.dart';
import 'package:mx_crud/pages/product_list.dart';
import 'package:mx_crud/scoped-models/main_model.dart';

class ProudctsAdminPage extends StatelessWidget {
  MainModel model;
  ProudctsAdminPage(this.model);
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
                  Navigator.pushReplacementNamed(context, '/products');
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
        body: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('go back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              child: (Text('current User')),
              onPressed: () {},
            ),
            TabBarView(
              children: <Widget>[
                ProductEditPage(),
                ProductListPage(model),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
