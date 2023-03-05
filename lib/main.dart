import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/application_bindings.dart';
import 'modules/mainPage.dart';
import 'routes/app_pages.dart';
import 'theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SHOPNOW',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      home: MainPage(),
      initialBinding: ApplicationBindings(),
    ),
  );
}
