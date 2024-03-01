import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/widgets/todo_list.dart';
import 'package:to_do_app/widgets/todo_scaffold.dart';
import 'done_states.dart';
import 'done_view_model.dart';

class DoneView extends StatelessWidget {
  const DoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoneViewModel, DoneStates>(builder: (context, state) {
      return state.viewStatus == ViewStatus.loading
          ? const CircularProgressIndicator()
          : (state.doneList == null
              ? Center(
                  child: Text(Constants.emptyDoneList),
                )
              : ToDoScaffold(
                  pageName: Constants.donePage,
                  child: BlocSelector<DoneViewModel, DoneStates, List<ToDoModel>>(
                      selector: (state) => state.doneList ?? [],
                      builder: (context, list) {
                        return ToDoList(
                          todosList: list,
                        );
                      })));
    });
  }
}
