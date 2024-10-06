import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CachedPage extends StatefulWidget {
  const CachedPage({super.key});

  @override
  State<CachedPage> createState() => _CachedPageState();
}

class _CachedPageState extends State<CachedPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text("This is where cached data will go"),
        ],
      ),
    );
  }
}
