import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/view/home/home_view_model.dart';
import 'package:to_do_app/view/home/home_view_model_states.dart';

import '../constant/constants.dart';

class ToDoListTile extends StatelessWidget {
  ToDoListTile({
    required this.toDoModel,
    this.toDo,
    this.hasUpdateButton = false,
    Key? key,
  }) : super(key: key);
  final ToDoModel toDoModel;
  final String? toDo;
  bool hasUpdateButton;

  @override
  Widget build(BuildContext context) {
    var cubit = HomeViewModel.get(context);
    return ListTile(
      title: BlocSelector<HomeViewModel, HomeViewModelStates, String>(
          selector: (state) => state.toDo == null ? "" : toDoModel.title,
          builder: (context, state) {
            return Row(
              children: [
                Text(toDoModel.title),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    cubit.deleteToDo(toDoModel);
                  },
                  icon: const Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {
                    cubit.updateToDo(
                        ToDoModel(
                            title: toDoModel.title, toDo: toDoModel.toDo, date: toDoModel.date, isDone: true, isArchived: false),
                        toDo ?? "");
                  },
                  icon: const Icon(Icons.done),
                ),
                hasUpdateButton
                    ? IconButton(
                        onPressed: () {
                          cubit.updateToDo(
                              ToDoModel(
                                  title: toDoModel.title,
                                  toDo: toDoModel.toDo,
                                  date: toDoModel.date,
                                  isDone: true,
                                  isArchived: false),
                              toDo ?? "");
                        },
                        icon: const Icon(Icons.update),
                      )
                    : const SizedBox(),
                IconButton(
                  onPressed: () {
                    cubit.updateToDo(
                        ToDoModel(
                            title: toDoModel.title, toDo: toDoModel.toDo, date: toDoModel.date, isDone: false, isArchived: true),
                        toDo ?? "");
                  },
                  icon: const Icon(Icons.archive),
                ),
              ],
            );
          }),
      subtitle: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(toDoModel.toDo),
            Text(
              DateFormat.yMMMEd().format(toDoModel.date),
            ),
          ],
        ),
      ),
    );
  }
}
