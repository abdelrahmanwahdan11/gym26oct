import 'package:get/get.dart';

import '../data/models/product.dart';
import '../data/repositories/store_repository.dart';

class StoreController extends GetxController {
  StoreController(this._repository);

  final StoreRepository _repository;

  final RxList<Product> products = <Product>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  final RxString category = ''.obs;
  int _page = 0;

  @override
  void onInit() {
    super.onInit();
    loadInitial();
  }

  Future<void> loadInitial() async {
    products.clear();
    _page = 0;
    hasMore.value = true;
    await loadMore(reset: true);
  }

  Future<void> selectCategory(String value) async {
    category.value = value;
    await loadInitial();
  }

  Future<void> loadMore({bool reset = false}) async {
    if (!hasMore.value || isLoading.value) return;
    isLoading.value = true;
    final data = await _repository.fetchProducts(reset ? 0 : _page, category: category.value);
    if (reset) {
      products.assignAll(data);
      _page = 1;
      hasMore.value = data.length == _repository.pageSize;
    } else {
      if (data.isEmpty) {
        hasMore.value = false;
      } else {
        products.addAll(data);
        _page++;
      }
    }
    isLoading.value = false;
  }

  Product? findById(String id) => _repository.byId(id);
}
