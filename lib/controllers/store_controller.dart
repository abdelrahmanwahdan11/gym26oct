import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/models.dart';
import '../data/repositories/prefs_repository.dart';
import '../data/repositories/store_repository.dart';

class StoreController extends GetxController {
  StoreController(this.repository, this.prefs);

  final StoreRepository repository;
  final PrefsRepository prefs;

  final List<Product> _products = [];
  final List<CartItem> _cart = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 0;
  String _categoryFilter = 'All';
  String? _couponCode;
  double _couponValue = 0;

  List<Product> get products {
    if (_categoryFilter == 'All') return List.unmodifiable(_products);
    return _products.where((element) => element.category == _categoryFilter).toList(growable: false);
  }

  List<CartItem> get cart => List.unmodifiable(_cart);
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String get categoryFilter => _categoryFilter;
  String? get couponCode => _couponCode;
  double get couponValue => _couponValue;

  @override
  void onInit() {
    super.onInit();
    bootstrap();
  }

  Future<void> bootstrap() async {
    _cart.addAll(prefs.loadCartItems());
    await refresh();
  }

  Future<void> refresh() async {
    _page = 0;
    _hasMore = true;
    _products.clear();
    await _fetch();
  }

  Future<void> loadMore() async {
    if (_isLoading || !_hasMore) return;
    _page += 1;
    await _fetch();
  }

  Future<void> _fetch() async {
    _isLoading = true;
    update();
    final items = await repository.fetchProducts(page: _page);
    if (items.isEmpty) {
      _hasMore = false;
    } else {
      _products.addAll(items);
    }
    _isLoading = false;
    update();
  }

  Future<void> setCategory(String category) async {
    _categoryFilter = category;
    update();
  }

  Future<void> addToCart(Product product) async {
    final index = _cart.indexWhere((element) => element.productId == product.id);
    if (index >= 0) {
      _cart[index] = CartItem(productId: product.id, qty: _cart[index].qty + 1);
    } else {
      _cart.add(CartItem(productId: product.id, qty: 1));
    }
    await prefs.saveCartItems(_cart);
    update();
  }

  Future<void> updateQty(String productId, int qty) async {
    final index = _cart.indexWhere((element) => element.productId == productId);
    if (index == -1) return;
    if (qty <= 0) {
      _cart.removeAt(index);
    } else {
      _cart[index] = CartItem(productId: productId, qty: qty);
    }
    await prefs.saveCartItems(_cart);
    update();
  }

  double cartTotal(Map<String, Product> productMap) {
    double total = 0;
    for (final item in _cart) {
      final product = productMap[item.productId];
      if (product != null) {
        total += product.price * item.qty;
      }
    }
    final discount = total * _couponValue;
    return total - discount;
  }

  void applyCoupon(String code) {
    if (code.trim().toUpperCase() == 'ATHLETICA20') {
      _couponCode = code;
      _couponValue = 0.2;
    } else {
      _couponCode = code;
      _couponValue = 0;
    }
    update();
  }

  Future<void> clearCart() async {
    _cart.clear();
    await prefs.saveCartItems(_cart);
    update();
  }
}
