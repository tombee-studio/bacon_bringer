import 'package:bacon_bringer/bases/notifier.dart';
import 'package:flutter/material.dart';

const beforeTrasitionText = "遷移前の画面";

class TestNotifier implements Notifier {
  Function? testCallback;
  TestNotifier({this.testCallback});

  @override
  void notify() {}
}

class TestSkeletonWidget extends StatelessWidget {
  final Function builder;
  const TestSkeletonWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: builder(context)));
  }
}
