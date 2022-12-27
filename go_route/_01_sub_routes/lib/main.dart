import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart' show usePathUrlStrategy;

// This scenario demonstrates an app with multi-level routing.
//
// The GoRoute '/' builds a HomeScreen page and has a sub-route, 'family'. The
// 'family' also has its own sub-route, person'.
//
void main() {
  // handle the browser URL. (remove # form url)
  usePathUrlStrategy();
  runApp(App());
}

/// The main app.
class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  static const String title = 'GoRouter Example: Sub-routes';

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: title,

      //  routerConfig:  _router,
      //  or (any one)
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      routerDelegate: _router.routerDelegate,
    );
  }

  final _router = GoRouter(initialLocation: '/', routes: [
    GoRoute(
        path: '/', // root path or entry point  ______https://xyz/
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
              path: 'family', // child of root path  ______https://xyz/family
              builder: (context, state) => const FamilyScreen(),
              routes: [
                GoRoute(
                  path:
                      'person', // child of family path ______https://xyz/family/person
                  builder: (context, state) => const PersonScreen(),
                )
              ])
        ])
  ]);
}

/// The home screen that shows a list of families.
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text(App.title)),
        body: Center(
          child: ElevatedButton(
            onPressed: () => context.go('/family'),
            child: const Text('Go to family screen'),
          ),
        ),
      );
}

/// The screen that shows a list of persons in a family.
class FamilyScreen extends StatelessWidget {
  const FamilyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Family screen')),
        body: Center(
          child: ElevatedButton(
            onPressed: () => context.go('/family/person'),
            child: const Text('Go to person screen'),
          ),
        ),
      );
}

/// The person screen.
class PersonScreen extends StatelessWidget {
  const PersonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Person screen')),
      body: const Center(
        child: Text('This is the person screen'),
      ));
}
