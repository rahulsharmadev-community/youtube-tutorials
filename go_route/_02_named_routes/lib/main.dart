import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart' show usePathUrlStrategy;
import 'consts.dart';
part 'screens.dart';

void main() {
  usePathUrlStrategy();
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  static const String title = 'GoRouter Example: Named Routes';

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: title,
      routerConfig: _router,
      // or
      // routeInformationProvider: _router.routeInformationProvider,
      
      // routeInformationParser: _router.routeInformationParser,
      // routerDelegate: _router.routerDelegate,
    );
  }

  final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) => const HomeScreen(),
        routes: <GoRoute>[
          GoRoute(
            name: 'family',
            path: 'family/:fid', //  https://localhost/fid
            builder: (context, state) => FamilyScreen(
              fid: state.params['fid']!,
            ),
            routes: <GoRoute>[
              GoRoute(
                  name: 'person',
                  path: 'person/:pid', //  https://localhost/fid/pid
                  builder: (context, state) => PersonScreen(
                        fid: state.params['fid']!,
                        pid: state.params['pid']!,
                      ))
            ],
          ),
        ],
      ),
    ],
  );
}
