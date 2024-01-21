import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/rate_app/application/rate_app_service.dart';
import 'palette.dart';
import 'routing/app_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(rateAppServiceProvider).requestReview();

    return MaterialApp.router(
      routerConfig: goRouter,
      restorationScopeId: 'app',
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: kMainBackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: kPrimaryColor,
        ),
      ),
    );
  }
}
