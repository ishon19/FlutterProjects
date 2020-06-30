import 'package:ShopApp/providers/product.dart';
import 'package:ShopApp/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(loadedProduct.imageUrl),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '\$${loadedProduct.price}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 21,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${loadedProduct.description}',
            textAlign: TextAlign.center,
            softWrap: true,
          )
        ]),
      ),
    );
  }
}
