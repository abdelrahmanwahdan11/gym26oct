import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../controllers/app_scope.dart';

class ProgramDetailsScreen extends StatelessWidget {
  const ProgramDetailsScreen({super.key, required this.programId});

  final String programId;

  @override
  Widget build(BuildContext context) {
    final programs = AppScope.of(context).programs;
    final program = programs.programs.firstWhere(
      (element) => element.id == programId,
      orElse: () => programs.programs.isNotEmpty ? programs.programs.first : null,
    );
    if (program == null) {
      return const Scaffold(body: Center(child: Text('Program not found')));
    }
    return Scaffold(
      appBar: AppBar(leading: BackButton(onPressed: () => Navigator.of(context).pop())),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          SizedBox(
            height: 260,
            child: PageView(
              children: [
                _GalleryImage(url: program.image),
                _GalleryImage(url: 'https://images.unsplash.com/photo-1517963628607-235ccdd5476b'),
              ],
            ),
          ).animate().fadeIn(duration: 280.ms).moveY(begin: 16, end: 0),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(program.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('${program.level} • ${program.weeks} أسابيع', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _InfoPill(text: '${program.setsPerWeek} Sets/Week'),
                    _InfoPill(text: 'Coach: ${program.coach}'),
                    _InfoPill(text: '${program.durationMin} دقيقة'),
                  ],
                ),
                const SizedBox(height: 24),
                Text('حول البرنامج', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                Text(program.desc, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(content: Text('تم الانضمام إلى البرنامج (Mock)')));
                        },
                        style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
                        child: const Text('انضم للبرنامج'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pushNamed('warmup.list'),
                        style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
                        child: const Text('Warm-ups'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GalleryImage extends StatelessWidget {
  const _GalleryImage({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Image.network(url, fit: BoxFit.cover),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
      ),
      child: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
    );
  }
}
