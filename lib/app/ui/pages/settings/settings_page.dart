import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/locale_controller.dart';
import '../../../controllers/theme_controller.dart';
import '../../widgets/app_background.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();
    final locale = Get.find<LocaleController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AppBackground(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Obx(
              () => SwitchListTile(
                value: theme.themeMode == ThemeMode.dark,
                title: Text('dark_mode'.tr),
                onChanged: (value) => theme.setTheme(value ? ThemeMode.dark : ThemeMode.light),
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              title: Text('language'.tr),
              trailing: DropdownButton<String>(
                value: locale.locale.languageCode,
                items: const [
                  DropdownMenuItem(value: 'ar', child: Text('العربية')),
                  DropdownMenuItem(value: 'en', child: Text('English')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    locale.setLocale(Locale(value));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
