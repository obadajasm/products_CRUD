import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mx_crud/models/product.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Product product;
  final int index;

  ProductEditPage(
      {this.addProduct, this.index, this.product, this.updateProduct});

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
    final Widget PageContent = GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTitleTextField(),
              _buildDescriptionTextField(),
              _buildPriceTextField(),
              SizedBox(
                height: 32.0,
              ),
              RaisedButton(
                child: Text('Save'),
                onPressed: _submitForm,
              )
            ],
          ),
        ),
      ),
    );
    return widget.product == null
        ? PageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Detail'),
            ),
            body: PageContent,
          );
  }

  _submitForm() {
    if (_formKey.currentState.validate()) return;
    _formKey.currentState.save();

    if (widget.product == null)
      widget.addProduct(
        Product(
          title: _formData['title'],
          description: _formData['description'],
          imageURL: _formData['image'],
          price: _formData['price'],
        ),
      );
    else
      widget.updateProduct(
        widget.index,
        Product(
          title: _formData['title'],
          description: _formData['description'],
          imageURL: _formData['image'],
          price: _formData['price'],
        ),
      );
    Navigator.pushReplacementNamed(context, '/s');
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      validator: (s) {
        if (s.isEmpty || !RegExp(r'^[0-9]+\$').hasMatch(s))
          return 'please enter a number';
      },
      initialValue:
          widget.product == null ? '' : widget.product.price.toString(),
      decoration: InputDecoration(labelText: 'Product price'),
      keyboardType: TextInputType.number,
      onSaved: (s) {
        _formData['price'] = double.parse(s);
      },
    );
  }

  Widget _buildTitleTextField() {
    return TextFormField(
      validator: (s) {
        if (s.isEmpty || s.length > 5) return 'title is requierd';
      },
      initialValue: widget.product == null ? '' : widget.product.title,
      decoration: InputDecoration(labelText: 'Product title'),
      onSaved: (value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      validator: (s) {
        if (s.isEmpty || s.length > 5) return 'Description is requierd';
      },
      initialValue: widget.product == null ? '' : widget.product.description,
      decoration: InputDecoration(labelText: 'Product description'),
      maxLines: 4,
      onSaved: (value) {
        _formData['description'] = value;
      },
    );
  }
}
