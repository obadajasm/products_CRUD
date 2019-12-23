import 'package:flutter/material.dart';
import 'package:mx_crud/models/product.dart';
import 'package:mx_crud/pages/auth.dart';
import 'package:mx_crud/pages/home.dart';
import 'package:mx_crud/pages/product.dart';
import 'package:mx_crud/pages/products_admin.dart';
import 'package:mx_crud/scoped-models/product_model.dart';
import 'package:scoped_model/scoped_model.dart';
// import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Product> _products = [];

  Widget build(BuildContext context) {
    return ScopedModel<ProductModel>(
      model: ProductModel(),
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.deepPurple,
            buttonColor: Colors.deepPurpleAccent),
        //home: AuthPage(),
        routes: {
          // '/home': (context) => HomePage(_products),
          '/': (context) => AuthPage(),
          '/admin': (context) => ProudctsAdminPage(),
        },
        onGenerateRoute: (settings) {
          final List<String> pathElments = settings.name.split('/');
          if (pathElments[0] != '') return null;
          if (pathElments[1] == 'product') {
            final int index = int.parse(pathElments[2]);
            print('index form main $index');
            return MaterialPageRoute<bool>(
              builder: (contex) => ProductPage(
                index: index,
              ),
            );
          }
          return null;
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute<bool>(
            builder: (contex) => HomePage(),
          );
        },
      ),
    );
  }
}
