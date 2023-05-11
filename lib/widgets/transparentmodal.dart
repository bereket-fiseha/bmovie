// this class defines the full-screen semi-transparent modal dialog
// by extending the ModalRoute class
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';

class FullScreenModal extends ModalRoute {
  // variables passed from the parent widget
  final String title;
  final String description;
  final Widget child;
  // constructor
  FullScreenModal({
    required this.child,
    required this.title,
    required this.description,
  });

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.8);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 40,
          ),
          child,
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 35.0),
          ),
          const SizedBox(
            height: 15,
          ),
          DefaultTextStyle(
            style: const TextStyle(
                fontSize: 30.0, fontFamily: 'Bobbers', color: Colors.white),
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(description,
                    speed: Duration(milliseconds: 100)),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton.icon(
            onPressed: () {
              // close the modal dialog and return some data if needed
              Navigator.pop(context,
                  ['This message was padded from the modal', 'KindaCode.com']);
            },
            icon: const Icon(Icons.close),
            label: const Text('Close'),
          )
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // add fade animation
    return FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animation),
      // add slide animation
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
