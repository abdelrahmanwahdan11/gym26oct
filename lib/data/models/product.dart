class Product {
  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.category,
    required this.rating,
    required this.desc,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as String,
        title: json['title'] as String,
        image: json['image'] as String,
        price: (json['price'] as num).toDouble(),
        category: json['category'] as String,
        rating: (json['rating'] as num).toDouble(),
        desc: json['desc'] as String,
        stock: (json['stock'] as num).toInt(),
      );

  final String id;
  final String title;
  final String image;
  final double price;
  final String category;
  final double rating;
  final String desc;
  final int stock;
}
