import 'dart:async';

import '../models/product.dart';
import 'mock_seed.dart';

class StoreRepository {
  StoreRepository({this.pageSize = 12, this.delay = const Duration(milliseconds: 450)});

  final int pageSize;
  final Duration delay;
  final List<Map<String, dynamic>> _productMaps =
      List<Map<String, dynamic>>.from(mockSeed['products'] as List);

  Future<List<Product>> fetchProducts(int page, {String category = ''}) async {
    await Future<void>.delayed(delay);
    final filtered = category.isEmpty
        ? _productMaps
        : _productMaps
            .where((map) => (map['category'] as String) == category)
            .toList();
    final start = page * pageSize;
    final end = (start + pageSize).clamp(0, filtered.length);
    if (start >= filtered.length) {
      return const [];
    }
    return filtered.sublist(start, end).map(Product.fromMap).toList();
  }

  Product? byId(String id) {
    final map = _productMaps.firstWhere(
      (element) => element['id'] == id,
      orElse: () => {},
    );
    if (map.isEmpty) return null;
    return Product.fromMap(map);
  }
}
