import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/constants.dart';
import '../../model/todo_model.dart';
import '../../widgets/todo_list_tile.dart';
import '../../widgets/todo_scaffold.dart';
import '../home/home_view_model.dart';
import '../home/home_states.dart';

class ArchivedView extends StatelessWidget {
  const ArchivedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeViewModelStates>(builder: (context, state) {
      var cubit = HomeViewModel.get(context);
      List<ToDoModel>? todosList = [];
      for (var item in cubit.toDoList!) {
        if (item.isArchived) {
          todosList.add(item);
        }
      }
      return todosList.isEmpty
          ? Center(
              child: Text(Constants.emptyArchiveList),
            )
          : ToDoScaffold(
              pageName: Constants.archivedPage,
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
