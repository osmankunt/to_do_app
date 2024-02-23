import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/view/todos/todos_view_model.dart';
import 'package:to_do_app/widgets/todo_alert_dialog.dart';
import '../view/todos/todos_view.dart';

class ToDoScaffold extends StatelessWidget {
  const ToDoScaffold({this.pageName, required this.child, Key? key}) : super(key: key);

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ToDoAlertDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
