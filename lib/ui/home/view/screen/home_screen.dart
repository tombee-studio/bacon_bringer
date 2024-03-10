import 'package:bacon_bringer/bases/view_model_state.dart';
import 'package:bacon_bringer/enum/home_screen_state.dart';
import 'package:bacon_bringer/ui/home/view_model/home_screen_view_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ViewModelState<HomeScreen, HomeScreenViewModel> {
  @override
  HomeScreenViewModel createViewModel() =>
      HomeScreenViewModel(this, widget.title);

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
            currentIndex:
                HomeScreenState.values.indexOf(viewModel.currentState),
            onTap: onTap,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: '収支管理'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定')
            ]));
  }

  void onTap(int index) {
    viewModel.currentState = HomeScreenState.values[index];
  }
}
