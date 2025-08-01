import 'package:flutter/material.dart';
import 'package:blurred_overlay/blurred_overlay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blurred Overlay Demo',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatelessWidget {
  const DemoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blurred Overlay Example')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                showBlurredDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Blurred Dialog"),
                    content: const Text("This is a blurred alert dialog."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Close"),
                      )
                    ],
                  ),
                );
              },
              child: const Text("Show Blurred Dialog"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showBlurredModalBottomSheet(
                  context: context,
                  builder: (_) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(height: 15),
                      Text("Blurred Modal Bottom Sheet"),
                      SizedBox(height: 15),
                    ],
                  ),
                );
              },
              child: const Text("Show Blurred Bottom Sheet"),
            ),
          ],
        ),
      ),
    );
  }
}
