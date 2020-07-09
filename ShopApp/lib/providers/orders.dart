import 'dart:convert';

import 'package:ShopApp/providers/cart.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  final String authToken;
  final String userId;

  Order(this.authToken, this.userId, this._orders);

  Future<void> addOrder(List<CartItem> cartItem, double total) async {
    final url = 'https://fluttershopapp-f979d.firebaseio.com/orders/$userId.json?auth=$authToken';
    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartItem
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'quantity': e.quantity,
                    'price': e.price,
                  })
              .toList(),
        }));

    //use the server generated id
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            dateTime: timeStamp,
            amount: total,
            products: cartItem));
    notifyListeners();
  }

  Future<void> getOrders() async {
    final url = 'https://fluttershopapp-f979d.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(url);
    print('[getOrders] Server Response ${response.body}');
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) return;
    extractedData.forEach((key, value) {
      loadedOrders.add(OrderItem(
        id: key,
        amount: value['amount'],
        dateTime: DateTime.parse(value['dateTime']),
        products: (value['products'] as List<dynamic>)
            .map((e) => CartItem(
                  id: e['id'],
                  title: e['title'],
                  price: e['price'],
                  quantity: e['quantity'],
                ))
            .toList(),
      ));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }
}
