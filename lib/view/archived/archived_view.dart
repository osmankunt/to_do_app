import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/widgets/todo_list.dart';
import 'package:to_do_app/widgets/todo_scaffold.dart';
import 'archived_states.dart';
import 'archived_view_model.dart';

class ArchivedView extends StatelessWidget {
  const ArchivedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArchivedViewModel, ArchivedStates>(builder: (context, state) {
      return state.viewStatus == ViewStatus.loading
          ? const CircularProgressIndicator()
          : (state.archivedList == null
              ? Center(
                  child: Text(Constants.emptyArchiveList),
                )
              : ToDoScaffold(
                  pageName: Constants.archivedPage,
                  child: BlocSelector<ArchivedViewModel, ArchivedStates, List<ToDoModel>>(
                    selector: (state) => state.archivedList ?? [],
                    builder: (context, list) {
                      return ToDoList(todosList: list);
                    },
                  ),
                ));
    });
  }
}
