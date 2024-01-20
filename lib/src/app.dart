import 'package:flutter/material.dart';
import 'package:miotonus/src/config/router.dart';
import 'package:miotonus/src/config/themes.dart';
import 'package:miotonus/src/utils/constants/strings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appTitle,
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}
