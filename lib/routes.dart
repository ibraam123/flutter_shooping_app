
import 'package:flutter/cupertino.dart';

class AppRoutes {
  static Route createFadeRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(seconds: 1),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}