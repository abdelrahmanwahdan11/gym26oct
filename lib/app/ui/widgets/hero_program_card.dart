import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class HeroProgramCard extends StatelessWidget {
  const HeroProgramCard({super.key, required this.image, required this.title, required this.route});

  final String image;
  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF6C7CFF), Color(0xFF7CD4F9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [BoxShadow(color: Color(0x2912182F), blurRadius: 42, offset: Offset(0, 14))],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(image, fit: BoxFit.cover).animate(onPlay: (controller) => controller.repeat()).shimmer(duration: 1600.ms),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.45), Colors.black.withOpacity(0.1)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6C7CFF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                  onPressed: () => Get.toNamed(route),
                  child: Text('start_workout'.tr),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
