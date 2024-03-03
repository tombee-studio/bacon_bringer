import 'package:bacon_bringer/data/loading_data.dart';
import 'package:flutter/material.dart';

class LoadingComponent extends StatelessWidget {
  final LoadingData loadingData;

  const LoadingComponent({super.key, required this.loadingData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        height: 200,
        child: Column(children: [
          const CircularProgressIndicator(),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(loadingData.message))
        ]));
  }
}
