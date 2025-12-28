import 'package:flutter/material.dart';
import 'package:custom_arrow/custom_arrow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Arrow Examples',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  int _selectedExample = 0;

  final List<Map<String, dynamic>> _examples = [
    {
      'title': 'Recipe Flow',
      'icon': Icons.restaurant,
      'widget': const RecipeFlowExample(),
    },
    {
      'title': 'Decision Tree',
      'icon': Icons.account_tree,
      'widget': const DecisionTreeExample(),
    },
    {
      'title': 'Game Level Path',
      'icon': Icons.games,
      'widget': const GameLevelExample(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_examples[_selectedExample]['title']),
        elevation: 2,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.arrow_forward, size: 48, color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    'Custom Arrow',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Creative Examples',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ..._examples.asMap().entries.map((entry) {
              final index = entry.key;
              final example = entry.value;
              return ListTile(
                leading: Icon(example['icon']),
                title: Text(example['title']),
                selected: _selectedExample == index,
                onTap: () {
                  setState(() => _selectedExample = index);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
      body: _examples[_selectedExample]['widget'],
    );
  }
}

// Example 1: Recipe Cooking Flow
class RecipeFlowExample extends StatelessWidget {
  const RecipeFlowExample({super.key});

  @override
  Widget build(BuildContext context) {
    final step1Key = GlobalKey();
    final step2Key = GlobalKey();
    final step3Key = GlobalKey();
    final step4Key = GlobalKey();
    final step5Key = GlobalKey();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange.shade50, Colors.red.shade50],
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // Title
            const Positioned(
              top: 20,
              left: 20,
              child: Text(
                '🍝 Pasta Recipe Flow',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            // Steps
            Positioned(
              left: 20,
              top: 200,
              child: _RecipeStep(
                  step1Key, '1', 'Boil Water', Icons.water_drop, Colors.blue),
            ),
            Positioned(
              left: 200,
              top: 80,
              child: _RecipeStep(
                  step2Key, '2', 'Add Pasta', Icons.dining, Colors.orange),
            ),
            Positioned(
              right: 20,
              top: 220,
              child: _RecipeStep(
                  step3Key, '3', 'Cook 10min', Icons.timer, Colors.green),
            ),
            Positioned(
              right: 120,
              bottom: 250,
              child: _RecipeStep(
                  step4Key, '4', 'Drain Water', Icons.water, Colors.cyan),
            ),
            Positioned(
              left: 60,
              bottom: 140,
              child: _RecipeStep(
                  step5Key, '5', 'Serve Hot!', Icons.restaurant, Colors.red),
            ),

            // Arrows
            ArrowConnector(
              startKey: step1Key,
              endKey: step2Key,
              config: const ArrowConfiguration(
                isDotted: true,
                curveStyle: ArrowCurveStyle.smooth,
                color: Colors.blue,
                thickness: 3,
                dashLength: 10,
              ),
              startAnchor: AnchorPosition.centerRight,
              endAnchor: AnchorPosition.centerLeft,
            ),
            ArrowConnector(
              startKey: step2Key,
              endKey: step3Key,
              config: const ArrowConfiguration(
                isDotted: false,
                curveStyle: ArrowCurveStyle.sCurve,
                color: Colors.orange,
                thickness: 3,
                curveIntensity: 0.6,
              ),
              startAnchor: AnchorPosition.centerRight,
              endAnchor: AnchorPosition.topLeft,
            ),
            ArrowConnector(
              startKey: step3Key,
              endKey: step4Key,
              config: const ArrowConfiguration(
                isDotted: true,
                curveStyle: ArrowCurveStyle.arc,
                color: Colors.green,
                thickness: 3,
              ),
              startAnchor: AnchorPosition.bottomCenter,
              endAnchor: AnchorPosition.topCenter,
            ),
            ArrowConnector(
              startKey: step4Key,
              endKey: step5Key,
              config: const ArrowConfiguration(
                isDotted: false,
                curveStyle: ArrowCurveStyle.reversedArc,
                color: Colors.cyan,
                thickness: 3,
                curveIntensity: 0.7,
              ),
              startAnchor: AnchorPosition.centerLeft,
              endAnchor: AnchorPosition.centerRight,
            ),
          ],
        ),
      ),
    );
  }
}

class _RecipeStep extends StatelessWidget {
  final GlobalKey stepKey;
  final String number;
  final String text;
  final IconData icon;
  final Color color;

  const _RecipeStep(
      this.stepKey, this.number, this.text, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: stepKey,
      width: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha((0.3 * 255).round()),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Text(number,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 8),
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 4),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}

// Example 2: Decision Tree
class DecisionTreeExample extends StatelessWidget {
  const DecisionTreeExample({super.key});

  @override
  Widget build(BuildContext context) {
    final startKey = GlobalKey();
    final yesKey = GlobalKey();
    final noKey = GlobalKey();
    final yes2Key = GlobalKey();
    final no2Key = GlobalKey();
    final resultKey = GlobalKey();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.purple.shade50, Colors.blue.shade50],
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            const Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  '🤔 Should I Go Out?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Positioned(
              top: 80,
              left: 0,
              right: 0,
              child: Center(
                child: _DecisionNode(startKey, 'Is it\nraining?', Colors.blue),
              ),
            ),
            Positioned(
              top: 200,
              left: 80,
              child:
                  _DecisionNode(yesKey, 'Do I have\numbrella?', Colors.orange),
            ),
            Positioned(
              top: 200,
              right: 80,
              child: _DecisionNode(noKey, 'Is it\ncold?', Colors.green),
            ),
            Positioned(
              top: 340,
              left: 10,
              child: _ResultNode(yes2Key, 'Go with\numbrella ☂️', Colors.teal),
            ),
            Positioned(
              top: 340,
              left: 160,
              child: _ResultNode(no2Key, 'Stay\nhome 🏠', Colors.red),
            ),
            Positioned(
              top: 340,
              right: 80,
              child: _ResultNode(resultKey, 'Go\noutside! 🌞', Colors.purple),
            ),

            // Arrows
            ArrowConnector(
              startKey: startKey,
              endKey: yesKey,
              config: const ArrowConfiguration(
                curveStyle: ArrowCurveStyle.arc,
                color: Colors.blue,
                thickness: 3,
              ),
              startAnchor: AnchorPosition.centerLeft,
              endAnchor: AnchorPosition.topCenter,
            ),
            ArrowConnector(
              startKey: startKey,
              endKey: noKey,
              config: const ArrowConfiguration(
                curveStyle: ArrowCurveStyle.reversedArc,
                color: Colors.green,
                thickness: 3,
              ),
              startAnchor: AnchorPosition.centerRight,
              endAnchor: AnchorPosition.topCenter,
            ),
            ArrowConnector(
              startKey: yesKey,
              endKey: yes2Key,
              config: const ArrowConfiguration(
                curveStyle: ArrowCurveStyle.arc,
                color: Colors.teal,
                thickness: 2.5,
              ),
              startAnchor: AnchorPosition.bottomLeft,
              endAnchor: AnchorPosition.topCenter,
            ),
            ArrowConnector(
              startKey: yesKey,
              endKey: no2Key,
              config: const ArrowConfiguration(
                curveStyle: ArrowCurveStyle.reversedArc,
                color: Colors.red,
                thickness: 2.5,
              ),
              startAnchor: AnchorPosition.bottomRight,
              endAnchor: AnchorPosition.topCenter,
            ),
            ArrowConnector(
              startKey: noKey,
              endKey: resultKey,
              config: const ArrowConfiguration(
                curveStyle: ArrowCurveStyle.straight,
                color: Colors.purple,
                thickness: 2.5,
              ),
              startAnchor: AnchorPosition.bottomCenter,
              endAnchor: AnchorPosition.topCenter,
            ),

            // Labels
            const Positioned(
                top: 150,
                left: 100,
                child:
                    Text('Yes', style: TextStyle(fontWeight: FontWeight.bold))),
            const Positioned(
                top: 150,
                right: 100,
                child:
                    Text('No', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }
}

class _DecisionNode extends StatelessWidget {
  final GlobalKey nodeKey;
  final String text;
  final Color color;

  const _DecisionNode(this.nodeKey, this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: nodeKey,
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 3),
        boxShadow: [
          BoxShadow(color: color.withAlpha((0.3 * 255).round()), blurRadius: 12)
        ],
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
      ),
    );
  }
}

class _ResultNode extends StatelessWidget {
  final GlobalKey nodeKey;
  final String text;
  final Color color;

  const _ResultNode(this.nodeKey, this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: nodeKey,
      width: 90,
      height: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(35),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}

// Example 3: Game Level Path
class GameLevelExample extends StatelessWidget {
  const GameLevelExample({super.key});

  @override
  Widget build(BuildContext context) {
    final level1Key = GlobalKey();
    final level2Key = GlobalKey();
    final level3Key = GlobalKey();
    final level4Key = GlobalKey();
    final bossKey = GlobalKey();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1a1a2e), Color(0xFF16213e), Color(0xFF0f3460)],
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '🎮 Adventure Path',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),

          Positioned(
            bottom: 100,
            left: 40,
            child: _GameLevel(level1Key, '1', '⚔️', Colors.green, true),
          ),
          Positioned(
            bottom: 400,
            left: 120,
            child: _GameLevel(level2Key, '2', '🛡️', Colors.blue, true),
          ),
          Positioned(
            top: 180,
            right: 50,
            child: _GameLevel(level3Key, '3', '🏹', Colors.orange, false),
          ),
          Positioned(
            bottom: 200,
            right: 200,
            child: _GameLevel(level4Key, '4', '⚡', Colors.purple, false),
          ),
          Positioned(
            top: 80,
            left: 20,
            // right: 0,
            child: Center(
              child: _GameLevel(bossKey, '👑', '🐉', Colors.red, false),
            ),
          ),

          // Arrows with different styles
          ArrowConnector(
            startKey: level1Key,
            endKey: level2Key,
            config: const ArrowConfiguration(
              isDotted: false,
              curveStyle: ArrowCurveStyle.reversedArc,
              color: Colors.greenAccent,
              thickness: 4,
              curveIntensity: 0.5,
            ),
            startAnchor: AnchorPosition.topCenter,
            endAnchor: AnchorPosition.centerLeft,
          ),
          ArrowConnector(
            startKey: level2Key,
            endKey: level3Key,
            config: const ArrowConfiguration(
              isDotted: true,
              curveStyle: ArrowCurveStyle.sCurve,
              color: Colors.blueAccent,
              thickness: 4,
              dashLength: 12,
            ),
            startAnchor: AnchorPosition.centerRight,
            endAnchor: AnchorPosition.centerLeft,
          ),
          ArrowConnector(
            startKey: level3Key,
            endKey: level4Key,
            config: const ArrowConfiguration(
              isDotted: false,
              curveStyle: ArrowCurveStyle.reversedArc,
              color: Colors.orangeAccent,
              thickness: 4,
              curveIntensity: 0.6,
            ),
            startAnchor: AnchorPosition.bottomRight,
            endAnchor: AnchorPosition.topRight,
          ),
          ArrowConnector(
            startKey: level4Key,
            endKey: bossKey,
            config: const ArrowConfiguration(
              isDotted: false,
              curveStyle: ArrowCurveStyle.sCurve,
              color: Colors.purpleAccent,
              thickness: 4,
              curveIntensity: 0.8,
            ),
            startAnchor: AnchorPosition.topLeft,
            endAnchor: AnchorPosition.bottomCenter,
          ),
        ],
      ),
    );
  }
}

class _GameLevel extends StatelessWidget {
  final GlobalKey levelKey;
  final String number;
  final String emoji;
  final Color color;
  final bool completed;

  const _GameLevel(
      this.levelKey, this.number, this.emoji, this.color, this.completed);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: levelKey,
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: completed ? color : Colors.grey.shade800,
        shape: BoxShape.circle,
        border: Border.all(
          color: completed ? color.withAlpha((0.5 * 255).round()) : Colors.grey,
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: completed
                ? color.withAlpha((0.5 * 255).round())
                : Colors.black38,
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          if (number != '👑')
            Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }
}
