import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_controller.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/app_background.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cart'.tr),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AppBackground(
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.separated(
                  padding: const EdgeInsets.all(16),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: controller.cartItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = controller.cartItems[index];
                    final product = controller.findProduct(item.productId);
                    if (product == null) {
                      return const SizedBox.shrink();
                    }
                    return ListTile(
                      tileColor: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(product.image, width: 60, height: 60, fit: BoxFit.cover),
                      ),
                      title: Text(product.title),
                      subtitle: Text('Qty: ${item.quantity}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () => controller.updateQuantity(product.id, item.quantity - 1),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Obx(() => Text('${'total'.tr}: ${controller.total.toStringAsFixed(2)}')),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.toNamed(AppRoutes.checkout),
                      child: Text('checkout'.tr),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
