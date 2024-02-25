import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constant/constants.dart';
import '../../enum/states.dart';
import '../../model/todo_model.dart';
import '../../widgets/todo_list_tile.dart';
import '../../widgets/todo_scaffold.dart';
import 'archived_states.dart';
import 'archived_view_model.dart';

class ArchivedView extends StatelessWidget {
  const ArchivedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArchivedViewModel, ArchivedStates>(builder: (context, state) {
      List<ToDoModel>? todosList = [];
      if (state.toDoList != null) {
        for (var item in state.toDoList!) {
          if (item.isArchived) {
            todosList.add(item);
          }
        }
      }
      return state.viewStatus == ViewStatus.loading
          ? const CircularProgressIndicator()
          : (todosList.isEmpty
              ? Center(
                  child: Text(Constants.emptyArchiveList),
                )
              : ToDoScaffold(
                  pageName: Constants.archivedPage,
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
