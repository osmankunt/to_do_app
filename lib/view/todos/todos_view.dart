import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/enum/pages.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/view/todos/todos_view_model.dart';
import 'package:to_do_app/widgets/todo_list_tile.dart';
import 'package:to_do_app/widgets/todo_scaffold.dart';
import 'todos_states.dart';

class ToDosView extends StatelessWidget {
  const ToDosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoViewModel, ToDoStates>(builder: (context, state) {
      List<ToDoModel>? todosList = [];
      for (var item in state.toDoList!) {
        if (!item.isArchived && !item.isDone) {
          todosList.add(item);
        }
      }
      return state.viewStatus == ViewStatus.success
          ? (todosList.isEmpty
              ? Center(
                  child: Text(Constants.emptyToDoList),
                )
              : ToDoScaffold(
                  pageName: Constants.toDoPage,
                  child: BlocSelector<ToDoViewModel, ToDoStates, List<ToDoModel>>(
                      selector: (state) => todosList,
                      builder: (context, state) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return ToDoListTile(
                              toDoModel: state[index],
                              page: Pages.todo_view,
                            );
                          },
                          itemCount: state.length,
                          shrinkWrap: true,
                        );
                      })))
          : const CircularProgressIndicator();
    });
  }
}
