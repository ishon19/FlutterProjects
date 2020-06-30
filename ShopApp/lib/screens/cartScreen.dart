import 'package:ShopApp/providers/cart.dart' show Cart;
import 'package:ShopApp/providers/orders.dart';
import '../widgets/cartItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cartProvider.getTotalAmount.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                      onPressed: () {
                        Provider.of<Order>(context, listen: false).addOrder(
                          cartProvider.cartItems.values.toList(),
                          cartProvider.getTotalAmount,
                        );
                        cartProvider.clear();
                      },
                      child: Text(
                        'Order Now',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, idx) => CartItem(
                  id: cartProvider.cartItems.values.toList()[idx].id,
                  productId: cartProvider.cartItems.keys.toList()[idx],
                  title: cartProvider.cartItems.values.toList()[idx].title,
                  price: cartProvider.cartItems.values.toList()[idx].price,
                  quantity:
                      cartProvider.cartItems.values.toList()[idx].quantity),
              itemCount: cartProvider.cartItems.length,
            ),
          )
        ],
      ),
    );
  }
}
