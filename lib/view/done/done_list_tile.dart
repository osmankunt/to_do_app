import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/view/done/done_view_model.dart';

class DoneListTile extends StatelessWidget {
  DoneListTile({
    required this.toDoModel,
    Key? key,
  }) : super(key: key);
  final ToDoModel toDoModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          toDoModel.title.length < 18 ? Text(toDoModel.title) : Text("${toDoModel.title.substring(0, 17)}.."),
          const Spacer(),
          IconButton(
            onPressed: () {
              context.read<DoneViewModel>().deleteToDo(toDoModel);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<DoneViewModel>().updateToDo(
                    ToDoModel(
                        title: toDoModel.title, toDo: toDoModel.toDo, date: toDoModel.date, isDone: false, isArchived: true),
                  );
            },
            icon: const Icon(
              Icons.archive,
              color: Colors.green,
            ),
          ),
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
