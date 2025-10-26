import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class GlassPageTransition extends CustomTransition {
  const GlassPageTransition();

  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: curve ?? Curves.easeOutCubic,
      reverseCurve: Curves.easeInOut,
    );
    final offsetAnimation = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(curved);
    final scaleAnimation = Tween<double>(begin: 0.98, end: 1).animate(curved);
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: offsetAnimation,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: child.animate().fadeIn(duration: 240.ms, curve: Curves.easeOutCubic),
        ),
      ),
    );
  }
}

class BottomSheetPageTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: curve ?? Curves.easeOutCubic,
      reverseCurve: Curves.easeIn,
    );
    final offsetAnimation = Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero).animate(curved);
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(position: offsetAnimation, child: child),
    );
  }
}
