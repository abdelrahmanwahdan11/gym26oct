import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_controller.dart';
import '../../../controllers/store_controller.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/product_card.dart';

class StoreHomePage extends StatefulWidget {
  const StoreHomePage({super.key});

  @override
  State<StoreHomePage> createState() => _StoreHomePageState();
}

class _StoreHomePageState extends State<StoreHomePage> {
  final controller = Get.find<StoreController>();
  final cart = Get.find<CartController>();
  final scrollController = ScrollController();
  final categories = const ['All', 'Supplements', 'Equipment', 'Care'];
  int selected = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 120) {
      controller.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Store'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AppBackground(
        child: Column(
          children: [
            SizedBox(
              height: 52,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final isSelected = selected == index;
                  return ChoiceChip(
                    label: Text(categories[index]),
                    selected: isSelected,
                    onSelected: (value) {
                      setState(() => selected = index);
                      controller.selectCategory(index == 0 ? '' : categories[index]);
                    },
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemCount: categories.length,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.loadInitial,
                child: Obx(
                  () => GridView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) => ProductCard(product: controller.products[index]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed('/store/cart'),
        label: Obx(() => Text('Cart (${cart.cartItems.length})')),
        icon: const Icon(Icons.shopping_cart),
      ),
      bottomNavigationBar: AppBottomNav(active: 'store'),
    );
  }
}
