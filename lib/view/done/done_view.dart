import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/model/todo_model.dart';
import '../../constant/constants.dart';
import '../../widgets/todo_list_tile.dart';
import '../../widgets/todo_scaffold.dart';
import 'done_states.dart';
import 'done_view_model.dart';

class DoneView extends StatelessWidget {
  const DoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoneViewModel, DoneStates>(builder: (context, state) {
      var cubit = DoneViewModel.get(context);
      List<ToDoModel>? todosList = [];
      for (var item in cubit.toDoList!) {
        if (item.isDone) {
          todosList.add(item);
        }
      }
      return todosList.isEmpty
          ? Center(
              child: Text(Constants.emptyDoneList),
            )
          : ToDoScaffold(
              pageName: Constants.donePage,
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
