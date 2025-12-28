library custom_arrow;

import 'package:custom_arrow/custom_arrow.dart';
import 'package:flutter/material.dart';

/// A helper class for calculating anchor positions.
///
/// This class provides a static method to retrieve the position
/// of various anchor points represented by the [AnchorPosition] enum.
///
/// The positions are represented as a map with 'x' and 'y' coordinates,
/// where the values range from 0.0 to 1.0, indicating the relative
/// position within a unit space.
///
/// The available anchor positions are:
/// - [AnchorPosition.topLeft]: The top-left corner (0.0, 0.0).
/// - [AnchorPosition.topCenter]: The top center (0.5, 0.0).
/// - [AnchorPosition.topRight]: The top-right corner (1.0, 0.0).
/// - [AnchorPosition.centerLeft]: The center-left (0.0, 0.5).
/// - [AnchorPosition.center]: The center (0.5, 0.5).
/// - [AnchorPosition.centerRight]: The center-right (1.0, 0.5).
/// - [AnchorPosition.bottomLeft]: The bottom-left corner (0.0, 1.0).
/// - [AnchorPosition.bottomCenter]: The bottom center (0.5, 1.0).
/// - [AnchorPosition.bottomRight]: The bottom-right corner (1.0, 1.0).
/// - [AnchorPosition.custom]: A custom position defaulting to center (0.5, 0.5).
///
/// Returns a map containing the 'x' and 'y' coordinates for the specified
/// [position].

class _AnchorHelper {
  static Map<String, double> getPosition(AnchorPosition position) {
    switch (position) {
      case AnchorPosition.topLeft:
        return {'x': 0.0, 'y': 0.0};
      case AnchorPosition.topCenter:
        return {'x': 0.5, 'y': 0.0};
      case AnchorPosition.topRight:
        return {'x': 1.0, 'y': 0.0};
      case AnchorPosition.centerLeft:
        return {'x': 0.0, 'y': 0.5};
      case AnchorPosition.center:
        return {'x': 0.5, 'y': 0.5};
      case AnchorPosition.centerRight:
        return {'x': 1.0, 'y': 0.5};
      case AnchorPosition.bottomLeft:
        return {'x': 0.0, 'y': 1.0};
      case AnchorPosition.bottomCenter:
        return {'x': 0.5, 'y': 1.0};
      case AnchorPosition.bottomRight:
        return {'x': 1.0, 'y': 1.0};
      case AnchorPosition.custom:
        return {'x': 0.5, 'y': 0.5};
    }
  }
}

/// A widget that connects two points with an arrow.
///
/// The [ArrowConnector] widget draws an arrow between two specified points
/// in the widget tree, defined by the [startKey] and [endKey]. The arrow's
/// appearance and behavior can be customized using the [config] parameter,
/// and the anchor positions can be adjusted using [startAnchor] and
/// [endAnchor]. Additionally, you can provide fractional offsets for the
/// start and end points using [startXFraction], [startYFraction],
/// [endXFraction], and [endYFraction]. The offsets can be further refined
/// using [startXOffset], [startYOffset], [endXOffset], and [endYOffset].
///
/// The [ArrowConnector] requires the following parameters:
///
/// - [startKey]: A [GlobalKey] that identifies the starting widget.
/// - [endKey]: A [GlobalKey] that identifies the ending widget.
///
/// Optional parameters:
/// - [config]: Configuration for the arrow's appearance (default is a new instance of [ArrowConfiguration]).
/// - [startAnchor]: The anchor position for the start point (default is [AnchorPosition.centerRight]).
/// - [endAnchor]: The anchor position for the end point (default is [AnchorPosition.centerLeft]).
/// - [startXFraction]: The x-coordinate fraction for the start point (optional).
/// - [startYFraction]: The y-coordinate fraction for the start point (optional).
/// - [endXFraction]: The x-coordinate fraction for the end point (optional).
/// - [endYFraction]: The y-coordinate fraction for the end point (optional).
/// - [startXOffset]: The x-offset for the start point (default is 0.0).
/// - [startYOffset]: The y-offset for the start point (default is 0.0).
/// - [endXOffset]: The x-offset for the end point (default is 0.0).
/// - [endYOffset]: The y-offset for the end point (default is 0.0).
///
/// This widget uses [CustomPaint] to draw the arrow based on the provided
/// parameters and the positions of the widgets identified by the keys.
class ArrowConnector extends StatelessWidget {
  final GlobalKey startKey;
  final GlobalKey endKey;
  final ArrowConfiguration config;
  final AnchorPosition startAnchor;
  final AnchorPosition endAnchor;
  final double? startXFraction;
  final double? startYFraction;
  final double? endXFraction;
  final double? endYFraction;
  final double startXOffset;
  final double startYOffset;
  final double endXOffset;
  final double endYOffset;

  const ArrowConnector({
    super.key,
    required this.startKey,
    required this.endKey,
    this.config = const ArrowConfiguration(),
    this.startAnchor = AnchorPosition.centerRight,
    this.endAnchor = AnchorPosition.centerLeft,
    this.startXFraction,
    this.startYFraction,
    this.endXFraction,
    this.endYFraction,
    this.startXOffset = 0.0,
    this.startYOffset = 0.0,
    this.endXOffset = 0.0,
    this.endYOffset = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final startPos = _AnchorHelper.getPosition(startAnchor);
    final endPos = _AnchorHelper.getPosition(endAnchor);

    final finalStartX =
        startAnchor == AnchorPosition.custom && startXFraction != null
            ? startXFraction!
            : startPos['x']!;
    final finalStartY =
        startAnchor == AnchorPosition.custom && startYFraction != null
            ? startYFraction!
            : startPos['y']!;
    final finalEndX = endAnchor == AnchorPosition.custom && endXFraction != null
        ? endXFraction!
        : endPos['x']!;
    final finalEndY = endAnchor == AnchorPosition.custom && endYFraction != null
        ? endYFraction!
        : endPos['y']!;

    return CustomPaint(
      painter: WidgetConnectorPainter(
        startKey: startKey,
        endKey: endKey,
        context: context,
        config: config,
        startXFraction: finalStartX,
        startYFraction: finalStartY,
        endXFraction: finalEndX,
        endYFraction: finalEndY,
        startXOffset: startXOffset,
        startYOffset: startYOffset,
        endXOffset: endXOffset,
        endYOffset: endYOffset,
      ),
    );
  }
}

/// A custom painter that draws an arrow connector between two widgets.
///
/// This painter draws a line with an arrowhead connecting two widgets identified
/// by their [GlobalKey]s. The connection points can be customized using fractional
/// positions and offsets relative to each widget's size.
///
/// The [startPoint] is calculated using [startXFraction], [startYFraction],
/// [startXOffset], and [startYOffset] applied to the start widget's dimensions.
/// Similarly, the [endPoint] is calculated using the corresponding end widget
/// positioning parameters.
///
/// Parameters:
///   - [startKey]: Global key identifying the widget where the arrow starts
///   - [endKey]: Global key identifying the widget where the arrow ends
///   - [context]: Build context of the parent Stack widget containing both widgets
///   - [config]: Arrow styling configuration (defaults to [ArrowConfiguration])
///   - [startXFraction]: Horizontal position on start widget (0.0 = left, 1.0 = right)
///   - [startYFraction]: Vertical position on start widget (0.0 = top, 1.0 = bottom)
///   - [endXFraction]: Horizontal position on end widget (0.0 = left, 1.0 = right)
///   - [endYFraction]: Vertical position on end widget (0.0 = top, 1.0 = bottom)
///   - [startXOffset]: Additional horizontal offset in pixels from calculated start position
///   - [startYOffset]: Additional vertical offset in pixels from calculated start position
///   - [endXOffset]: Additional horizontal offset in pixels from calculated end position
///   - [endYOffset]: Additional vertical offset in pixels from calculated end position
///
/// Note: This painter always triggers repainting on each frame. Consider optimizing
/// [shouldRepaint] if performance becomes an issue.
class WidgetConnectorPainter extends CustomPainter {
  final GlobalKey startKey;
  final GlobalKey endKey;
  final BuildContext context;
  final ArrowConfiguration config;

  // Start point positioning
  final double startXFraction;
  final double startYFraction;
  final double startXOffset;
  final double startYOffset;

  // End point positioning
  final double endXFraction;
  final double endYFraction;
  final double endXOffset;
  final double endYOffset;

  WidgetConnectorPainter({
    required this.startKey,
    required this.endKey,
    required this.context,
    ArrowConfiguration? config,
    this.startXFraction = 0.8,
    this.startYFraction = 0.5,
    this.endXFraction = 0.2,
    this.endYFraction = 0.5,
    this.startXOffset = 0.0,
    this.startYOffset = 0.0,
    this.endXOffset = 0.0,
    this.endYOffset = 0.0,
  }) : config = config ?? const ArrowConfiguration();

  @override
  void paint(Canvas canvas, Size size) {
    final startBox = startKey.currentContext?.findRenderObject() as RenderBox?;
    final endBox = endKey.currentContext?.findRenderObject() as RenderBox?;
    final stackBox = context.findRenderObject() as RenderBox?;

    if (startBox == null || endBox == null || stackBox == null) return;

    final startGlobalPos = startBox.localToGlobal(Offset.zero);
    final endGlobalPos = endBox.localToGlobal(Offset.zero);

    final startLocalPos = stackBox.globalToLocal(startGlobalPos);
    final endLocalPos = stackBox.globalToLocal(endGlobalPos);

    final startPoint = Offset(
      startLocalPos.dx + (startBox.size.width * startXFraction) + startXOffset,
      startLocalPos.dy + (startBox.size.height * startYFraction) + startYOffset,
    );

    final endPoint = Offset(
      endLocalPos.dx + (endBox.size.width * endXFraction) + endXOffset,
      endLocalPos.dy + (endBox.size.height * endYFraction) + endYOffset,
    );

    final arrowPainter = CustomizableArrowPainter(
      startPoint: startPoint,
      endPoint: endPoint,
      config: config,
    );

    arrowPainter.paint(canvas, size);
  }

  @override
  bool shouldRepaint(WidgetConnectorPainter oldDelegate) => true;
}

/// Extension to make widgets arrow-connectable
extension ArrowConnectable on Widget {
  /// Wrap this widget with a GlobalKey for arrow connection
  Widget withArrowKey(GlobalKey key) {
    return KeyedSubtree(key: key, child: this);
  }
}
