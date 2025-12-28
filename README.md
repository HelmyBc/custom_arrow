# Custom Arrow

[![pub package](https://img.shields.io/pub/v/custom_arrow.svg)](https://pub.dev/packages/custom_arrow)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A highly customizable Flutter package for drawing beautiful arrows between widgets. Perfect for creating onboarding flows, tutorials, flowcharts, process diagrams, and any UI that needs visual connections between elements.

## Features

✨ **Easy Widget Connection** - Connect any two widgets with a single widget
🎨 **Multiple Curve Styles** - Straight, smooth, S-curve, arc, and reversed arc
⚡ **Highly Customizable** - Control every aspect of arrow appearance
📍 **Smart Anchoring** - 9 predefined anchor positions + custom positioning
🎯 **Dotted or Solid** - Toggle between line styles with custom dash patterns
🔧 **Fine-tuning** - Pixel-perfect positioning with offset controls
🎭 **Custom Bezier Curves** - Define your own curve with control points

## Preview

![alt text](ScreenRecording2025-12-28at10.52.06PM-ezgif.com-crop.gif)

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  custom_arrow: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:custom_arrow/custom_arrow.dart';

class MyWidget extends StatelessWidget {
  final step1Key = GlobalKey();
  final step2Key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Your widgets
        Positioned(
          left: 50,
          top: 100,
          child: Container(
            key: step1Key,
            width: 100,
            height: 50,
            color: Colors.blue,
            child: Text('Step 1'),
          ),
        ),
        Positioned(
          left: 250,
          top: 300,
          child: Container(
            key: step2Key,
            width: 100,
            height: 50,
            color: Colors.green,
            child: Text('Step 2'),
          ),
        ),

        // Draw arrow between widgets
        ArrowConnector(
          startKey: step1Key,
          endKey: step2Key,
        ),
      ],
    );
  }
}
```

## Configuration Options

### ArrowConfiguration

All arrow appearance settings are controlled through `ArrowConfiguration`:

```dart
ArrowConnector(
  startKey: step1Key,
  endKey: step2Key,
  config: ArrowConfiguration(
    // Line style
    isDotted: true,              // Dotted or solid line
    dashLength: 8.0,             // Length of each dash
    dashGap: 6.0,                // Space between dashes
    thickness: 2.0,              // Line thickness

    // Color
    color: Colors.blue,          // Arrow color

    // Arrowhead
    showArrowhead: true,         // Show/hide arrowhead
    arrowheadSize: 12.0,         // Size of arrowhead
    arrowheadAngle: 25.0,        // Angle of arrowhead (degrees)

    // Curve
    curveStyle: ArrowCurveStyle.sCurve,  // Curve type
    curveIntensity: 0.5,         // 0.0 to 1.0

    // Advanced
    strokeCap: StrokeCap.round,  // Line end style
  ),
)
```

### Curve Styles

```dart
// Straight line
ArrowCurveStyle.straight

// Simple smooth curve
ArrowCurveStyle.smooth

// S-shaped curve
ArrowCurveStyle.sCurve

// Arc curve
ArrowCurveStyle.arc

// Reversed arc curve
ArrowCurveStyle.reversedArc
```

### Anchor Positions

Control where arrows connect to widgets:

```dart
ArrowConnector(
  startKey: step1Key,
  endKey: step2Key,
  startAnchor: AnchorPosition.centerRight,  // Start from right center
  endAnchor: AnchorPosition.centerLeft,     // End at left center
)
```

Available positions:

- `topLeft`, `topCenter`, `topRight`
- `centerLeft`, `center`, `centerRight`
- `bottomLeft`, `bottomCenter`, `bottomRight`
- `custom` - Use custom fractions

### Custom Positioning

For precise control, use custom fractions (0.0 to 1.0):

```dart
ArrowConnector(
  startKey: step1Key,
  endKey: step2Key,
  startAnchor: AnchorPosition.custom,
  endAnchor: AnchorPosition.custom,
  startXFraction: 0.8,  // 80% from left edge
  startYFraction: 0.3,  // 30% from top edge
  endXFraction: 0.2,    // 20% from left edge
  endYFraction: 0.7,    // 70% from top edge
)
```

### Fine-tuning with Offsets

Add pixel offsets for perfect alignment:

```dart
ArrowConnector(
  startKey: step1Key,
  endKey: step2Key,
  startXOffset: 10,   // 10 pixels right
  startYOffset: -5,   // 5 pixels up
  endXOffset: -10,    // 10 pixels left
  endYOffset: 5,      // 5 pixels down
)
```

## Advanced Examples

### Dotted S-Curve Arrow

```dart
ArrowConnector(
  startKey: widget1Key,
  endKey: widget2Key,
  config: ArrowConfiguration(
    isDotted: true,
    dashLength: 10,
    dashGap: 5,
    curveStyle: ArrowCurveStyle.sCurve,
    curveIntensity: 0.7,
    color: Colors.purple,
    thickness: 3,
  ),
  startAnchor: AnchorPosition.bottomCenter,
  endAnchor: AnchorPosition.topCenter,
)
```

### Solid Arc with Custom Arrowhead

```dart
ArrowConnector(
  startKey: widget1Key,
  endKey: widget2Key,
  config: ArrowConfiguration(
    isDotted: false,
    curveStyle: ArrowCurveStyle.arc,
    curveIntensity: 0.8,
    color: Colors.red,
    thickness: 4,
    arrowheadSize: 16,
    arrowheadAngle: 30,
  ),
)
```

### Custom Bezier Curve

Define your own curve with control points:

```dart
ArrowConnector(
  startKey: widget1Key,
  endKey: widget2Key,
  config: ArrowConfiguration(
    customControlPoints: [
      Offset(0.3, 0.8),  // First control point
      Offset(0.7, 0.2),  // Second control point
    ],
    color: Colors.blue,
  ),
)
```

### Drawing Direct Arrows (Without Widget Keys)

Use `CustomArrow` for drawing arrows at specific coordinates:

```dart
Stack(
  children: [
    CustomArrow(
      startPoint: Offset(50, 100),
      endPoint: Offset(200, 300),
      config: ArrowConfiguration(
        isDotted: true,
        curveStyle: ArrowCurveStyle.smooth,
      ),
    ),
  ],
)
```

## Use Cases

- 📚 **Onboarding Tutorials** - Guide users through your app
- 📊 **Flowcharts** - Visualize processes and workflows
- 🎓 **Educational Apps** - Show relationships between concepts
- 🎮 **Game UI** - Connect game elements
- 📋 **Process Diagrams** - Display step-by-step procedures
- 🔄 **State Visualizations** - Show state transitions

## Tips & Best Practices

1. **Always use Stack** - Place `ArrowConnector` in a `Stack` widget above the widgets you want to connect
2. **GlobalKeys are required** - Assign `GlobalKey` to widgets you want to connect
3. **Adjust curve intensity** - Start with 0.5 and adjust based on distance between widgets
4. **Use anchors wisely** - Choose anchors that make visual sense (e.g., right to left for left-to-right flow)
5. **Fine-tune with offsets** - Use pixel offsets for final adjustments

## Example App

Check out the [example](example/) directory for a complete working app with multiple arrow styles and configurations.

To run the example:

```bash
cd example
flutter run
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Issues

If you encounter any issues or have suggestions, please [file an issue](https://github.com/yourusername/custom_arrow/issues).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

**Your Name**

- GitHub: [@HelmyBc](https://github.com/HelmyBc)
- Email: helmibouchiha@gmail.com

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes.

---

Made with ❤️ for the Flutter community
