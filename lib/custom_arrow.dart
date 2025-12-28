/// A highly customizable Flutter package for drawing arrows between widgets.
///
/// This library provides tools to create beautiful, customizable arrows that can
/// connect widgets in your Flutter app. Perfect for onboarding flows, tutorials,
/// flowcharts, and process diagrams.
///
/// ## Features
///
/// * Multiple curve styles (straight, smooth, S-curve, arc, reversed arc)
/// * Dotted or solid lines with customizable dash patterns
/// * Configurable arrowheads
/// * Smart anchor positioning system
/// * Custom Bezier curves support
///
/// ## Usage
///
/// ```dart
/// import 'package:custom_arrow/custom_arrow.dart';
///
/// // Connect two widgets
/// ArrowConnector(
///   startKey: widget1Key,
///   endKey: widget2Key,
///   config: ArrowConfiguration(
///     isDotted: true,
///     curveStyle: ArrowCurveStyle.sCurve,
///   ),
/// )
/// ```
library;

export 'src/enums.dart';
export 'src/arrow_configuration.dart';
export 'src/arrow_painter.dart';
export 'src/arrow_connector.dart';
