import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/enum/states.dart';
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
    'To Dos',
    'Done',
    'Archives',
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewModel, HomeViewModelStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return state.viewStatus == ViewStatus.initial || state.viewStatus == ViewStatus.success
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
                        builder: (context) => AlertDialog(
                          title: Text('New Todo'),
                          content: BlocBuilder<HomeViewModel, HomeViewModelStates>(builder: (context, state) {
                            return Form(
                              key: _formKey,
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.4,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _titleController,
                                      decoration: const InputDecoration(
                                        hintText: "Title",
                                        labelText: "Title",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: _todoController,
                                      minLines: 1,
                                      maxLines: 3,
                                      decoration: const InputDecoration(
                                        hintText: "To Do",
                                        labelText: "To Do",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<HomeViewModel>()
                                            .submitToDo(_titleController.text, _todoController.text, DateTime.now());
                                      },
                                      child: Text("Submit"),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      );
                    },
                    child: const Icon(Icons.add),
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: context.read<HomeViewModel>().currentIndex,
                    onTap: (index) {
                      context.read<HomeViewModel>().setBottomIndex(index);
                    },
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.check),
                        label: 'Done',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.archive),
                        label: 'Archived',
                      ),
                    ],
                  ),
                )
              : const CircularProgressIndicator();
        });
  }
}
