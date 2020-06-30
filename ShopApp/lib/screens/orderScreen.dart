import 'package:ShopApp/providers/orders.dart';
import 'package:ShopApp/widgets/appDrawer.dart';
import 'package:ShopApp/widgets/orderItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {

  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    
    final orders = Provider.of<Order>(context); 

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(itemBuilder: (ctx, idx) => OrderElement(orders.orders[idx]), itemCount: orders.orders.length,),
    );
  }
}
