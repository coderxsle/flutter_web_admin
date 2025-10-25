import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final BorderRadius borderRadius;
  final VoidCallback onPressed;
  const GradientButton({super.key, 
    required this.child,
    required this.gradient,
    required this.borderRadius,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}