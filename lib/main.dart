import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notification_test/view/router/router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  // MobileAds.instance.initialize();

  // it should be the first line in main method
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await FlutterDownloader.initialize();

  MobileAds.instance.initialize();

  runApp(ProviderScope(
      child: EasyLocalization(
    supportedLocales: const <Locale>[
      Locale('en', 'GB'),
    ],
    path: 'assets/translations',
    fallbackLocale: const Locale('en', 'GB'),
    useOnlyLangCode: true,
    useFallbackTranslations: true,
    child: MyApp(),
  )));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
