class Product {
  int id;
  String name;
  String description;
  String category;
  String image;
  double price;
  Ratings ratings;

  Product(
      {required this.id,
      required this.category,
      required this.description,
      required this.image,
      required this.name,
      required this.price,
      required this.ratings});

  static Product fromJson(Map data) {
    print('Input data $data');
    try {
      num test = data['rating']['rate'];
    } on Error catch (e) {
      print(e);
    }
    double price = data['price'].runtimeType == int
        ? data['price'].toDouble()
        : data['price'];
    return Product(
        id: data['id'],
        category: data['category'],
        description: data['description'],
        image: data['image'],
        name: data['title'],
        price: price,
        ratings: Ratings.fromJson(data['rating']));
  }
}

class Ratings {
  double rate;
  int count;

  Ratings({required this.rate, required this.count});

  static Ratings fromJson(Map data) {
    double rate = data['rate'].runtimeType == int
        ? data['rate'].toDouble()
        : data['rate'];
    return Ratings(rate: rate, count: data['count']);
  }
}
