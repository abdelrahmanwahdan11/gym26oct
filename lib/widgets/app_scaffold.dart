import 'package:flutter/material.dart';

import '../core/localization/app_localizations.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    required this.activeTab,
    required this.onTabSelected,
    this.appBar,
    this.floatingActionButton,
  });

  final Widget body;
  final String activeTab;
  final void Function(String) onTabSelected;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final tabs = [
      _TabItem('generator', Icons.bolt_outlined, loc.t('generator')),
      _TabItem('programs', Icons.layers_outlined, loc.t('programs')),
      _TabItem('clips', Icons.play_circle_outline, loc.t('clips')),
      _TabItem('store', Icons.shopping_bag_outlined, loc.t('store')),
      _TabItem('trainers', Icons.group_outlined, loc.t('trainers')),
      _TabItem('profile', Icons.person_outline, loc.t('profile')),
    ];

    var currentIndex = tabs.indexWhere((element) => element.id == activeTab);
    if (currentIndex < 0) currentIndex = 0;
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final targetWidth = 900.0;
            final padding = constraints.maxWidth > targetWidth
                ? (constraints.maxWidth - targetWidth) / 2
                : 0.0;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: body,
            );
          },
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => onTabSelected(tabs[index].id),
        type: BottomNavigationBarType.fixed,
        items: tabs
            .map((tab) => BottomNavigationBarItem(icon: Icon(tab.icon), label: tab.label))
            .toList(growable: false),
      ),
    );
  }
}

class _TabItem {
  const _TabItem(this.id, this.icon, this.label);

  final String id;
  final IconData icon;
  final String label;
}
