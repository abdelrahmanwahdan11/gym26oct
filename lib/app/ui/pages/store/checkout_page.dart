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
        title: const Text('Checkout'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total: ${controller.total.toStringAsFixed(2)}'),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'كوبون خصم',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar('Order', 'Mock checkout complete');
                    controller.clearCart();
                    Get.back();
                  },
                  child: const Text('Place Order'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
