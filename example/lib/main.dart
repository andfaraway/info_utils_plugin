import 'package:flutter/material.dart';
import 'package:info_utils_plugin/info_utils_plugin.dart';

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
    test();
  }

  test() async{
    final s = await plugin.getDeviceInfo();
    data = s.toJson();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
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
