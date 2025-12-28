library custom_arrow;

import 'package:custom_arrow/src/arrow_configuration.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'enums.dart';

/// A custom painter that draws an arrow between two points.
///
/// This class extends [CustomPainter] and is used to create a customizable
/// arrow shape on a Flutter canvas. The arrow is defined by a starting point
/// and an ending point, along with a configuration that determines its appearance.
///
/// The [startPoint] and [endPoint] parameters define the positions of the arrow's
/// tail and tip, respectively. The [config] parameter allows customization of
/// the arrow's style, such as color, thickness, and arrowhead shape.
///
/// Example usage:
/// ```dart
/// CustomizableArrowPainter(
///   startPoint: Offset(50, 100),
///   endPoint: Offset(200, 100),
///   config: ArrowConfiguration(...),
/// )
/// ```
class CustomizableArrowPainter extends CustomPainter {
  final Offset startPoint;
  final Offset endPoint;
  final ArrowConfiguration config;

  CustomizableArrowPainter({
    required this.startPoint,
    required this.endPoint,
    required this.config,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = config.color
      ..strokeWidth = config.thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = config.strokeCap;

    // Create path based on curve style
    final path = _createPath();

    // Draw the line (dotted or solid)
    if (config.isDotted) {
      _drawDottedPath(canvas, path, paint);
    } else {
      canvas.drawPath(path, paint);
    }

    // Draw arrowhead if enabled
    if (config.showArrowhead) {
      final arrowAngle = _calculateArrowAngle(path);
      _drawArrowhead(canvas, endPoint, arrowAngle, paint);
    }
  }

  Path _createPath() {
    final path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);

    if (config.customControlPoints != null &&
        config.customControlPoints!.isNotEmpty) {
      _drawCustomBezierCurve(path);
    } else {
      switch (config.curveStyle) {
        case ArrowCurveStyle.straight:
          path.lineTo(endPoint.dx, endPoint.dy);
          break;
        case ArrowCurveStyle.smooth:
          _drawSmoothCurve(path);
          break;
        case ArrowCurveStyle.sCurve:
          _drawSCurve(path);
          break;
        case ArrowCurveStyle.arc:
          _drawArcCurve(path);
          break;
        case ArrowCurveStyle.reversedArc:
          _drawReversedArcCurve(path);
          break;
      }
    }

    return path;
  }

  void _drawSmoothCurve(Path path) {
    final dx = endPoint.dx - startPoint.dx;
    final dy = endPoint.dy - startPoint.dy;

    final intensity = config.curveIntensity;

    final cp1x = startPoint.dx + dx * 0.5;
    final cp1y = startPoint.dy + dy * intensity;

    path.quadraticBezierTo(cp1x, cp1y, endPoint.dx, endPoint.dy);
  }

  void _drawSCurve(Path path) {
    final dx = endPoint.dx - startPoint.dx;
    final dy = endPoint.dy - startPoint.dy;

    final intensity = config.curveIntensity;

    final cp1x = startPoint.dx + dx * 0.25;
    final cp1y = startPoint.dy + dy * (0.5 + intensity * 0.3);

    final cp2x = startPoint.dx + dx * 0.75;
    final cp2y = startPoint.dy + dy * (0.5 - intensity * 0.3);

    path.cubicTo(cp1x, cp1y, cp2x, cp2y, endPoint.dx, endPoint.dy);
  }

  void _drawArcCurve(Path path) {
    final dx = endPoint.dx - startPoint.dx;
    final dy = endPoint.dy - startPoint.dy;
    final distance = math.sqrt(dx * dx + dy * dy);

    final intensity = config.curveIntensity;
    final radius = distance * (0.5 + intensity);

    final midX = (startPoint.dx + endPoint.dx) / 2;
    final midY = (startPoint.dy + endPoint.dy) / 2;

    final perpX = -dy / distance;
    final perpY = dx / distance;

    final controlX = midX + perpX * radius * intensity * 0.5;
    final controlY = midY + perpY * radius * intensity * 0.5;

    path.quadraticBezierTo(controlX, controlY, endPoint.dx, endPoint.dy);
  }

  void _drawReversedArcCurve(Path path) {
    final dx = endPoint.dx - startPoint.dx;
    final dy = endPoint.dy - startPoint.dy;
    final distance = math.sqrt(dx * dx + dy * dy);

    final intensity = config.curveIntensity;
    final radius = distance * (0.5 + intensity);

    final midX = (startPoint.dx + endPoint.dx) / 2;
    final midY = (startPoint.dy + endPoint.dy) / 2;

    // Reversed perpendicular direction
    final perpX = dy / distance;
    final perpY = -dx / distance;

    final controlX = midX + perpX * radius * intensity * 0.5;
    final controlY = midY + perpY * radius * intensity * 0.5;

    path.quadraticBezierTo(controlX, controlY, endPoint.dx, endPoint.dy);
  }

  void _drawCustomBezierCurve(Path path) {
    final dx = endPoint.dx - startPoint.dx;
    final dy = endPoint.dy - startPoint.dy;

    final controlPoints = config.customControlPoints!;

    if (controlPoints.length == 1) {
      // Quadratic bezier
      final cp = Offset(
        startPoint.dx + dx * controlPoints[0].dx,
        startPoint.dy + dy * controlPoints[0].dy,
      );
      path.quadraticBezierTo(cp.dx, cp.dy, endPoint.dx, endPoint.dy);
    } else if (controlPoints.length >= 2) {
      // Cubic bezier
      final cp1 = Offset(
        startPoint.dx + dx * controlPoints[0].dx,
        startPoint.dy + dy * controlPoints[0].dy,
      );
      final cp2 = Offset(
        startPoint.dx + dx * controlPoints[1].dx,
        startPoint.dy + dy * controlPoints[1].dy,
      );
      path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, endPoint.dx, endPoint.dy);
    }
  }

  void _drawDottedPath(Canvas canvas, Path path, Paint paint) {
    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      double distance = 0.0;
      bool draw = true;

      while (distance < metric.length) {
        final length = draw ? config.dashLength : config.dashGap;
        final end = math.min(distance + length, metric.length);

        if (draw) {
          final extractPath = metric.extractPath(distance, end);
          canvas.drawPath(extractPath, paint);
        }

        distance = end;
        draw = !draw;
      }
    }
  }

  double _calculateArrowAngle(Path path) {
    final pathMetrics = path.computeMetrics().first;
    final endTangent = pathMetrics.getTangentForOffset(pathMetrics.length);

    if (endTangent != null) {
      return math.atan2(endTangent.vector.dy, endTangent.vector.dx);
    }

    // Fallback: calculate angle from last segment
    return math.atan2(endPoint.dy - startPoint.dy, endPoint.dx - startPoint.dx);
  }

  void _drawArrowhead(Canvas canvas, Offset tip, double angle, Paint paint) {
    final arrowAngleRad = config.arrowheadAngle * math.pi / 180;

    final arrowPaint = Paint()
      ..color = config.color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(tip.dx, tip.dy);
    path.lineTo(
      tip.dx - config.arrowheadSize * math.cos(angle - arrowAngleRad),
      tip.dy - config.arrowheadSize * math.sin(angle - arrowAngleRad),
    );
    path.lineTo(
      tip.dx - config.arrowheadSize * math.cos(angle + arrowAngleRad),
      tip.dy - config.arrowheadSize * math.sin(angle + arrowAngleRad),
    );
    path.close();

    canvas.drawPath(path, arrowPaint);
  }

  @override
  bool shouldRepaint(CustomizableArrowPainter oldDelegate) {
    return oldDelegate.startPoint != startPoint ||
        oldDelegate.endPoint != endPoint ||
        oldDelegate.config != config;
  }
}

/// A widget that draws a customizable arrow between two points.
///
/// The [CustomArrow] widget takes a starting point and an ending point,
/// and uses the [CustomizableArrowPainter] to render the arrow on the screen.
///
/// The [startPoint] and [endPoint] parameters define the positions of the
/// arrow's start and end points, respectively. The [config] parameter allows
/// customization of the arrow's appearance, such as color and thickness.
///
/// Example usage:
/// ```dart
/// CustomArrow(
///   startPoint: Offset(0, 0),
///   endPoint: Offset(100, 100),
///   config: ArrowConfiguration(color: Colors.red, thickness: 2.0),
/// )
/// ```
///
/// Requires the [ArrowConfiguration] class to define the arrow's properties.
class CustomArrow extends StatelessWidget {
  final Offset startPoint;
  final Offset endPoint;
  final ArrowConfiguration config;

  const CustomArrow({
    super.key,
    required this.startPoint,
    required this.endPoint,
    this.config = const ArrowConfiguration(),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomizableArrowPainter(
        startPoint: startPoint,
        endPoint: endPoint,
        config: config,
      ),
    );
  }
}
