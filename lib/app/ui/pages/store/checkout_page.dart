import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_controller.dart';
import '../../widgets/app_background.dart';

class CheckoutPage extends GetView<CartController> {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('checkout'.tr),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${'total'.tr}: ${controller.total.toStringAsFixed(2)}'),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'coupon_optional'.tr,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar('checkout'.tr, 'order_mock'.tr);
                    controller.clearCart();
                    Get.back();
                  },
                  child: Text('place_order'.tr),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
