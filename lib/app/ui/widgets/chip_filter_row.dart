import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ChipFilterRow extends StatefulWidget {
  const ChipFilterRow({super.key, required this.filters});

  final List<String> filters;

  @override
  State<ChipFilterRow> createState() => _ChipFilterRowState();
}

class _ChipFilterRowState extends State<ChipFilterRow> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Row(
        children: [
          for (int i = 0; i < widget.filters.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ChoiceChip(
                label: Text(widget.filters[i]),
                selected: selected == i,
                onSelected: (value) {
                  setState(() => selected = i);
                },
                labelStyle: theme.textTheme.labelLarge,
              ).animate(interval: 60.ms).fadeIn().scale(begin: 0.98, end: 1),
            ),
        ],
      ),
    );
  }
}
