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
  void initState() {
    super.initState();

    viewModel.launch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundColor: Theme.of(context).colorScheme.primary,
            title: viewModel.title),
        drawer: viewModel.drawer(context),
        body: Center(child: viewModel.body(context)),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            currentIndex: viewModel.currentIndex,
            onTap: onTap,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: '収支管理'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定')
            ]));
  }

  void onTap(int index) {
    viewModel.currentIndex = index;
  }
}
