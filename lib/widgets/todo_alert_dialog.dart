import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/view/todos/todos_states.dart';
import 'package:to_do_app/view/todos/todos_view_model.dart';

class ToDoAlertDialog extends StatefulWidget {
  ToDoAlertDialog({this.toDoModel, Key? key}) : super(key: key);

  final ToDoModel? toDoModel;

  TextEditingController? titleController;
  TextEditingController? todoController;

  @override
  State<ToDoAlertDialog> createState() => _ToDoAlertDialogState();
}

class _ToDoAlertDialogState extends State<ToDoAlertDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    widget.titleController = TextEditingController(text: widget.toDoModel?.title ?? "");
    widget.todoController = TextEditingController(text: widget.toDoModel?.toDo ?? "");
    var cubit = ToDoViewModel.get(context);
    return AlertDialog(
      title: widget.toDoModel == null ? Text(Constants.newTodoText) : Text(Constants.updateTodoText),
      content: BlocBuilder<ToDoViewModel, ToDoStates>(builder: (context, state) {
        return Form(
          key: _formKey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: [
                TextFormField(
                  controller: widget.titleController,
                  enabled: widget.toDoModel == null ? true : false,
                  decoration: InputDecoration(
                    hintText: Constants.titleText,
                    labelText: Constants.titleText,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Constants.cantBeEmpty;
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: widget.todoController,
                  minLines: 1,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: Constants.todoText,
                    labelText: Constants.todoText,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Constants.cantBeEmpty;
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocSelector<ToDoViewModel, ToDoStates, DateTime>(
                    selector: (state) => state.pickedDate ?? DateTime.now(),
                    builder: (context, state) {
                      return ElevatedButton.icon(
                        onPressed: () {
                          context.read<ToDoViewModel>().datePicker(context);
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        label: context.read<ToDoViewModel>().initialDate != DateTime.now()
                            ? Text(
                                DateFormat.yMMMEd().format(context.read<ToDoViewModel>().initialDate),
                              )
                            : Text(
                                DateFormat.yMMMEd().format(
                                  DateTime.now(),
                                ),
                              ),
                        icon: const Icon(Icons.date_range),
                      );
                    }),
                const Spacer(),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(Constants.cancelButtonText),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.toDoModel == null
                              ? cubit.submitToDo(ToDoModel(
                                  title: widget.titleController?.text ?? "",
                                  toDo: widget.todoController?.text ?? "",
                                  date: context.read<ToDoViewModel>().initialDate,
                                  isDone: false,
                                  isArchived: false))
                              : cubit.updateToDo(
                                  ToDoModel(
                                      title: widget.toDoModel!.title.isEmpty ? "" : widget.toDoModel!.title,
                                      toDo: widget.toDoModel!.toDo.isEmpty ? "" : widget.todoController?.text ?? "",
                                      date: widget.toDoModel!.date.toString().isEmpty
                                          ? DateTime.now()
                                          : context.read<ToDoViewModel>().initialDate,
                                      isDone: widget.toDoModel!.isDone ? false : widget.toDoModel!.isDone,
                                      isArchived: widget.toDoModel!.isArchived ? false : widget.toDoModel!.isArchived),
                                );
                          Navigator.of(context).pop();
                        }
                      },
                      child: widget.toDoModel == null ? Text(Constants.submitButtonText) : Text(Constants.updateButtonText),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    widget.titleController?.dispose();
    widget.todoController?.dispose();
    super.dispose();
  }
}
