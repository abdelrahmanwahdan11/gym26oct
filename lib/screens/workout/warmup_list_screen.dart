import 'package:flutter/material.dart';

import '../../controllers/app_scope.dart';
import '../../widgets/program_tile.dart';

class WarmupListScreen extends StatelessWidget {
  const WarmupListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final programs = AppScope.of(context).programs;
    return Scaffold(
      appBar: AppBar(title: const Text('Basic Warm-up Activities')),
      body: RefreshIndicator(
        onRefresh: programs.refresh,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ...programs.programs
                .map((program) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ProgramTile(
                        program: program,
                        isFavorite: programs.favorites.contains(program.id),
                        onTap: () => Navigator.of(context).pushNamed('program.details', arguments: program.id),
                        onFavorite: () => programs.toggleFavorite(program.id),
                      ),
                    ))
                .toList(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed('workout.session'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
              child: const Text('ابدأ التمرين'),
            ),
          ],
        ),
      ),
    );
  }
}
