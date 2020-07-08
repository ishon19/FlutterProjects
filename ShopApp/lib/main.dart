import 'package:ShopApp/providers/auth.dart';
import 'package:ShopApp/providers/cart.dart';
import 'package:ShopApp/providers/orders.dart';
import 'package:ShopApp/providers/products.dart';
import 'package:ShopApp/screens/authScreen.dart';
import 'package:ShopApp/screens/cartScreen.dart';
import 'package:ShopApp/screens/editProductScreen.dart';
import 'package:ShopApp/screens/orderScreen.dart';
import 'package:ShopApp/screens/productDetailScreen.dart';
import 'package:ShopApp/screens/productOverviewScreen.dart';
import 'package:ShopApp/screens/userProductsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: null,
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Order()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          title: 'Shop App',
          theme: ThemeData(
              primarySwatch: Colors.teal,
              accentColor: Colors.orangeAccent,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: 'Lato'),
          home: authData.isAutherised ? ProductOverviewScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrderScreen.routeName: (ctx) => OrderScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
