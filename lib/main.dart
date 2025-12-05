import 'package:ecommerce_app/controllers/auth_controller.dart';
import 'package:ecommerce_app/controllers/navigation_controller.dart';
import 'package:ecommerce_app/controllers/product_controller.dart';
import 'package:ecommerce_app/controllers/theme_controller.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/utils/app_themes.dart';
import 'package:ecommerce_app/features/pages/splash_screen.dart';
import 'package:ecommerce_app/utils/firestore_data_seeder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();
  Get.put(ThemeController());
  Get.put(AuthController());
  Get.put(NavigationController());
  Get.put(ProductController());

  // the line below is used to seed sample data to firestore (for testing only)
  await FirestoreDataSeeder.seedAllData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fashion Store',
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: themeController.theme,
      defaultTransition: Transition.fade,
      builder: (context, child) => Overlay(
        initialEntries: [
          OverlayEntry(builder: (_) => child!),
        ],
      ),
      home: const SplashScreen(),
    );
  }
}
