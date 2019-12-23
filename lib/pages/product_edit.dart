import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mx_crud/models/product.dart';
import 'package:mx_crud/scoped-models/product_model.dart';
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
    return ScopedModelDescendant<ProductModel>(builder: (context, _, model) {
      final Widget PageContent = _buildPageContent(context, model);
      return model.selectedProductIndex == null
          ? PageContent
          : Scaffold(
              appBar: AppBar(
                title: Text('Detail'),
              ),
              body: PageContent,
            );
    });
  }

  GestureDetector _buildPageContent(BuildContext context, ProductModel model) {
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
              RaisedButton(
                child: Text('Save'),
                onPressed: () => _submitForm(model.addProduct,
                    model.updateProduct, model.selectedProductIndex),
              )
            ],
          ),
        ),
      ),
    );
  }

  _submitForm(
      Function addProduct, Function updateProduct, int selectedIndexProduct) {
    if (_formKey.currentState.validate()) return;
    _formKey.currentState.save();

    if (selectedIndexProduct == null)
      addProduct(
        Product(
          title: _formData['title'],
          description: _formData['description'],
          imageURL: _formData['image'],
          price: _formData['price'],
        ),
      );
    else
      updateProduct(
        Product(
          title: _formData['title'],
          description: _formData['description'],
          imageURL: _formData['image'],
          price: _formData['price'],
        ),
      );
    Navigator.pushReplacementNamed(context, '/s');
  }

  Widget _buildPriceTextField(Product product) {
    return TextFormField(
      validator: (s) {
        if (s.isEmpty || !RegExp(r'^[0-9]+\$').hasMatch(s))
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
