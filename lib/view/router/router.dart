import 'package:auto_route/auto_route.dart';
import 'package:notification_test/view/homepage.dart';
import 'package:notification_test/view/secondpage.dart';

export 'router.gr.dart';

@MaterialAutoRouter(
    // generateNavigationHelperExtension: true,
    // ignore: always_specify_types
    routes: <AutoRoute>[
      AutoRoute<dynamic>(
        path: '/',
        initial: true,
        page: HomePage,
      ),
      AutoRoute<dynamic>(
        page: SecondPage,
      ),
    ])
class $AppRouter {}
