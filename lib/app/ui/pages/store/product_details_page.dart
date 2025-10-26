import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_controller.dart';
import '../../../controllers/store_controller.dart';
import '../../../data/models/product.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/app_background.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Get.find<StoreController>();
    final productArg = Get.arguments;
    Product? product;
    if (productArg is Product) {
      product = productArg;
    } else if (productArg is String) {
      product = store.findById(productArg);
    }
    product ??= store.products.first;
    final cart = Get.find<CartController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AppBackground(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.network(product.image, height: 280, fit: BoxFit.cover),
            ),
            const SizedBox(height: 16),
            Text(product.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(product.category, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            Text(product.description),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      cart.addToCart(product.id);
                    },
                    child: Text('add_to_cart'.tr),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed(AppRoutes.checkout),
                    child: Text('buy_now'.tr),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
