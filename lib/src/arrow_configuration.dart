import 'package:flutter/material.dart';
import 'enums.dart';

/// Configuration class that defines the visual appearance and behavior of arrows.
///
/// This class provides comprehensive customization options for arrow rendering,
/// including line style (dotted or solid), arrowhead appearance, curve styling,
/// and color/thickness properties.
///
/// ## Properties
///
/// **Line Style:**
/// - [isDotted]: Controls whether the arrow line is rendered as a dotted/dashed line
/// - [dashLength]: The length of individual dashes when [isDotted] is true
/// - [dashGap]: The gap between dashes when [isDotted] is true
///
/// **Line Appearance:**
/// - [thickness]: The stroke width of the arrow line
/// - [color]: The color of the entire arrow (line and arrowhead)
/// - [strokeCap]: The cap style applied to line ends
///
/// **Arrowhead:**
/// - [showArrowhead]: Whether to display the arrowhead at the end of the arrow
/// - [arrowheadSize]: The size of the arrowhead in logical pixels
/// - [arrowheadAngle]: The angle of the arrowhead point in degrees
///
/// **Curve Style:**
/// - [curveStyle]: The predefined curve style for the arrow path
/// - [curveIntensity]: Controls the prominence of curves (0.0 to 1.0)
/// - [customControlPoints]: Optional custom bezier control points for advanced curve customization
///
/// ## Usage
///
/// ```dart
/// final config = ArrowConfiguration(
///   isDotted: true,
///   dashLength: 8.0,
///   color: Colors.blue,
///   thickness: 2.0,
///   curveStyle: ArrowCurveStyle.sCurve,
/// );
/// ```
///
/// Use [copyWith] to create a modified copy of this configuration:
///
/// ```dart
/// final newConfig = config.copyWith(color: Colors.red, thickness: 3.0);
/// ```
class ArrowConfiguration {
  /// Whether the arrow line should be dotted
  final bool isDotted;

  /// Length of each dash (only used if isDotted is true)
  final double dashLength;

  /// Gap between dashes (only used if isDotted is true)
  final double dashGap;

  /// Thickness of the arrow line
  final double thickness;

  /// Color of the arrow
  final Color color;

  /// Size of the arrowhead
  final double arrowheadSize;

  /// Angle of the arrowhead in degrees
  final double arrowheadAngle;

  /// Whether to show the arrowhead
  final bool showArrowhead;

  /// Curve style of the arrow
  final ArrowCurveStyle curveStyle;

  /// Curve intensity (0.0 to 1.0, only used for curved styles)
  /// Higher values create more pronounced curves
  final double curveIntensity;

  /// Custom control points for bezier curve (overrides curveStyle if provided)
  /// Values should be between 0.0 and 1.0
  final List<Offset>? customControlPoints;

  /// Cap style for line ends
  final StrokeCap strokeCap;

  const ArrowConfiguration({
    this.isDotted = true,
    this.dashLength = 8.0,
    this.dashGap = 6.0,
    this.thickness = 2.0,
    this.color = const Color(0xFF94A3B8),
    this.arrowheadSize = 12.0,
    this.arrowheadAngle = 25.0,
    this.showArrowhead = true,
    this.curveStyle = ArrowCurveStyle.sCurve,
    this.curveIntensity = 0.5,
    this.customControlPoints,
    this.strokeCap = StrokeCap.round,
  });

  ArrowConfiguration copyWith({
    bool? isDotted,
    double? dashLength,
    double? dashGap,
    double? thickness,
    Color? color,
    double? arrowheadSize,
    double? arrowheadAngle,
    bool? showArrowhead,
    ArrowCurveStyle? curveStyle,
    double? curveIntensity,
    List<Offset>? customControlPoints,
    StrokeCap? strokeCap,
  }) {
    return ArrowConfiguration(
      isDotted: isDotted ?? this.isDotted,
      dashLength: dashLength ?? this.dashLength,
      dashGap: dashGap ?? this.dashGap,
      thickness: thickness ?? this.thickness,
      color: color ?? this.color,
      arrowheadSize: arrowheadSize ?? this.arrowheadSize,
      arrowheadAngle: arrowheadAngle ?? this.arrowheadAngle,
      showArrowhead: showArrowhead ?? this.showArrowhead,
      curveStyle: curveStyle ?? this.curveStyle,
      curveIntensity: curveIntensity ?? this.curveIntensity,
      customControlPoints: customControlPoints ?? this.customControlPoints,
      strokeCap: strokeCap ?? this.strokeCap,
    );
  }
}
