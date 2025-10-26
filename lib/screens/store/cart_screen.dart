import 'package:flutter/material.dart';

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
              TextField(
                decoration: const InputDecoration(labelText: 'Coupon Code (ATHLETICA20)'),
                onSubmitted: store.applyCoupon,
              ),
              const SizedBox(height: 12),
              Text('Discount: ${(store.couponValue * 100).toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('store.checkout'),
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
                child: Text('Checkout • Total ${store.cartTotal(products).toStringAsFixed(2)} USD'),
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
