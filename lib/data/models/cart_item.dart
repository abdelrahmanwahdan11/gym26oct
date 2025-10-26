class CartItem {
  CartItem({
    required this.productId,
    required this.qty,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        productId: json['productId'] as String,
        qty: (json['qty'] as num).toInt(),
      );

  final String productId;
  final int qty;

  Map<String, dynamic> toJson() => {'productId': productId, 'qty': qty};
}
