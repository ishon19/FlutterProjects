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
                  OrderButton(cartProvider: cartProvider),
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cartProvider,
  }) : super(key: key);

  final Cart cartProvider;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: (widget.cartProvider.getTotalAmount <= 0 || _isLoading) ? null:() async {
          setState(() {
            _isLoading = true;
          });
          await Provider.of<Order>(context, listen: false).addOrder(
            widget.cartProvider.cartItems.values.toList(),
            widget.cartProvider.getTotalAmount,
          );
          setState(() {
            _isLoading = false;
          });
          widget.cartProvider.clear();
        },
        child: _isLoading? CircularProgressIndicator():Text(
          'Order Now',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ));
  }
}
