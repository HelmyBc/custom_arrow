/// This file contains enumerations used in the custom arrow implementation.
///
/// The `ArrowCurveStyle` enum defines various styles for the curvature of arrows.
/// It allows developers to choose how the arrow should visually appear in the application.
///
/// The available styles are:
/// - `straight`: Represents a direct line from the start to the end point of the arrow.
/// - `smooth`: Indicates a gently curved arrow, providing a more organic look.
/// - `sCurve`: Represents an 'S' shaped curve, which can be useful for indicating flow or direction.
/// - `arc`: A semi-circular curve that can be used for a more pronounced bend in the arrow.
/// - `reversedArc`: Similar to the `arc`, but curves in the opposite direction, allowing for versatile design options.
///
/// The `AnchorPosition` enum defines various anchor positions for widgets in the UI.
/// This is particularly useful for positioning elements relative to each other or to the screen.
///
/// The available positions are:
/// - `topLeft`: Anchors the widget to the top-left corner of its parent.
/// - `topCenter`: Centers the widget horizontally at the top of its parent.
/// - `topRight`: Anchors the widget to the top-right corner of its parent.
/// - `centerLeft`: Centers the widget vertically on the left side of its parent.
/// - `center`: Centers the widget both vertically and horizontally within its parent.
/// - `centerRight`: Centers the widget vertically on the right side of its parent.
/// - `bottomLeft`: Anchors the widget to the bottom-left corner of its parent.
/// - `bottomCenter`: Centers the widget horizontally at the bottom of its parent.
/// - `bottomRight`: Anchors the widget to the bottom-right corner of its parent.
/// - `custom`: Allows for a user-defined position, providing flexibility for advanced layouts.
enum ArrowCurveStyle {
  /// Represents a direct line from the start to the end point of the arrow.
  straight,

  /// Indicates a gently curved arrow, providing a more organic look.
  smooth,

  /// Represents an 'S' shaped curve, which can be useful for indicating flow or direction.
  sCurve,

  /// A semi-circular curve that can be used for a more pronounced bend in the arrow.
  arc,

  /// Similar to the `arc`, but curves in the opposite direction, allowing for versatile design options.
  reversedArc,
}

/// An enumeration that defines various anchor positions for a widget within its parent.
///
/// Each value represents a specific alignment or position where the widget can be anchored:
///
/// - [topLeft]: Anchors the widget to the top-left corner of its parent.
/// - [topCenter]: Centers the widget horizontally at the top of its parent.
/// - [topRight]: Anchors the widget to the top-right corner of its parent.
/// - [centerLeft]: Centers the widget vertically on the left side of its parent.
/// - [center]: Centers the widget both vertically and horizontally within its parent.
/// - [centerRight]: Centers the widget vertically on the right side of its parent.
/// - [bottomLeft]: Anchors the widget to the bottom-left corner of its parent.
/// - [bottomCenter]: Centers the widget horizontally at the bottom of its parent.
/// - [bottomRight]: Anchors the widget to the bottom-right corner of its parent.
/// - [custom]: Allows for a user-defined position, providing flexibility for advanced layouts.
enum AnchorPosition {
  /// Anchors the widget to the top-left corner of its parent.
  topLeft,

  /// Centers the widget horizontally at the top of its parent.
  topCenter,

  /// Anchors the widget to the top-right corner of its parent.
  topRight,

  /// Centers the widget vertically on the left side of its parent.
  centerLeft,

  /// Centers the widget both vertically and horizontally within its parent.
  center,

  /// Centers the widget vertically on the right side of its parent.
  centerRight,

  /// Anchors the widget to the bottom-left corner of its parent.
  bottomLeft,

  /// Centers the widget horizontally at the bottom of its parent.
  bottomCenter,

  /// Anchors the widget to the bottom-right corner of its parent.
  bottomRight,

  /// Allows for a user-defined position, providing flexibility for advanced layouts.
  custom,
}
