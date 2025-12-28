import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:custom_arrow/custom_arrow.dart';

void main() {
  group('ArrowConfiguration', () {
    test('creates with default values', () {
      const config = ArrowConfiguration();

      expect(config.isDotted, true);
      expect(config.dashLength, 8.0);
      expect(config.dashGap, 6.0);
      expect(config.thickness, 2.0);
      expect(config.color, const Color(0xFF94A3B8));
      expect(config.arrowheadSize, 12.0);
      expect(config.arrowheadAngle, 25.0);
      expect(config.showArrowhead, true);
      expect(config.curveStyle, ArrowCurveStyle.sCurve);
      expect(config.curveIntensity, 0.5);
    });

    test('creates with custom values', () {
      const config = ArrowConfiguration(
        isDotted: false,
        thickness: 3.0,
        color: Colors.blue,
        curveStyle: ArrowCurveStyle.straight,
      );

      expect(config.isDotted, false);
      expect(config.thickness, 3.0);
      expect(config.color, Colors.blue);
      expect(config.curveStyle, ArrowCurveStyle.straight);
    });

    test('copyWith works correctly', () {
      const config = ArrowConfiguration();
      final copied = config.copyWith(
        isDotted: false,
        color: Colors.red,
      );

      expect(copied.isDotted, false);
      expect(copied.color, Colors.red);
      expect(copied.thickness, 2.0); // Unchanged
    });
  });

  group('ArrowCurveStyle', () {
    test('has all expected values', () {
      expect(ArrowCurveStyle.values.length, 5);
      expect(ArrowCurveStyle.values.contains(ArrowCurveStyle.straight), true);
      expect(ArrowCurveStyle.values.contains(ArrowCurveStyle.smooth), true);
      expect(ArrowCurveStyle.values.contains(ArrowCurveStyle.sCurve), true);
      expect(ArrowCurveStyle.values.contains(ArrowCurveStyle.arc), true);
      expect(
          ArrowCurveStyle.values.contains(ArrowCurveStyle.reversedArc), true);
    });
  });

  group('AnchorPosition', () {
    test('has all expected values', () {
      expect(AnchorPosition.values.length, 10);
      expect(AnchorPosition.values.contains(AnchorPosition.topLeft), true);
      expect(AnchorPosition.values.contains(AnchorPosition.center), true);
      expect(AnchorPosition.values.contains(AnchorPosition.bottomRight), true);
      expect(AnchorPosition.values.contains(AnchorPosition.custom), true);
    });
  });

  group('CustomArrow Widget', () {
    testWidgets('renders without error', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomArrow(
              startPoint: Offset(50, 50),
              endPoint: Offset(200, 200),
            ),
          ),
        ),
      );

      expect(find.byType(CustomArrow), findsOneWidget);
    });

    testWidgets('renders with custom configuration',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomArrow(
              startPoint: Offset(50, 50),
              endPoint: Offset(200, 200),
              config: ArrowConfiguration(
                isDotted: false,
                color: Colors.red,
                thickness: 3.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomArrow), findsOneWidget);
    });
  });

  group('ArrowConnector Widget', () {
    testWidgets('renders with GlobalKeys', (WidgetTester tester) async {
      final startKey = GlobalKey();
      final endKey = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                Positioned(
                  left: 50,
                  top: 50,
                  child: Container(
                    key: startKey,
                    width: 100,
                    height: 50,
                    color: Colors.blue,
                  ),
                ),
                Positioned(
                  left: 200,
                  top: 200,
                  child: Container(
                    key: endKey,
                    width: 100,
                    height: 50,
                    color: Colors.green,
                  ),
                ),
                ArrowConnector(
                  startKey: startKey,
                  endKey: endKey,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(ArrowConnector), findsOneWidget);
    });

    testWidgets('renders with custom anchors', (WidgetTester tester) async {
      final startKey = GlobalKey();
      final endKey = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                Positioned(
                  left: 50,
                  top: 50,
                  child: Container(
                    key: startKey,
                    width: 100,
                    height: 50,
                    color: Colors.blue,
                  ),
                ),
                Positioned(
                  left: 200,
                  top: 200,
                  child: Container(
                    key: endKey,
                    width: 100,
                    height: 50,
                    color: Colors.green,
                  ),
                ),
                ArrowConnector(
                  startKey: startKey,
                  endKey: endKey,
                  startAnchor: AnchorPosition.bottomCenter,
                  endAnchor: AnchorPosition.topCenter,
                  config: const ArrowConfiguration(
                    curveStyle: ArrowCurveStyle.straight,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(ArrowConnector), findsOneWidget);
    });
  });

  group('ArrowConnectable Extension', () {
    testWidgets('withArrowKey extension works', (WidgetTester tester) async {
      final key = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              color: Colors.blue,
            ).withArrowKey(key),
          ),
        ),
      );

      expect(find.byKey(key), findsOneWidget);
    });
  });

  group('CustomizableArrowPainter', () {
    test('creates painter with required parameters', () {
      final painter = CustomizableArrowPainter(
        startPoint: const Offset(0, 0),
        endPoint: const Offset(100, 100),
        config: const ArrowConfiguration(),
      );

      expect(painter.startPoint, const Offset(0, 0));
      expect(painter.endPoint, const Offset(100, 100));
    });

    test('shouldRepaint returns true when points change', () {
      final painter1 = CustomizableArrowPainter(
        startPoint: const Offset(0, 0),
        endPoint: const Offset(100, 100),
        config: const ArrowConfiguration(),
      );

      final painter2 = CustomizableArrowPainter(
        startPoint: const Offset(0, 0),
        endPoint: const Offset(200, 200),
        config: const ArrowConfiguration(),
      );

      expect(painter1.shouldRepaint(painter2), true);
    });
  });
}
