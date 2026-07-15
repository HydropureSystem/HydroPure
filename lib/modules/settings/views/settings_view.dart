import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/theme/app_colors.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            /// NOTIFICATION
            _sectionTitle("Notifications"),

            _switchTile(
              title: "Enable Notifications",
              value: controller.notificationEnabled,
            ),

            _switchTile(
              title: "Market Updates",
              value: controller.marketNotification,
            ),

            _switchTile(
              title: "AI Recommendations",
              value: controller.aiNotification,
            ),

            const SizedBox(height: 25),

            /// THEME
            _sectionTitle("Theme"),

            Obx(
              () => Card(
                child: ListTile(
                  leading: const Icon(Icons.palette),
                  title: const Text("Theme"),

                  trailing: DropdownButton<String>(
                    value: controller.selectedTheme.value,

                    items: const [
                      DropdownMenuItem(
                        value: "Light",
                        child: Text("Light"),
                      ),
                      DropdownMenuItem(
                        value: "Dark",
                        child: Text("Dark"),
                      ),
                      DropdownMenuItem(
                        value: "System",
                        child: Text("System"),
                      ),
                    ],

                    onChanged: (value) {
                      if (value == null) return;

                        controller.selectedTheme.value = value;

                        switch (value) {
                          case "Light":
                            Get.changeThemeMode(ThemeMode.light);
                            break;

                          case "Dark":
                            Get.changeThemeMode(ThemeMode.dark);
                            break;

                          case "System":
                            Get.changeThemeMode(ThemeMode.system);
                            break;
                        }
                        controller.saveSettings();
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// LANGUAGE
            _sectionTitle("Language"),

            Obx(
              () => Card(
                child: ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text("Language"),

                  trailing: DropdownButton<String>(
                    value:
                        controller.selectedLanguage.value,

                    items: const [
                      DropdownMenuItem(
                        value: "Indonesia",
                        child: Text("Indonesia"),
                      ),
                      DropdownMenuItem(
                        value: "English",
                        child: Text("English"),
                      ),
                    ],

                    onChanged: (value) {
                      if (value == null) return;

                        controller.selectedLanguage.value = value;
                        controller.saveSettings();
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// ABOUT
            _sectionTitle("About"),

            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text("Version"),
                    subtitle: const Text("1.0.0"),
                  ),

                  ListTile(
                    leading: const Icon(Icons.description),
                    title: const Text("Terms & Conditions"),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.privacy_tip),
                    title: const Text("Privacy Policy"),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,

      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
        ),

        child: Text(
          title,

          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _switchTile({
    required String title,
    required RxBool value,
  }) {
    return Obx(
      () => Card(
        child: SwitchListTile(
          title: Text(title),
          value: value.value,

          onChanged: (val) {
            value.value = val;
            controller.saveSettings();
          },
        ),
      ),
    );
  }
}