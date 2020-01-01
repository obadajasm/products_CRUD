import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mx_crud/models/product.dart';
import 'package:mx_crud/scoped-models/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductEditPage extends StatefulWidget {
  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'image': 'assets/food.png',
    'price': null
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, _, model) {
      final Widget PageContent = _buildPageContent(context, model);
      return model.selectedProductId == null
          ? PageContent
          : Scaffold(
              appBar: AppBar(
                title: Text('Detail'),
              ),
              body: PageContent,
            );
    });
  }

  GestureDetector _buildPageContent(BuildContext context, MainModel model) {
    Widget btn;
    Widget _submit() {
      return model.isLoading
          ? Center(child: CircularProgressIndicator())
          : btn = RaisedButton(
              child: Text('Save'),
              onPressed: () => _submitForm(
                  model.addProduct,
                  model.updateProduct,
                  model.selectedProductId,
                  model.selectProduct));
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTitleTextField(model.selectedProduct),
              _buildDescriptionTextField(model.selectedProduct),
              _buildPriceTextField(model.selectedProduct),
              SizedBox(
                height: 32.0,
              ),
              _submit(),
            ],
          ),
        ),
      ),
    );
  }

  _submitForm(Function addProduct, Function updateProduct,
      String selectedIndexProduct, Function setSelcetedProductIndex) {
    if (_formKey.currentState.validate()) return;
    _formKey.currentState.save();

    if (selectedIndexProduct == null) {
      addProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      ).then((success) {
        if (success) {
          Navigator.pushReplacementNamed(context, '/s')
              .then((_) => setSelcetedProductIndex(null));
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Something went Wrong ......'),
                content: Text('please try again ! '),
                actions: <Widget>[
                  FlatButton(
                    child: Text('ok'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              );
            },
          );
        }
      });
    } else {
      updateProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      ).then((_) => Navigator.pushReplacementNamed(context, '/s')
          .then((_) => setSelcetedProductIndex(null)));
    }
  }

  Widget _buildPriceTextField(Product product) {
    return TextFormField(
      validator: (s) {
        if (s.isEmpty || RegExp(r'^[0-9]+\$').hasMatch(s))
          return 'please enter a number';
      },
      initialValue: product == null ? '' : product.price.toString(),
      decoration: InputDecoration(labelText: 'Product price'),
      keyboardType: TextInputType.number,
      onSaved: (s) {
        _formData['price'] = double.parse(s);
      },
    );
  }

  Widget _buildTitleTextField(Product product) {
    return TextFormField(
      validator: (s) {
        if (s.isEmpty || s.length > 5) return 'title is requierd';
      },
      initialValue: product == null ? '' : product.title,
      decoration: InputDecoration(labelText: 'Product title'),
      onSaved: (value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    return TextFormField(
      validator: (s) {
        if (s.isEmpty || s.length > 5) return 'Description is requierd';
      },
      initialValue: product == null ? '' : product.description,
      decoration: InputDecoration(labelText: 'Product description'),
      maxLines: 4,
      onSaved: (value) {
        _formData['description'] = value;
      },
    );
  }
}
