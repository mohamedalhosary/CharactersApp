import 'package:flutter/material.dart';
import 'package:flutter_breaking/app_router.dart';

void main() {
  runApp(CharactersApp(appRouter: AppRouter()));
}

class CharactersApp extends StatelessWidget {
  final AppRouter appRouter;

  const CharactersApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.GenerateRoute,
    );
  }
}
