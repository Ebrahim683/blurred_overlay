import 'package:blurred_overlay/blurred_overlay.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      drawer: BlurredDrawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.blur_on,
                    size: 48,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Blurred Drawer',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(
                Icons.phone_android_rounded,
                color: Colors.blueAccent,
              ),
              title: const Text('System'),
              subtitle: const Text('Device, OS, and build information'),
              onTap: () {
                showBottomSheetDialog(context);
              },
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
            ListTile(
              leading: Icon(
                Icons.room_preferences_outlined,
                color: Colors.redAccent[400],
              ),
              title: const Text('Root Status'),
              onTap: () {
                showRootStatusDialog(context);
              },
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.wifi, color: Colors.greenAccent[400]),
              title: const Text('Network & internet'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.bluetooth, color: Colors.lightBlueAccent),
              title: const Text('Connected devices'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.orangeAccent),
              title: const Text('Notifications'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  void showBottomSheetDialog(BuildContext context) {
    showBlurredModalBottomSheet(
      context: context,
      showHandle: true,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'System Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(color: Colors.white24, indent: 20, endIndent: 20),
            const InfoRow(
              icon: Icons.devices,
              label: 'Device Name',
              value: 'Galaxy A50',
            ),
            const InfoRow(
              icon: Icons.developer_board,
              label: 'Model',
              value: 'Flutter G-24',
            ),
            const InfoRow(icon: Icons.memory, label: 'RAM', value: '12 GB'),
            const InfoRow(
              icon: Icons.sd_storage,
              label: 'ROM',
              value: '256 GB',
            ),
            const InfoRow(
              icon: Icons.memory_rounded,
              label: 'Chipset',
              value: 'Tensor G4 Pro',
            ),
            const InfoRow(
              icon: Icons.android,
              label: 'OS Version',
              value: 'Android 15 (Vanilla)',
            ),
          ],
        );
      },
    );
  }

  void showRootStatusDialog(BuildContext context) {
    showBlurredDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Root Status',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Your phone Galaxy A50 is not rooted.',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 24.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('CLOSE'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 15),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
          Expanded(
            flex: 1,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
