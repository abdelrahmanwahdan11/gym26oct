import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/app_scope.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context).store;
    final products = {for (final product in store.products) product.id: product};
    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        final subtotal = store.cart.fold<double>(0, (previousValue, item) {
          final product = products[item.productId];
          if (product == null) return previousValue;
          return previousValue + product.price * item.qty;
        });
        final total = store.cartTotal(products);
        return Scaffold(
          appBar: AppBar(title: const Text('عربة التسوق')),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              ...store.cart.map((item) {
                final product = products[item.productId];
                if (product == null) return const SizedBox.shrink();
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(backgroundImage: NetworkImage(product.image)),
                    title: Text(product.title),
                    subtitle: Text('${product.price.toStringAsFixed(2)} USD'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => store.updateQty(product.id, item.qty - 1),
                        ),
                        Text('${item.qty}'),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () => store.updateQty(product.id, item.qty + 1),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 24),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Summary', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal'),
                          Text('${subtotal.toStringAsFixed(2)} USD'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Shipping (Mock)'),
                          Text('Free'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Discount'),
                          Text('- ${(subtotal - total).toStringAsFixed(2)}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                child: ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: const Text('Shipping Address (Mock)'),
                  subtitle: const Text('Rawabi City • 12345 • اضغط لتعديل لاحقاً'),
                  trailing: const Icon(Icons.edit_outlined),
                  onTap: () => ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('تعديل العنوان سيتم لاحقاً (Mock)'))),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'Coupon Code (ATHLETICA20)'),
                onSubmitted: store.applyCoupon,
              ),
              const SizedBox(height: 12),
              Text('Discount: ${(store.couponValue * 100).toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Get.toNamed('/store/checkout'),
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
                child: Text('Checkout • Total ${total.toStringAsFixed(2)} USD'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: store.clearCart,
                child: const Text('Clear Cart'),
              )
            ],
          ),
        );
      },
    );
  }
}
