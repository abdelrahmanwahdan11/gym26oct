import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

PageRouteBuilder<T> buildAnimatedRoute<T>({required WidgetBuilder builder, RouteSettings? settings}) {
  return PageRouteBuilder<T>(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = animation.drive(CurveTween(curve: Curves.easeOut));
      final offsetAnimation = curved.drive(Tween(begin: const Offset(0, 0.06), end: Offset.zero));
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(position: offsetAnimation, child: child),
      ).animate().fadeIn(duration: 280.ms);
    },
  );
}

PageRouteBuilder<T> buildBottomSheetRoute<T>({required WidgetBuilder builder, RouteSettings? settings}) {
  return PageRouteBuilder<T>(
    opaque: false,
    barrierColor: Colors.black54,
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) => Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(heightFactor: 0.75, child: builder(context)),
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = animation.drive(CurveTween(curve: Curves.easeOut));
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(position: curved.drive(Tween(begin: const Offset(0, 0.2), end: Offset.zero)), child: child),
      );
    },
  );
}
