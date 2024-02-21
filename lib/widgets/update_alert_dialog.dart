import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/model/todo_model.dart';

import '../constant/constants.dart';
import '../view/home/home_view_model.dart';
import '../view/home/home_view_model_states.dart';

class UpdateAlertDialog extends StatelessWidget {
  UpdateAlertDialog({required this.toDoModel, Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ToDoModel? toDoModel;

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController(text: toDoModel?.title ?? "");
    final TextEditingController todoController = TextEditingController(text: toDoModel?.toDo ?? "");
    var cubit = HomeViewModel.get(context);
    return AlertDialog(
      title: Text(Constants.updateTodoText),
      content: BlocBuilder<HomeViewModel, HomeViewModelStates>(builder: (context, state) {
        return Form(
          key: _formKey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  enabled: titleController.text.isEmpty ? true : false,
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
                  controller: todoController,
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
                BlocSelector<HomeViewModel, HomeViewModelStates, DateTime>(
                    selector: (state) => state.pickedDate ?? DateTime.now(),
                    builder: (context, state) {
                      return ElevatedButton.icon(
                        onPressed: () {
                          context.read<HomeViewModel>().datePicker(context);
                        },
                        label: context.read<HomeViewModel>().initialDate != DateTime.now()
                            ? Text(
                                DateFormat.yMMMEd().format(context.read<HomeViewModel>().initialDate),
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
                          cubit.updateToDo(
                            ToDoModel(
                                title: toDoModel!.title.isEmpty ? "" : toDoModel!.title,
                                toDo: toDoModel!.toDo.isEmpty ? "" : todoController.text,
                                date: toDoModel!.date.toString().isEmpty
                                    ? DateTime.now()
                                    : context.read<HomeViewModel>().initialDate,
                                isDone: toDoModel!.isDone ? false : toDoModel!.isDone,
                                isArchived: toDoModel!.isArchived ? false : toDoModel!.isArchived),
                          );
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(Constants.submitButtonText),
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
}
