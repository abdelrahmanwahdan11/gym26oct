import 'dart:async';
import 'dart:math';

import '../models/models.dart';
import '../seed/mock_data.dart';

class StoreRepository {
  Future<List<Product>> fetchProducts({int page = 0, int pageSize = 12}) async {
    await Future.delayed(const Duration(milliseconds: 450));
    final start = page * pageSize;
    if (start >= mockProducts.length) return [];
    final end = min(start + pageSize, mockProducts.length);
    final slice = mockProducts.sublist(start, end);
    return slice.map((e) => Product.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<Product?> findProduct(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final map = mockProducts.cast<Map<String, dynamic>>().firstWhere(
          (element) => element['id'] == id,
          orElse: () => {},
        );
    if (map.isEmpty) return null;
    return Product.fromJson(map);
  }
}
