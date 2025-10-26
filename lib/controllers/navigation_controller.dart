import 'package:flutter/material.dart';

class NavigationController extends NavigatorObserver {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final ValueNotifier<String?> currentRoute = ValueNotifier<String?>(null);

  Future<T?> push<T extends Object?>(String route, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed<T>(route, arguments: arguments);
  }

  Future<T?> replaceWith<T extends Object?, TO extends Object?>(
    String route, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!
        .pushReplacementNamed<T, TO>(route, arguments: arguments);
  }

  void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState!.pop<T>(result);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    currentRoute.value = route.settings.name;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    currentRoute.value = previousRoute?.settings.name;
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    currentRoute.value = newRoute?.settings.name;
  }
}
