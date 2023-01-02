// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'const.dart';

part 'screens.dart';

void main() {
  usePathUrlStrategy();
  runApp(App());
}

/// The main app.
class App extends StatelessWidget {
  /// Creates an [App].
  App({Key? key}) : super(key: key);

  /// The title of the app.
  static const String title = 'GoRouter Example: Query Parameters';

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: title,
      debugShowCheckedModeBanner: false,
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/', // root path
        builder: (context, state) => const HomeScreen(),
        routes: <GoRoute>[
          GoRoute(
              name: 'family',
              path: ':fid',
              builder: (context, state) {
                return FamilyScreen(
                  fid: state.params['fid']!,
                  asc: state.queryParams['sort'] == 'asc',
                );
              }),
        ],
      ),
    ],
  );
}
