import 'package:ShopApp/models/httpException.dart';
import 'package:ShopApp/providers/auth.dart';
import 'package:ShopApp/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class Products with ChangeNotifier {
  List<Product> _list = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];  

  final authToken;

  Products(this.authToken, this._list);

  List<Product> get favItems {
    return _list.where((element) => element.isFavorite).toList();
  }

  List<Product> get items {
    return [..._list];
  }

  Product findById(String id) {
    return _list.firstWhere((element) => element.id == id);
  }

  Future<void> fetchProducts() async {
    final url = 'https://fluttershopapp-f979d.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.get(url);
      List<Product> tempList = [];
      print('The server response is ${json.decode(response.body)}');
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((key, value) {
        tempList.add(Product(
          description: value['description'],
          id: key,
          title: value['title'],
          price: double.parse(value['price'].toString()),
          imageUrl: value['imageUrl'],
          isFavorite: value['isFavorite'],
        ));
      });
      notifyListeners();
      _list = tempList;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://fluttershopapp-f979d.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(url,
          body: json.encode({
            'id': product.id,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
            'title': product.title,
            'description': product.description,
          }));
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _list.add(newProduct);
      notifyListeners();
    } catch (error) {
      print('[addProduct] error: $error');
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    int index = _list.indexWhere((element) => element.id == id);
    if (index >= 0) {
      final url =
          'https://fluttershopapp-f979d.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          }));
      _list[index] = newProduct;
    }
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://fluttershopapp-f979d.firebaseio.com/products/$id.json?auth=$authToken';
    int elementIndex = _list.indexWhere((element) => element.id == id);
    Product elementToBeDeleted = _list.elementAt(elementIndex);
    _list.removeWhere((element) => element.id == id);
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      //Custom exceptions to be thrown
      _list.insert(elementIndex, elementToBeDeleted);
      throw HttpException('Error in deleting the product');
    } else {
      elementToBeDeleted = null;
    }
    notifyListeners();
  }
}
