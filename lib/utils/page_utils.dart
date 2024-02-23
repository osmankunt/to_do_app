import 'package:flutter/cupertino.dart';
import 'package:to_do_app/view/archived/archived_view.dart';
import 'package:to_do_app/view/todos/todos_view.dart';

import '../enum/pages.dart';
import '../view/done/done_view.dart';

class PageUtils {
  static String getPage(Pages pages) {
    switch (pages) {
      case Pages.todo_view:
        return "To Do Page";
      case Pages.done_view:
        return "Done Page";
      case Pages.archived_view:
        return "Archived Page";
      default:
        return "";
    }
  }

  static Widget getPageView(String page) {
    switch (page) {
      case "To Do Page":
        return const ToDosView();
      case "Done Page":
        return const DoneView();
      case "Archived Page":
        return const ArchivedView();
      default:
        return const ToDosView();
    }
  }
}
