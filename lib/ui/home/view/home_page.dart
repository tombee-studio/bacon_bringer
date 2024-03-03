import 'package:bacon_bringer/bases/view_model_state.dart';
import 'package:bacon_bringer/ui/home/view_model/home_page_view_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ViewModelState<HomePage, HomePageViewModel> {
  @override
  HomePageViewModel createViewModel() => HomePageViewModel(this, widget.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: viewModel.title),
        body: Center(child: viewModel.body(context)));
  }
}
