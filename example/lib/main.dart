import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_core_spotlight/flutter_core_spotlight.dart';
import 'package:flutter_native_alert/flutter_native_alert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _textController = TextEditingController();

  @override
  void initState() {
    FlutterCoreSpotlight.instance.configure(
      onSearchableItemSelected: (userActivity) {
        print(userActivity);
        FlutterNativeAlert.getInstance().showConfirm(
          title: userActivity?.uniqueIdentifier ?? 'Unknown title',
          message: jsonEncode(userActivity?.userInfo ?? {}),
          confirmButtonText: 'OK',
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _textController,
                autocorrect: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                child: Text('Index'),
                onPressed: () {
                  FlutterCoreSpotlight.instance.indexSearchableItems([
                    FlutterSpotlightItem(
                      uniqueIdentifier: _textController.text,
                      domainIdentifier: 'com.example.flutter_spotlight_plugin',
                      attributeTitle: _textController.text,
                      attributeDescription: 'This is an example description',
                    )
                  ]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
