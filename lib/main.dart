import 'package:flutter/material.dart';
import 'package:mx_crud/models/product.dart';
import 'package:mx_crud/pages/auth.dart';
import 'package:mx_crud/pages/home.dart';
import 'package:mx_crud/pages/product.dart';
import 'package:mx_crud/pages/products_admin.dart';
import 'package:mx_crud/scoped-models/main_model.dart';

import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    final MainModel mainModel = MainModel();
    return ScopedModel<MainModel>(
      model: mainModel,
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.deepPurple,
            buttonColor: Colors.deepPurpleAccent),
        //home: AuthPage(),
        routes: {
          // '/home': (context) => HomePage(_products),
          '/': (context) => AuthPage(mainModel),
          '/admin': (context) => ProudctsAdminPage(mainModel),
          '/products': (context) => HomePage(mainModel),
        },
        onGenerateRoute: (settings) {
          final List<String> pathElments = settings.name.split('/');
          if (pathElments[0] != '') return null;
          if (pathElments[1] == 'product') {
            final String productId = pathElments[2];
            final Product product =
                mainModel.products.firstWhere((Product product) {
              return product.id == productId;
            });

            return MaterialPageRoute<bool>(
              builder: (contex) => ProductPage(product),
            );
          }
          return null;
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute<bool>(
            builder: (contex) => HomePage(mainModel),
          );
        },
      ),
    );
  }
}
