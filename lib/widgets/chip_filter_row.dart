import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ChipFilterRow extends StatelessWidget {
  const ChipFilterRow({super.key, required this.items, this.onSelected, this.selected});

  final List<String> items;
  final ValueChanged<String>? onSelected;
  final String? selected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = item == selected;
          return ChoiceChip(
            label: Text(item),
            selected: isSelected,
            onSelected: (_) => onSelected?.call(item),
          ).animate(interval: 60.ms).fadeIn().scale(begin: 0.95, end: 1);
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: items.length,
      ),
    );
  }
}
