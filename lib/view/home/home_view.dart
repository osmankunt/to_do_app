import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/view/archived/archived_view.dart';
import 'package:to_do_app/view/done/done_view.dart';
import 'package:to_do_app/view/home/home_view_model.dart';
import 'package:to_do_app/view/home/home_view_model_states.dart';
import 'package:to_do_app/view/todos/todos_view.dart';
import 'package:to_do_app/widgets/todo_alert_dialog.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final List<Widget> views = [
    const ToDosView(),
    const DoneView(),
    const ArchivedView(),
  ];

  final List<String> titles = [
    Constants.todosText,
    Constants.doneText,
    Constants.archivedText,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewModel, HomeViewModelStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeViewModel.get(context);
          return state.viewStatus == ViewStatus.initial ||
                  state.viewStatus == ViewStatus.success ||
                  state.viewStatus == ViewStatus.add
              ? Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.grey,
                    title: Center(
                      child: Text(
                        titles[cubit.currentIndex].toString(),
                        style: TextStyle(
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Colors.brown[700]!,
                        ),
                      ),
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffF9E8C9),
                        border: Border.all(width: 4, color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: views[cubit.currentIndex],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ToDoAlertDialog(),
                      );
                    },
                    child: const Icon(Icons.add),
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: cubit.currentIndex,
                    onTap: (index) {
                      cubit.setBottomIndex(index);
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
                )
              : const CircularProgressIndicator();
        });
  }
}
