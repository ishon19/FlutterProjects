import 'package:ShopApp/providers/products.dart';
import 'package:ShopApp/widgets/productItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridList extends StatelessWidget {


  final bool showFav;

  ProductGridList(this.showFav);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final allProducts = showFav? productsData.favItems : productsData.items;
    print('Showfav is $showFav Data to be displayed $allProducts');

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, idx) {
        return ChangeNotifierProvider.value(
          value: allProducts[idx],
          child: ProductItem(
            // id: allProducts[idx].id,
            // title: allProducts[idx].title,
            // imageUrl: allProducts[idx].imageUrl,
          ),
        );
      },
      itemCount: allProducts.length,
      padding: const EdgeInsets.all(10),
    );
  }
}
