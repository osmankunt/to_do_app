import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/view/archived/archived_view.dart';
import 'package:to_do_app/view/done/done_view.dart';
import 'package:to_do_app/view/home/home_view.dart';
import 'package:to_do_app/view/main/main_view_model.dart';
import 'package:to_do_app/view/main/main_view_model_states.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainViewModel, MainViewModelStates>(builder: (context, state) {
      return Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: state.index,
          onTap: (index) {
            context.read<MainViewModel>().changeIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: Constants.homeText,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.check),
              label: Constants.doneText,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.archive),
              label: Constants.archivedText,
            ),
          ],
        ),
        body: [
          HomeView(),
          const DoneView(),
          const ArchivedView(),
        ][state.index],
      );
    });
  }
}
