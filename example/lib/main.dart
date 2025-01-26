import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:info_utils_plugin/info_utils_plugin.dart';
import 'package:info_utils_plugin/location_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final InfoUtilsPlugin plugin = InfoUtilsPlugin();

  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();

    plugin.getDeviceInfo().then((value) {
      data.addAll(value);
      setState(() {});
    });
    plugin.getLocation().then((value) {
      data.addAll(value);
      setState(() {});
    });
  }

  test()async{
    // print(await plugin.getLocation());
  }

  @override
  Widget build(BuildContext context) {
    test();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Info Plugin'),
        ),
        body: Center(
          child: Text('$data'),
        ),
      ),
    );
  }
}
