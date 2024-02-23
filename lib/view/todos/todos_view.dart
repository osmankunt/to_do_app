import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/view/home/home_view_model.dart';
import 'package:to_do_app/view/todos/todos_view_model.dart';
import 'package:to_do_app/widgets/todo_list_tile.dart';

import '../../widgets/todo_scaffold.dart';
import 'todos_states.dart';

class ToDosView extends StatelessWidget {
  const ToDosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoViewModel, ToDoStates>(builder: (context, state) {
      var cubit = HomeViewModel.get(context);
      List<ToDoModel>? todosList = [];
      for (var item in cubit.toDoList!) {
        if (!item.isArchived && !item.isDone) {
          todosList.add(item);
        }
      }
      return todosList.isEmpty
          ? Center(
              child: Text(Constants.emptyToDoList),
            )
          : ToDoScaffold(
              pageName: Constants.toDoPage,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ToDoListTile(
                    toDoModel: todosList[index],
                    hasUpdateButton: true,
                  );
                },
                itemCount: todosList.length,
                shrinkWrap: true,
              ),
            );
    });
  }
}
