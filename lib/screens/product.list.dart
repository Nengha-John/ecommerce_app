import 'package:ecommerce_app/controllers/products.controller.dart';
import 'package:ecommerce_app/models/product.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  //  Displays the product grid in first tab of the bottom navigation

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    bool isAscending = true;
    return FutureBuilder(
        future: provider.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    toolbarHeight: 90,
                    backgroundColor: Colors.white,
                    title: Column(
                      children: [
                        TextField(
                          onSubmitted: (value) {
                            provider.searchProduct(value);
                          },
                          decoration: InputDecoration(
                            hintText: provider.searchTerm.isEmpty
                                ? "Search Product"
                                : provider.searchTerm,
                            border: InputBorder.none,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                isAscending = !isAscending;
                                provider.sortByPrice();
                              },
                              child: Row(
                                children: [
                                  Icon(
                                      provider.isPriceAscending
                                          ? Icons.arrow_drop_down_sharp
                                          : Icons.arrow_drop_up_sharp,
                                      color: Colors.black),
                                  const Text(
                                    'Price',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            InkWell(
                              onTap: () => provider.sortByRatings(),
                              child: Row(
                                children: [
                                  Icon(
                                      provider.isRatingAscending
                                          ? Icons.arrow_drop_down_sharp
                                          : Icons.arrow_drop_up_sharp,
                                      color: Colors.black),
                                  const Text(
                                    'Rating',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    floating: true,
                    snap: true,
                  ),
                  Consumer<ProductProvider>(
                    builder: (context, provider1, child) => SliverGrid.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemCount: provider1.displayProducts.length,
                        itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Image.network(
                                        provider1.displayProducts[index].image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 4),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            provider1
                                                .displayProducts[index].name,
                                            style: const TextStyle(
                                              // fontSize: 1,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.visible,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              right: 4, left: 4),
                                          child: InkWell(
                                            onTap: () {
                                              provider.addToCart(provider1
                                                  .displayProducts[index]);
                                              var snack = SnackBar(
                                                content: Text(
                                                    '${provider1.displayProducts[index].name} added to cart'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snack);
                                            },
                                            child: Container(
                                              // width: 10,
                                              // height: 10,
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.blue,
                                              ),
                                              child: const Icon(
                                                Icons
                                                    .add_shopping_cart_outlined,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Tsh.${provider1.displayProducts[index].price}',
                                          textAlign: TextAlign.start,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star_outline_rounded,
                                              color: Colors.black,
                                              size: 16,
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              '${provider1.displayProducts[index].ratings.rate}',
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                  ),
                ],
              ),
            );
          }
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Center(child: CircularProgressIndicator())],
            ),
          );
        });
    //   },
    // );
  }
}
