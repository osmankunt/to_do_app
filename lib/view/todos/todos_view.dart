import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/view/home/home_view_model.dart';
import 'package:to_do_app/view/home/home_view_model_states.dart';
import 'package:to_do_app/widgets/todo_list_tile.dart';

import '../../constant/constants.dart';

class ToDosView extends StatelessWidget {
  const ToDosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeViewModelStates>(builder: (context, state) {
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
          : ListView.builder(
              itemBuilder: (context, index) {
                return ToDoListTile(toDoModel: todosList[index]);
              },
              itemCount: todosList.length,
              shrinkWrap: true,
            );
    });
  }
}
