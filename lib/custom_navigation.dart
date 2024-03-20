import 'package:flutter/material.dart';

void navigateWithFadeTransition(BuildContext context, Widget screen) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
        opacity: animation,
        child: screen,
      ),
      transitionDuration: Duration(milliseconds: 600),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;
        var tween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
        var opacityAnimation = animation.drive(tween);
        return FadeTransition(
          opacity: opacityAnimation,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: child,
          ),
        );
      },
    ),
  );
}