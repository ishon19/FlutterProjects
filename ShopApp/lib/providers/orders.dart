import 'package:ShopApp/providers/cart.dart';
import 'package:flutter/widgets.dart';

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

  void addOrder(List<CartItem> cartItem, double total) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            dateTime: DateTime.now(),
            amount: total,
            products: cartItem));
    notifyListeners();
  }
}
