import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr)),
      body: Column(
        children: [
          ListTile(
            title: const Text('English'),
            onTap: () {
              Get.updateLocale(const Locale('en', 'US'));
            },
          ),
          ListTile(
            title: const Text('العربية'),
            onTap: () {
              Get.updateLocale(const Locale('ar', 'IQ'));
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'theme'.tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text('light'.tr),
            leading: const Icon(Icons.light_mode),
            onTap: () {
              Get.changeThemeMode(ThemeMode.light);
            },
          ),
          ListTile(
            title: Text('dark'.tr),
            leading: const Icon(Icons.dark_mode),
            onTap: () {
              Get.changeThemeMode(ThemeMode.dark);
            },
          ),
        ],
      ),
    );
  }
}
