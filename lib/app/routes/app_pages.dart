import 'package:get/get.dart';
import 'package:hydropure/modules/login/bindings/login_binding.dart';
import 'package:hydropure/modules/login/views/login_view.dart';
import 'package:hydropure/modules/nutrition_stats/bindings/nutrition_binding.dart';
import 'package:hydropure/modules/nutrition_stats/views/nutrition_view.dart';
import 'package:hydropure/modules/register/bindings/register_binding.dart';
import 'package:hydropure/modules/register/views/register_view.dart';

import '../../modules/home/bindings/home_binding.dart';
import '../../modules/home/views/home_view.dart';

import '../../modules/pest_detection/bindings/pest_detection_binding.dart';
import '../../modules/pest_detection/views/pest_detection_view.dart';

import '../../modules/detection_result/bindings/detection_result_binding.dart';
import '../../modules/detection_result/views/detection_result_view.dart';

import '../../modules/ai_chat/bindings/ai_chat_binding.dart';
import '../../modules/ai_chat/views/ai_chat_view.dart';

import '../../modules/alerts/bindings/alert_binding.dart';
import '../../modules/alerts/views/alert_view.dart';

import '../../modules/market_price/bindings/market_price_binding.dart';
import '../../modules/market_price/views/market_price_view.dart';

import '../../modules/splash/bindings/splash_binding.dart';
import '../../modules/splash/views/splash_view.dart';

import '../../modules/otp/bindings/otp_binding.dart';
import '../../modules/otp/views/otp_view.dart';

import 'app_routes.dart';

class AppPages {
  static const initial = Routes.SPLASH;

  static final routes = [
    /// Register
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),

    /// Login
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PEST_DETECTION,
      page: () => const PestDetectionView(),
      binding: PestDetectionBinding(),
    ),
    GetPage(
      name: Routes.DETECTION_RESULT,
      page: () => const DetectionResultView(),
      binding: DetectionResultBinding(),
    ),
    GetPage(
      name: Routes.AI_CHAT,
      page: () => const AiChatView(),
      binding: AiChatBinding(),
    ),
    GetPage(
      name: Routes.ALERT,
      page: () => const AlertView(),
      binding: AlertBinding(),
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.MARKET_PRICE,
      page: () => MarketPriceView(),
      binding: MarketPriceBinding(),
    ),
    GetPage(
      name: Routes.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: Routes.NUTRITIONS,
      page: () => const NutritionView(),
      binding: NutritionBinding(),
    ),
  ];
}
