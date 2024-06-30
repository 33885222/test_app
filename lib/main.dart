import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wireguard_flutter/wireguard_flutter.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WireGuard Example App'),
        ),
        body: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final wireguard = WireGuardFlutter.instance;

  late String name;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          TextButton(
            onPressed: initialize,
            style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(100, 50)),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.fromLTRB(20, 15, 20, 15)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueAccent),
                overlayColor: MaterialStateProperty.all<Color>(
                    Colors.white.withOpacity(0.1))),
            child: const Text(
              'initialize',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: startVpn,
            style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(100, 50)),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.fromLTRB(20, 15, 20, 15)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueAccent),
                overlayColor: MaterialStateProperty.all<Color>(
                    Colors.white.withOpacity(0.1))),
            child: const Text(
              'Connect',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: disconnect,
            style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(100, 50)),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.fromLTRB(20, 15, 20, 15)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueAccent),
                overlayColor: MaterialStateProperty.all<Color>(
                    Colors.white.withOpacity(0.1))),
            child: const Text(
              'Disconnect',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: getStatus,
            style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(100, 50)),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.fromLTRB(20, 15, 20, 15)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueAccent),
                overlayColor: MaterialStateProperty.all<Color>(
                    Colors.white.withOpacity(0.1))),
            child: const Text(
              'Get status',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
