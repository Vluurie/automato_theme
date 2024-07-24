import 'package:automato_theme/automato_theme.dart';
import 'package:automato_theme/src/widgets/dialog/automato_triangle_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Displays a customizable dialog with complex animations.
///
/// The `showAutomatoDialog` function shows a dialog with a series of animations
/// including scaling, fading, rotating, and sliding. It also integrates the
/// `TriangleRevealAnimation` for an additional visual effect.
///
/// ## Parameters:
/// - [context]: The build context in which to show the dialog.
/// - [ref]: A reference to the Riverpod provider for theme and state management.
/// - [dialog]: The dialog widget to display.
///
/// The function leverages `showGeneralDialog` to present the dialog with
/// multiple animations, enhancing the visual experience with a combination of
/// scaling, fading, rotating, and sliding transitions. Additionally, the
/// `TriangleRevealAnimation` adds a dynamic background effect during the
/// transition.
///
/// ## Example Usage:
/// ```dart
/// showAutomatoDialog(
///   context: context,
///   ref: ref,
///   dialog: YourDialogWidget(),
/// );
/// ```
void showAutomatoDialog({
  required BuildContext context,
  required WidgetRef ref,
  required Widget dialog,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: AutomatoThemeColors.transparentColor(ref),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return dialog;
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      var curve = Curves.slowMiddle;
      var bounceCurve = Curves.bounceInOut;

      var scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: bounceCurve),
      );
      var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: curve),
      );
      var rotationAnimation = Tween<double>(begin: -0.1, end: 0.0).animate(
        CurvedAnimation(parent: animation, curve: curve),
      );
      var slideAnimation =
          Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
              .animate(
        CurvedAnimation(parent: animation, curve: curve),
      );

      return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..rotateY(rotationAnimation.value),
            child: ScaleTransition(
              scale: scaleAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: SlideTransition(
                  position: slideAnimation,
                  child: Stack(
                    children: [
                      if (child != null) child,
                      IgnorePointer(
                        ignoring: true,
                        child: TriangleRevealAnimation(
                            controller: animation, ref: ref),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: dialog,
      );
    },
  );
}
