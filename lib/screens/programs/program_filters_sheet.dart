import 'package:flutter/material.dart';

import '../../controllers/app_scope.dart';

class ProgramFiltersSheet extends StatefulWidget {
  const ProgramFiltersSheet({super.key});

  @override
  State<ProgramFiltersSheet> createState() => _ProgramFiltersSheetState();
}

class _ProgramFiltersSheetState extends State<ProgramFiltersSheet> {
  String? _level;

  @override
  Widget build(BuildContext context) {
    final programs = AppScope.of(context).programs;
    _level ??= programs.levelFilter;
    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Level'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: [
                _buildChip('Beginner'),
                _buildChip('Intermediate'),
                _buildChip('Advanced'),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                programs.setLevelFilter(_level);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
              child: const Text('Apply Filters'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String level) {
    return ChoiceChip(
      label: Text(level),
      selected: _level == level,
      onSelected: (_) => setState(() => _level = _level == level ? null : level),
    );
  }
}
