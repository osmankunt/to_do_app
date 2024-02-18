import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/view/home/home_view_model.dart';

import '../../constant/constants.dart';
import '../../widgets/todo_list_tile.dart';
import '../home/home_view_model_states.dart';

class DoneView extends StatelessWidget {
  const DoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeViewModelStates>(builder: (context, state) {
      var cubit = HomeViewModel.get(context);
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
