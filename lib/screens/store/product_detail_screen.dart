import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../controllers/app_scope.dart';
import '../../data/models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Future<Product?>? _future;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _future ??= AppScope.of(context).store.resolveProduct(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context).store;
    return FutureBuilder<Product?>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final product = snapshot.data;
        if (product == null) {
          return const Scaffold(body: Center(child: Text('Product not found')));
        }
        return Scaffold(
          appBar: AppBar(title: Text(product.title)),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              SizedBox(
                height: 260,
                child: PageView(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Image.network(product.image, fit: BoxFit.cover),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1517963628607-235ccdd5476b',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 280.ms).moveY(begin: 16, end: 0),
              const SizedBox(height: 24),
              Text(product.category, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 8),
              Text(
                product.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                '${product.price.toStringAsFixed(2)} USD',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 16),
              Text(product.desc, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await store.addToCart(product);
                        if (!mounted) return;
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('${product.title} added to cart')));
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                      child: const Text('أضف للسلة'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text('Mock checkout successful!')));
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                      child: const Text('اشترِ الآن'),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
