import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, this.onTap, this.onAdd});

  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(colors: [theme.cardColor, theme.cardColor.withOpacity(0.8)]),
          border: Border.all(color: theme.dividerColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
              child: Stack(
                children: [
                  Image.network(product.image, height: 140, width: double.infinity, fit: BoxFit.cover),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(colors: [theme.colorScheme.primary, theme.colorScheme.secondary]),
                      ),
                      child: Text(product.category, style: theme.textTheme.bodySmall?.copyWith(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text('${product.price.toStringAsFixed(2)} USD',
                      style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.star, size: 18, color: theme.colorScheme.secondary),
                      const SizedBox(width: 4),
                      Text(product.rating.toStringAsFixed(1), style: theme.textTheme.bodySmall),
                      const Spacer(),
                      IconButton(
                        onPressed: onAdd,
                        icon: Icon(Icons.add_shopping_cart, color: theme.colorScheme.primary),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ).animate(interval: 60.ms).fadeIn().scale(begin: 0.98, end: 1);
  }
}
