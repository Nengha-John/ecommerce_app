import 'package:ecommerce_app/client/client.dart';
import 'package:ecommerce_app/config/api.config.dart';
import 'package:ecommerce_app/models/product.model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;

class ProductProvider extends ChangeNotifier {
  List<Product> products = []; // A list of all products available
  List<Product> cartProducts = []; // Products added to cart
  List<Product> displayProducts =
      []; // Products that are displayed and manipulated
  double totalCost = 0; // Total Cost of products in cart
  String searchTerm = '';
  bool isPriceAscending = true;
  bool isRatingAscending = true;

  void addToCart(Product product) {
    if (cartProducts.where((element) => element.id == product.id).isEmpty) {
      cartProducts.add(product);
      totalCost += product.price;
      notifyListeners();
    }
  }

  void searchProduct(String? term) {
    if (term!.isEmpty) {
      displayProducts = products;
      searchTerm = '';
    }
    displayProducts = products.where((item) {
      return item.name.toLowerCase().contains(term.toLowerCase());
    }).toList();
    searchTerm = term;
    notifyListeners();
  }

  void sortByPrice() {
    displayProducts = products;
    isPriceAscending = !isPriceAscending;
    if (isPriceAscending) {
      displayProducts.sort((a, b) => a.price.compareTo(b.price));
    } else {
      displayProducts.sort((a, b) => b.price.compareTo(a.price));
    }
    notifyListeners();
  }

  void sortByRatings() {
    isRatingAscending = !isRatingAscending;
    displayProducts = products;
    if (isRatingAscending) {
      displayProducts.sort((a, b) => a.ratings.rate.compareTo(b.ratings.rate));
    } else {
      displayProducts.sort((a, b) => b.ratings.rate.compareTo(a.ratings.rate));
    }
    notifyListeners();
  }

  Future getProducts() async {
    if (products.isNotEmpty) {
      return;
    }
    dio.Response response =
        await Client().get(ApiConfig.BASE_API_URL, null, null);
    var respData = response.data;
    if (response.statusCode! >= 400) {
      return {
        'success': false,
        'message': respData['message'],
      };
    }
    for (var product in respData) {
      if (products.where((element) => element.id == product['id']).isEmpty) {
        products.add(Product.fromJson(product));
      }
    }
    displayProducts = products;
  }
}
