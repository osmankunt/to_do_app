import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/enum/states.dart';
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
    return BlocConsumer<HomeViewModel, HomeViewModelStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeViewModel.get(context);
          return state.viewStatus == ViewStatus.success
              ? Scaffold(
                  appBar: AppBar(
                    title: Text(views[context.read<HomeViewModel>().currentIndex].toString()),
                  ),
                  body: views[context.read<HomeViewModel>().currentIndex],
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: context.read<HomeViewModel>().currentIndex,
                    onTap: (index) {
                      context.read<HomeViewModel>().setBottomIndex(index);
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
                )
              : const CircularProgressIndicator();
        });
  }
}
