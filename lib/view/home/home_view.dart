import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/view/archived/archived_view.dart';
import 'package:to_do_app/view/done/done_view.dart';
import 'package:to_do_app/view/home/home_view_model.dart';
import 'package:to_do_app/view/home/home_view_model_states.dart';
import 'package:to_do_app/view/todos/todos_view.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final List<Widget> views = [
    const ToDosView(),
    const DoneView(),
    const ArchivedView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewModel, TodoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeViewModel.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(views[cubit.currentIndex].toString()),
            ),
            body: views[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.setBottomIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'Archived',
                ),
              ],
            ),
          );
        });
  }
}
