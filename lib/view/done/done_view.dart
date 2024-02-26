import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/widgets/todo_list_tile.dart';
import 'package:to_do_app/widgets/todo_scaffold.dart';
import 'done_states.dart';
import 'done_view_model.dart';

class DoneView extends StatelessWidget {
  const DoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoneViewModel, DoneStates>(builder: (context, state) {
      List<ToDoModel>? todosList = [];
      if (state.toDoList != null) {
        for (var item in state.toDoList!) {
          if (item.isDone) {
            todosList.add(item);
          }
        }
      }
      return state.viewStatus == ViewStatus.loading
          ? const CircularProgressIndicator()
          : (todosList.isEmpty
              ? Center(
                  child: Text(Constants.emptyDoneList),
                )
              : ToDoScaffold(
                  pageName: Constants.donePage,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ToDoListTile(
                        toDoModel: todosList[index],
                        hasUpdateButton: false,
                      );
                    },
                    itemCount: todosList.length,
                    shrinkWrap: true,
                  ),
                ));
    });
  }
}
