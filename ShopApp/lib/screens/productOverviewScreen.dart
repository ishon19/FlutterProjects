import 'package:ShopApp/providers/cart.dart';
import 'package:ShopApp/providers/products.dart';
import 'package:ShopApp/screens/cartScreen.dart';
import 'package:ShopApp/widgets/ProductGrid.dart';
import 'package:ShopApp/widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop App'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions value) {
                print('Selected value is $value');
                setState(() {
                  if (value == FilterOptions.Favorites) {
                    _showFav = true;
                  } else {
                    _showFav = false;
                  }
                  print('setState final value $_showFav');
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (ctx) {
                return [
                  PopupMenuItem(
                    child: Text('Favorites'),
                    value: FilterOptions.Favorites,
                  ),
                  PopupMenuItem(
                    child: Text('Show All'),
                    value: FilterOptions.All,
                  ),
                ];
              }),
          Consumer<Cart>(
            builder: (ctx, cartData, child) => Badge( 
              child: child,
              value: cartData.getItemCount.toString(),
            ),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: (){
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
          ),
        ],
      ),
      body: ProductGridList(_showFav),
    );
  }
}
