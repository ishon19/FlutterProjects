import 'package:ShopApp/providers/products.dart';
import 'package:ShopApp/screens/editProductScreen.dart';
import 'package:ShopApp/widgets/appDrawer.dart';
import 'package:ShopApp/widgets/userProductItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (ctx, idx) => Column(
              children: [
                UserProductItem(
                  productsProvider.items[idx].id,
                  productsProvider.items[idx].title,
                  productsProvider.items[idx].imageUrl,
                ),
                Divider(),
              ],
            ),
            itemCount: productsProvider.items.length,
          ),
        ),
      ),
    );
  }
}
