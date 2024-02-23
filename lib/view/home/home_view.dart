import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/utils/page_utils.dart';
import 'package:to_do_app/view/home/home_view_model.dart';
import 'package:to_do_app/view/home/home_states.dart';
import 'package:to_do_app/view/todos/todos_view.dart';
import 'package:to_do_app/widgets/todo_scaffold.dart';

import '../../enum/pages.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewModel, HomeViewModelStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return state.viewStatus == ViewStatus.success
              ? ToDoScaffold(
                  pageName: PageUtils.getPage(state.pages ?? Pages.todo_view),
                  child: const ToDosView(),
                )
              : const CircularProgressIndicator();
        });
  }
}
