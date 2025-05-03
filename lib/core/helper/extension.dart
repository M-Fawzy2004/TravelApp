import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  void pushNamedAndRemoveUntil(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  void pushNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  void pushReplacementNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  void pop() => Navigator.of(this).pop();

  void navigateWithSlideTransition(Widget page) {
    Navigator.of(this).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ));
  }
}
