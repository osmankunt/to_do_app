import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/view/archived/archived_view.dart';
import 'package:to_do_app/view/home/home_view_model.dart';
import 'package:to_do_app/view/home/home_view_model_states.dart';
import 'package:to_do_app/view/todos/todos_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewModel, HomeViewModelStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeViewModel.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('To Do App'),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex.index,
              onTap: (index) {
                cubit.setBottomBar(index);
                const ToDosView();
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.done),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_active),
                  label: 'Active',
                ),
              ],
            ),
            body: const ArchivedView(),
          );
        });
  }
}
