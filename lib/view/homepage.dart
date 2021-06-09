import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notification_test/helper/notification_service.dart';
import 'package:notification_test/view/router/router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Home Page")),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
              heroTag: 'notif',
              onPressed: () => context
                  .read(notificationServiceProvider)
                  .showNotification(
                      (_) => AutoRouter.of(context).push(SecondPageRoute())),
              child: Icon(Icons.exit_to_app)),
          FloatingActionButton(
              heroTag: 'push',
              onPressed: () => AutoRouter.of(context).push(SecondPageRoute()),
              child: Icon(Icons.run_circle)),
        ],
      ),
    );
  }
}
