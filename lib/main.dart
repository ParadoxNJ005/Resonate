import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:resonate/firebase_options.dart';
import 'package:resonate/themes/new_theme.dart';
import 'package:resonate/routes/app_pages.dart';
import 'package:resonate/routes/app_routes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:resonate/themes/theme_list.dart';
import 'package:resonate/utils/ui_sizes.dart';
import 'themes/new_theme_screen_controller.dart';
import 'themes/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    UiSizes.init(context);
    final newThemeController = Get.put(NewThemeController());
    Get.put(ThemeController());

    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Resonate',
        theme: NewTheme.setLightTheme(
          ThemeList.getThemeModel(
            newThemeController.currentTheme.value,
          ),
        ),
        darkTheme: NewTheme.setDarkTheme(
          ThemeList.getThemeModel(
            newThemeController.currentTheme.value,
          ),
        ),
        themeMode: ThemeList.getThemeModel(
          newThemeController.currentTheme.value,
        ).themeMode,
        initialRoute: AppRoutes.splash,
        getPages: AppPages.pages,
      ),
    );
  }
}
