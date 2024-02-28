import 'package:flutter/material.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/widgets/todo_list_tile.dart';

class ToDoList extends StatelessWidget {
  ToDoList({required this.todosList, Key? key}) : super(key: key);

  List<ToDoModel>? todosList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return todosList?[index] != null
            ? ToDoListTile(
                toDoModel: todosList![index],
              )
            : const SizedBox.shrink();
      },
      itemCount: todosList?.length ?? 0,
      shrinkWrap: true,
    );
  }
}
