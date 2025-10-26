import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class FadeSlidePageTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(parent: animation, curve: curve ?? Curves.easeOut);
    final offsetAnimation = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(curved);
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(position: offsetAnimation, child: child).animate().fadeIn(duration: 280.ms),
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
    final curved = CurvedAnimation(parent: animation, curve: curve ?? Curves.easeOut);
    final offsetAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(curved);
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(position: offsetAnimation, child: child),
    );
  }
}
