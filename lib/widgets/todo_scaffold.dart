import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/view/todos/todos_view_model.dart';
import 'package:to_do_app/widgets/todo_alert_dialog.dart';

class ToDoScaffold extends StatelessWidget {
  ToDoScaffold({this.pageName, required this.child, Key? key}) : super(key: key);

  final Widget child;
  final String? pageName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageName ?? ""),
      ),
      body: BlocProvider(
        create: (BuildContext context) => ToDoViewModel(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffF9E8C9),
              border: Border.all(width: 4, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: child,
          ),
        ),
      ),
      floatingActionButton: pageName != Constants.toDoPage
          ? const SizedBox()
          : FloatingActionButton(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ToDoAlertDialog(),
                );
              },
              child: const Icon(Icons.add_task),
            ),
    );
  }
}
