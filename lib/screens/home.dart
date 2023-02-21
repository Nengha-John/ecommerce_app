import 'package:ecommerce_app/controllers/products.controller.dart';
import 'package:ecommerce_app/screens/cart.dart';
import 'package:ecommerce_app/screens/product.list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //  Displays the home page with bottom navigations

  int currentPage = 0;
  List<Widget> pages = [const ProductList(), const Cart()];

  @override
  Widget build(BuildContext context) {
    // Define a Global Provider that is used to manage state down the
    // Widget tree
    return ChangeNotifierProvider<ProductProvider>(
        create: (context) => ProductProvider(),
        child: Scaffold(
          body: pages[currentPage],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentPage,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            selectedIconTheme: const IconThemeData(color: Colors.blue),
            onTap: (index) => setState(() {
              currentPage = index;
            }),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Products'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
            ],
          ),
        ));
  }
}
