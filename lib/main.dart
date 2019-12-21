import 'package:flutter/material.dart';
import 'package:mx_crud/pages/auth.dart';
import 'package:mx_crud/pages/home.dart';
import 'package:mx_crud/pages/product.dart';
import 'package:mx_crud/pages/products_admin.dart';
// import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  void _updateProduct(int index, Map<String, dynamic> product) {
    setState(() {
      _products[index] = product;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple,
          buttonColor: Colors.deepPurpleAccent),
      //home: AuthPage(),
      routes: {
        // '/home': (context) => HomePage(_products),
        '/': (context) => AuthPage(),
        '/admin': (context) => ProudctsAdminPage(
            _addProduct, _deleteProduct, _updateProduct, _products),
      },
      onGenerateRoute: (settings) {
        final List<String> pathElments = settings.name.split('/');
        if (pathElments[0] != '') return null;
        if (pathElments[1] == 'product') {
          final int index = int.parse(pathElments[2]);
          print('index form main $index');
          return MaterialPageRoute<bool>(
            builder: (contex) => ProductPage(
                title: _products[index]['title'],
                imageURL: _products[index]['image']),
          );
        }
        return null;
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute<bool>(
          builder: (contex) => HomePage(_products),
        );
      },
    );
  }
}
