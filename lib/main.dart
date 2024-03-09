import 'package:bacon_bringer/ui/home/view/page/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BaconBringerApp());
}

class BaconBringerApp extends StatelessWidget {
  const BaconBringerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bacon Bringer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Bacon Bringer'),
    );
  }
}
