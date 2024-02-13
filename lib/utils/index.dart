import 'package:to_do_app/enum/index.dart';

class IndexUtils {
  static Index setIndex(int index) {
    switch (index) {
      case 0:
        return Index.all;
      case 1:
        return Index.done;
      case 2:
        return Index.active;
      default:
        return Index.all;
    }
  }

  static int getIndex(Index index) {
    switch (index) {
      case Index.all:
        return 0;
      case Index.done:
        return 1;
      case Index.active:
        return 2;
      default:
        return 0;
    }
  }
}
