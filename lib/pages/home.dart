import 'package:flutter/material.dart';
import 'package:mx_crud/scoped-models/main_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../product_manager.dart';

class HomePage extends StatefulWidget {
  MainModel mainModel;

  HomePage(this.mainModel);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.mainModel.fetchData();

    super.initState();
  }

  Widget _buildProductsList() {
    return ScopedModelDescendant<MainModel>(
      builder: (context, _, model) {
        Widget content = Center(
          child: Text('No Product Found !'),
        );
        if (model.products.length > 0 && !model.isLoading) {
          content = ProductManager();
        } else if (model.isLoading) {
          content = Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          child: content,
          onRefresh: model.fetchData,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Choose'),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Manage Product'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('EasyList'),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (Container, _, model) {
              return IconButton(
                icon: Icon(model.displayFavOnly
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  model.toogleDisplayMode();
                },
              );
            },
          )
        ],
      ),
      body: _buildProductsList(),
    );
  }
}
