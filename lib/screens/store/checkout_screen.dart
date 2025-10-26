import 'package:flutter/material.dart';

import '../../controllers/app_scope.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context).store;
    final products = {for (final product in store.products) product.id: product};
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Summary', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: store.cart
                    .map((item) {
                      final product = products[item.productId];
                      if (product == null) return const SizedBox.shrink();
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(product.title),
                        subtitle: Text('${item.qty} × ${product.price.toStringAsFixed(2)}'),
                      );
                    })
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Payment success (Mock)')));
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
              child: Text('Pay ${store.cartTotal(products).toStringAsFixed(2)} USD'),
            )
          ],
        ),
      ),
    );
  }
}
