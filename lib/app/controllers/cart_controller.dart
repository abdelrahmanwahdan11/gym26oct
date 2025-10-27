import 'package:get/get.dart';

import '../data/models/product.dart' as models;
import '../data/repositories/prefs_repository.dart';
import '../data/repositories/store_repository.dart';

class CartController extends GetxController {
  CartController(this._prefsRepository, this._storeRepository);

  final PrefsRepository _prefsRepository;
  final StoreRepository _storeRepository;

  final RxList<models.CartItem> cartItems = <models.CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    final saved = _prefsRepository.cart
        .map(models.CartItem.fromMap)
        .toList(growable: false);
    cartItems.assignAll(saved);
  }

  models.Product? findProduct(String id) => _storeRepository.byId(id);

  double get total {
    double sum = 0;
    for (final item in cartItems) {
      final product = findProduct(item.productId);
      if (product != null) {
        sum += product.price * item.quantity;
      }
    }
    return sum;
  }

  Future<void> addToCart(String productId) async {
    final index = cartItems.indexWhere((item) => item.productId == productId);
    if (index == -1) {
      cartItems.add(models.CartItem(productId: productId, quantity: 1));
    } else {
      final item = cartItems[index];
      cartItems[index] =
          models.CartItem(productId: productId, quantity: item.quantity + 1);
    }
    await _save();
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    final index = cartItems.indexWhere((item) => item.productId == productId);
    if (index == -1) return;
    if (quantity <= 0) {
      cartItems.removeAt(index);
    } else {
      cartItems[index] = models.CartItem(productId: productId, quantity: quantity);
    }
    await _save();
  }

  Future<void> clearCart() async {
    cartItems.clear();
    await _save();
  }

  Future<void> _save() async {
    await _prefsRepository.saveCart(cartItems.map((e) => e.toMap()).toList());
  }
}
