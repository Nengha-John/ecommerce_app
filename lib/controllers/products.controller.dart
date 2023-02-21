import 'package:ecommerce_app/client/client.dart';
import 'package:ecommerce_app/config/api.config.dart';
import 'package:ecommerce_app/models/product.model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];
  List<Product> cartProducts = [];
  List<Product> displayProducts = [];
  double totalCost = 0;
  String searchTerm = '';
  bool isPriceAscending = true;
  bool isRatingAscending = true;

  addToCart(Product product) {
    if (cartProducts.where((element) => element.id == product.id).isEmpty) {
      cartProducts.add(product);
      totalCost += product.price;
      notifyListeners();
    }
  }

  double get cost {
    double cst = 0.0;
    for (Product product in cartProducts) {
      cst += product.price;
    }
    notifyListeners();
    return cst;
  }

  void searchProduct(String? term) {
    if (term!.isEmpty) {
      // setState(() {
      displayProducts = products;
      searchTerm = '';
      // });
    }
    displayProducts = products.where((item) {
      return item.name.toLowerCase().contains(term.toLowerCase());
    }).toList();
    searchTerm = term;
    notifyListeners();
  }

  void sortByPrice() {
    displayProducts = products;
    print(!isPriceAscending);
    isPriceAscending = !isPriceAscending;
    if (isPriceAscending) {
      displayProducts.sort((a, b) => a.price.compareTo(b.price));
    } else {
      displayProducts.sort((a, b) => b.price.compareTo(a.price));
    }
    notifyListeners();
  }

  void sortByRatings() {
    print('By Ratings ');
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
    print('Getting products');
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
