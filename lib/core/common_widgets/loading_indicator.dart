import 'dart:math';

import 'package:flutter/material.dart';

class LoadingIndicator extends StatefulWidget {
  @override
  _LoadingIndicatorState createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // Repeats the animation infinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 40,
        height: 40,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: CircularDotsPainter(_controller.value),
            );
          },
        ),
      ),
    );
  }
}

class CircularDotsPainter extends CustomPainter {
  final double progress;
  CircularDotsPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;

    final double radius = size.width / 2;
    final double dotRadius = 3;
    final int dotCount = 10;

    // Calculate the positions of the dots with fading opacity
    for (int i = 0; i < dotCount; i++) {
      // Calculate the angle for each dot
      final double angle = 2 * pi * (progress + i / dotCount);

      // Calculate the position of the dot
      final double x = radius + radius * cos(angle);
      final double y = radius + radius * sin(angle);

      // Determine opacity based on the position in the cycle
      final double fadeFactor =
          (1 - ((progress + i / dotCount) % 1)).clamp(0.2, 1.0);

      // Set the dot color with fading effect
      paint.color = Colors.grey.withOpacity(fadeFactor);

      // Draw the dot
      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(CircularDotsPainter oldDelegate) {
    return true; // Repaint whenever progress changes
  }
}
