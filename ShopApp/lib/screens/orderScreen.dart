import 'package:ShopApp/providers/orders.dart';
import 'package:ShopApp/widgets/appDrawer.dart';
import 'package:ShopApp/widgets/orderItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    //final orders = Provider.of<Order>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<Order>(context, listen: false).getOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                //error handling here
                print('Error ${dataSnapshot.error}');
                return Center(
                  child: Text('Some error occured!'),
                );
              } else {
                return Consumer<Order>(builder: (ctx, orders, _) {
                  return ListView.builder(
                    itemBuilder: (ctx, idx) => OrderElement(orders.orders[idx]),
                    itemCount: orders.orders.length,
                  );
                });
              }
            }
          },
        ));
  }
}
