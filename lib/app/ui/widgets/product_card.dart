import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../data/models/product.dart';
import '../../routes/app_routes.dart';
import 'glass_container.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.product, arguments: product),
      child: GlassContainer(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(product.image, height: 120, width: double.infinity, fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),
            Text(product.title,
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(product.category,
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6))),
            const Spacer(),
            Row(
              children: [
                Text(product.price.toStringAsFixed(2),
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () => Get.find<CartController>().addToCart(product.id),
                )
              ],
            )
          ],
        ),
      ).animate(interval: 60.ms).fadeIn().scale(begin: 0.98, end: 1),
    );
  }
}
