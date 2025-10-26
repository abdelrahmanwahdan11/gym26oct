class Product {
  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.category,
    required this.rating,
    required this.description,
    required this.stock,
  });

  factory Product.fromMap(Map<String, dynamic> map) => Product(
        id: map['id'] as String,
        title: map['title'] as String,
        image: map['image'] as String,
        price: (map['price'] as num).toDouble(),
        category: map['category'] as String,
        rating: (map['rating'] as num).toDouble(),
        description: map['desc'] as String? ?? '',
        stock: map['stock'] as int? ?? 0,
      );

  final String id;
  final String title;
  final String image;
  final double price;
  final String category;
  final double rating;
  final String description;
  final int stock;
}

class CartItem {
  CartItem({required this.productId, required this.quantity});

  factory CartItem.fromMap(Map<String, dynamic> map) => CartItem(
        productId: map['productId'] as String,
        quantity: (map['qty'] as num).toInt(),
      );

  final String productId;
  final int quantity;

  Map<String, dynamic> toMap() => {'productId': productId, 'qty': quantity};
}
