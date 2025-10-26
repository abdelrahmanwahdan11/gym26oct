import 'package:flutter/material.dart';

import '../../controllers/app_scope.dart';
import '../../core/localization/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool hydrationReminders = true;
  bool challengeSpotlight = true;

  @override
  Widget build(BuildContext context) {
    final settings = AppScope.of(context).settings;
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings / الإعدادات')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: SwitchListTile(
              title: const Text('Dark Mode / الوضع الليلي'),
              subtitle: const Text('بدّل بين الثيم الفاتح والداكن'),
              value: settings.themeMode == ThemeMode.dark,
              onChanged: (_) => settings.toggleTheme(),
            ),
          ),
          const SizedBox(height: 16),
          Text('Language / اللغة', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
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
          const SizedBox(height: 24),
          Text('Measurement Units', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            children: [
              ChoiceChip(
                label: const Text('Kilograms'),
                selected: settings.weightUnit == 'kg',
                onSelected: (_) => settings.setWeightUnit('kg'),
              ),
              ChoiceChip(
                label: const Text('Pounds'),
                selected: settings.weightUnit == 'lb',
                onSelected: (_) => settings.setWeightUnit('lb'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Hydration Reminders'),
                  subtitle: const Text('إشعارات ذكية لتذكيرك بشرب الماء'),
                  value: hydrationReminders,
                  onChanged: (value) {
                    setState(() => hydrationReminders = value);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(value ? 'تم تفعيل تذكير الماء' : 'تم إيقاف تذكير الماء'),
                    ));
                  },
                ),
                const Divider(height: 0),
                SwitchListTile(
                  title: const Text('Challenge Spotlight'),
                  subtitle: const Text('احصل على إشعار عند توفر تحديات مجتمعية جديدة'),
                  value: challengeSpotlight,
                  onChanged: (value) {
                    setState(() => challengeSpotlight = value);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(value ? 'سننبهك بالتحديات الجديدة' : 'لن تتلقى إشعارات التحديات'),
                    ));
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.translate),
            title: Text(loc.t('search_hint')),
            subtitle: const Text('معاينة نص بحث متعدد اللغات'),
          ),
        ],
      ),
    );
  }
}
