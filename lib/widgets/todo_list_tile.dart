import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/view/todos/todos_view_model.dart';
import 'package:to_do_app/widgets/todo_alert_dialog.dart';

class ToDoListTile extends StatelessWidget {
  ToDoListTile({
    required this.toDoModel,
    this.toDo,
    Key? key,
  }) : super(key: key);
  final ToDoModel toDoModel;
  final String? toDo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          toDoModel.title.length < 18 ? Text(toDoModel.title) : Text("${toDoModel.title.substring(0, 17)}.."),
          const Spacer(),
          IconButton(
            onPressed: () {
              context.read<ToDoViewModel>().deleteToDo(toDoModel);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          toDoModel.isDone == false && toDoModel.isArchived == false
              ? IconButton(
                  onPressed: () {
                    context.read<ToDoViewModel>().updateToDo(
                          ToDoModel(
                              title: toDoModel.title,
                              toDo: toDoModel.toDo,
                              date: toDoModel.date,
                              isDone: true,
                              isArchived: false),
                        );
                  },
                  icon: const Icon(Icons.done),
                )
              : const SizedBox.shrink(),
          toDoModel.isDone == false && toDoModel.isArchived == false
              ? IconButton(
                  onPressed: () {
                    showDialog(context: context, builder: (context) => ToDoAlertDialog(toDoModel: toDoModel));
                  },
                  icon: const Icon(Icons.update),
                )
              : const SizedBox.shrink(),
          toDoModel.isArchived == false
              ? IconButton(
                  onPressed: () {
                    context.read<ToDoViewModel>().updateToDo(
                          ToDoModel(
                              title: toDoModel.title,
                              toDo: toDoModel.toDo,
                              date: toDoModel.date,
                              isDone: false,
                              isArchived: true),
                        );
                  },
                  icon: const Icon(
                    Icons.archive,
                    color: Colors.green,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
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
