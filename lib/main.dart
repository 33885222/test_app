import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wireguard_flutter/wireguard_flutter.dart';

void main() {
  runApp(const TotoVPNApp());
}

class TotoVPNApp extends StatelessWidget {
  const TotoVPNApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TotoVPN',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final wireguard = WireGuardFlutter.instance;
  late String name;

  @override
  void initState() {
    super.initState();
    wireguard.vpnStageSnapshot.listen((event) {
      // debugPrint("status changed $event");
      showMsg("status changed $event");
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('status changed: $event'),
        ));
      }
    });
    name = 'my_wg_vpn';
  }

  Future<void> initialize() async {
    try {
      await wireguard.initialize(interfaceName: name);
      debugPrint("initialize success $name");
      startVpn();
    } catch (error, stack) {
      debugPrint("failed to initialize: $error\n$stack");
    }
  }

  void startVpn() async {
    try {
      await wireguard.startVpn(
        serverAddress: '95.179.141.28:51820',
        wgQuickConfig: conf,
        providerBundleIdentifier: 'com.billion.wireguardvpn.WGExtension',
      );
    } catch (error, stack) {
      debugPrint("failed to start $error\n$stack");
    }
  }

  void disconnect() async {
    try {
      await wireguard.stopVpn();
    } catch (e, str) {
      debugPrint('Failed to disconnect $e\n$str');
    }
  }

  void getStatus() async {
    debugPrint("getting stage");
    final stage = await wireguard.stage();
    debugPrint("stage: $stage");

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('stage: $stage'),
      ));
    }
  }

  int _counter = 0;

  void showMsg(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Counter: $text'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _goToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TotoVPN'),
        leading: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: _goToSettings,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_counter'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: initialize,
              child: const Text('Увеличить'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Text('Настройки'),
      ),
    );
  }
}

const String conf = '''[Interface]
PrivateKey = MBP/u0nHEnikh/d4VBMlbYT48ZM4Xr7RvksoMHisVVU=
Address = 10.8.0.8/24
DNS = 1.1.1.1

[Peer]
PublicKey = Hc1PhSB+n6p4xfB7N/s1epzkav7iACBqujYwjNk7Xiw=
PresharedKey = jHK4KSxzHg6PRssot8EMjxbdw8tW9wfQh3Zb3jH4lR4=
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = 95.179.141.28:51820''';
