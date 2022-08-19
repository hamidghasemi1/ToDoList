import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 1)
class ToDo {
  @HiveField(0)
  String title;

  @HiveField(1)
  int desc;

  @HiveField(2)
  bool isDone;

  ToDo(this.desc, this.isDone, this.title);
}
