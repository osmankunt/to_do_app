import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/view/archived/archived_view.dart';
import 'package:to_do_app/view/done/done_view.dart';
import 'package:to_do_app/view/home/home_view_model.dart';
import 'package:to_do_app/view/home/home_view_model_states.dart';
import 'package:to_do_app/view/todos/todos_view.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final List<Widget> views = [
    const ToDosView(),
    const DoneView(),
    const ArchivedView(),
  ];

  final List<String> titles = [
    Constants.todosText,
    Constants.doneText,
    Constants.archivedText,
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewModel, HomeViewModelStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return state.viewStatus == ViewStatus.initial ||
                  state.viewStatus == ViewStatus.success ||
                  state.viewStatus == ViewStatus.add
              ? Scaffold(
                  appBar: AppBar(
                    title: Text(titles[context.read<HomeViewModel>().currentIndex].toString()),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: views[context.read<HomeViewModel>().currentIndex],
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => buildAlertDialog(context),
                      );
                    },
                    child: const Icon(Icons.add),
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: context.read<HomeViewModel>().currentIndex,
                    onTap: (index) {
                      context.read<HomeViewModel>().setBottomIndex(index);
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.home),
                        label: Constants.homeText,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.check),
                        label: Constants.doneText,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.archive),
                        label: Constants.archivedText,
                      ),
                    ],
                  ),
                )
              : const CircularProgressIndicator();
        });
  }

  AlertDialog buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text(Constants.newTodoText),
      content: BlocBuilder<HomeViewModel, HomeViewModelStates>(builder: (context, state) {
        return Form(
          key: _formKey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
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
                  controller: _todoController,
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
                          context.read<HomeViewModel>().submitToDo(state.toDo ??
                              ToDoModel(
                                  title: _titleController.text,
                                  toDo: _todoController.text,
                                  date: context.read<HomeViewModel>().initialDate,
                                  isDone: false,
                                  isArchived: false));
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
