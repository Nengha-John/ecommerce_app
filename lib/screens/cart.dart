import 'package:ecommerce_app/controllers/products.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(vertical: 12),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Cost: '),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Tsh.${provider.totalCost}',
                  style: const TextStyle(
                      fontSize: 34, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text('All Items: ${provider.cartProducts.length}'),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: provider.cartProducts.length,
                  itemBuilder: (context, index) => Container(
                        child: ListTile(
                          leading: Image.network(
                            provider.cartProducts[index].image,
                            fit: BoxFit.cover,
                            width: 90,
                            height: 90,
                          ),
                          title: Text(
                            provider.cartProducts[index].name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.visible,
                          ),
                          subtitle: Text(
                            'Tsh.${provider.cartProducts[index].price}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      )))
        ],
      )),
    );
    // );
  }
}
