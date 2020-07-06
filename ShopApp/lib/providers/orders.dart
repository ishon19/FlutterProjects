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

  Future<void> addOrder(List<CartItem> cartItem, double total) async {
    final url = 'https://fluttershopapp-f979d.firebaseio.com/orders/$id.json';
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
}
