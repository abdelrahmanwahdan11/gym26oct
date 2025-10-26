import 'package:flutter/material.dart';

import '../../controllers/app_scope.dart';
import '../../core/localization/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppScope.of(context).settings;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings / الإعدادات')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: settings.themeMode == ThemeMode.dark,
              onChanged: (_) => settings.toggleTheme(),
            ),
            const SizedBox(height: 12),
            Text('Language', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              children: [
                ChoiceChip(
                  label: const Text('العربية'),
                  selected: settings.isArabic,
                  onSelected: (_) => settings.setLocale(const Locale('ar')),
                ),
                ChoiceChip(
                  label: const Text('English'),
                  selected: !settings.isArabic,
                  onSelected: (_) => settings.setLocale(const Locale('en')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
