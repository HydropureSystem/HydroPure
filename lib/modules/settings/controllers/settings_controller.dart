import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  RxBool notificationEnabled = true.obs;
  RxBool marketNotification = true.obs;
  RxBool aiNotification = true.obs;

  RxString selectedTheme = "System".obs;
  RxString selectedLanguage = "Indonesia".obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    notificationEnabled.value =
        prefs.getBool("notificationEnabled") ?? true;

    marketNotification.value =
        prefs.getBool("marketNotification") ?? true;

    aiNotification.value =
        prefs.getBool("aiNotification") ?? true;

    selectedTheme.value =
        prefs.getString("theme") ?? "System";

    selectedLanguage.value =
        prefs.getString("language") ?? "Indonesia";
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      "notificationEnabled",
      notificationEnabled.value,
    );

    await prefs.setBool(
      "marketNotification",
      marketNotification.value,
    );

    await prefs.setBool(
      "aiNotification",
      aiNotification.value,
    );

    await prefs.setString(
      "theme",
      selectedTheme.value,
    );

    await prefs.setString(
      "language",
      selectedLanguage.value,
    );
  }
}