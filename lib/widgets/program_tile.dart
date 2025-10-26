import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/models/program.dart';

class ProgramTile extends StatelessWidget {
  const ProgramTile({super.key, required this.program, this.onTap, this.onFavorite, this.isFavorite = false});

  final Program program;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(colors: [theme.colorScheme.surface, theme.colorScheme.surface.withOpacity(0.6)]),
          border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
          boxShadow: const [BoxShadow(color: Color.fromRGBO(18, 24, 47, 0.16), blurRadius: 38, offset: Offset(0, 12))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
              child: Image.network(program.image, height: 120, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(program.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                      ),
                      IconButton(
                        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: theme.colorScheme.primary),
                        onPressed: onFavorite,
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('${program.level} • ${program.weeks} Weeks', style: theme.textTheme.bodySmall),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    children: program.tags
                        .take(3)
                        .map((tag) => Chip(label: Text(tag), padding: EdgeInsets.zero))
                        .toList(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ).animate(interval: 60.ms).fadeIn().scale(begin: 0.98, end: 1);
  }
}
