import 'package:flutter/material.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';

class OviAiApp extends StatelessWidget {
  const OviAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'OVI AI',
      debugShowCheckedModeBanner: false,
      theme: OviTheme.dark(),
      routerConfig: appRouter,
    );
  }
}
