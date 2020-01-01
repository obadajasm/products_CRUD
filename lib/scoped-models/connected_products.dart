import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mx_crud/models/product.dart';
import 'package:mx_crud/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class ContectedProductsModel extends Model {
  List<Product> _products = [];
  User _authUser;
  String _selectedProductId;
  bool _isLodaing = false;

  Future<bool> addProduct(
      String title, String description, String image, double price) {
    _isLodaing = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          "http://images5.fanpop.com/image/photos/31600000/choco-chocolate-31685044-422-264.jpg",
      'price': price,
      'userEmail': _authUser.email,
      'userId': _authUser.id
    };
    return http
        .post('https://maxcrud-a8e3f.firebaseio.com/products.json',
            body: json.encode(productData))
        .then((http.Response response) {
      if (response.statusCode != 200 || response.statusCode != 201) {
        _isLodaing = false;
        notifyListeners();
        return false;
      }

      final Map<String, dynamic> data = json.decode(response.body);

      final Product newProduct = Product(
          id: data['name'],
          title: title,
          description: description,
          imageURL: image,
          price: price,
          userEmail: _authUser.email,
          userId: _authUser.id);

      _isLodaing = false;
      _products.add(newProduct);

      notifyListeners();
      return true;
    }).catchError((error) {
      _isLodaing = false;
      notifyListeners();
      return false;
    });
  }
}

class ProductModel extends ContectedProductsModel {
  List<Product> _products = [];

  bool _showFavorites = false;

  List<Product> get products {
    return List.from(_products);
  }

  List<Product> get displayedProduct {
    if (_showFavorites)
      return _products.where((Product product) => product.isFavotirte).toList();

    return List.from(_products);
  }

  bool get displayFavOnly {
    return _showFavorites;
  }

  String get selectedProductId {
    return _selectedProductId;
  }

  void set selectedProductId(String newId) {
    selectedProductId = newId;
  }

  int get _selectedProductIndex {
    return _products.indexWhere((Product product) {
      return product.id == _selectedProductId;
    });
  }

  Product get selectedProduct {
    if (_selectedProductId == null) return null;
    return _products.firstWhere((Product product) {
      return product.id == _selectedProductId;
    });
  }

  Future<bool> deleteProduct() {
    _isLodaing = true;
    final deletedProductId = selectedProduct.id;

    _products.removeAt(_selectedProductIndex);
    _selectedProductId = null;
    return http
        .delete(
            'https://maxcrud-a8e3f.firebaseio.com/products/$deletedProductId.json')
        .then((_) {
      _isLodaing = false;

      notifyListeners();
      return true;
    }).catchError((error) {
      _isLodaing = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> updateProduct(
      String title, String description, String image, double price) {
    _isLodaing = true;
    notifyListeners();
    final Map<String, dynamic> updatData = {
      'title': title,
      'description': description,
      'image':
          "http://images5.fanpop.com/image/photos/31600000/choco-chocolate-31685044-422-264.jpg",
      'price': price,
      'userEmail': _authUser.email,
      'userId': _authUser.id
    };
    return http
        .put(
            'https://maxcrud-a8e3f.firebaseio.com/products/${selectedProduct.id}.json',
            body: json.encode(updatData))
        .then((_) {
      _isLodaing = false;
      notifyListeners();

      final Product updatedProduct = Product(
          id: selectedProduct.id,
          title: title,
          description: description,
          imageURL: image,
          price: price,
          userEmail: _authUser.email,
          userId: _authUser.id);
      final int productIndex = _products.indexWhere((Product product) {
        return product.id == _selectedProductId;
      });
      _products[productIndex] = updatedProduct;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLodaing = false;
      notifyListeners();
      return false;
    });
  }

  void selectProduct(String productId) {
    _selectedProductId = productId;
    notifyListeners();
  }

  void toogleProductFavStatus() {
    final bool isCurrentlyFavorite = selectedProduct.isFavotirte;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updatedProduct = Product(
        id: selectedProduct.id,
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        imageURL: selectedProduct.imageURL,
        isFavotirte: newFavoriteStatus,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    _products[_selectedProductIndex] = updatedProduct;

    notifyListeners();
  }

  void toogleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

  Future<Null> fetchData() {
    _isLodaing = true;
    return http
        .get('https://maxcrud-a8e3f.firebaseio.com/products.json')
        .then<Null>((http.Response response) {
      final List<Product> productList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      if (productListData == null) {
        _isLodaing = false;
        notifyListeners();
        return;
      }
      productListData.forEach((String key, dynamic productData) {
        final Product newProduct = Product(
            id: key,
            title: productData['title'],
            description: productData["description"],
            imageURL: productData["image"],
            price: productData['price'],
            userEmail: productData['userEmail'],
            userId: productData['userId']);
        productList.add(newProduct);
      });
      _isLodaing = false;
      _products = productList;
      notifyListeners();
      _selectedProductId = null;
    });
  }
}

class UserModel extends ContectedProductsModel {
  void login(String email, String password) {
    _authUser = User(id: '3113', email: email, password: password);
  }
}

class UtilityModel extends ContectedProductsModel {
  bool get isLoading {
    return _isLodaing;
  }
}
