import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/models/todo_model.dart';
import '../constants/constants.dart';

class ToDoScreen extends StatelessWidget {
  ToDoScreen({
    required this.type,
    required this.getTitle,
    required this.getDesc,
    required this.isDone,
    required this.index,
    Key? key,
  }) : super(key: key);
  final String type;
  final String getTitle;
  final String getDesc;
  final bool isDone;
  final int index;
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(type == 'Update'){
      title.text = getTitle;
      desc.text = getDesc;

    }
    return Scaffold(
      backgroundColor: kBGColor,
      appBar: AppBar(
        title:
            type == 'Add' ? const Text('Add ToDo') : const Text('Update ToDo'),
        centerTitle: true,
        backgroundColor: kBGColor,
      ),
      body: Column(
        children: [
          TextField(
            controller: title,
          ),
          TextField(
            controller: desc,
          ),
          ElevatedButton(
            onPressed: () {
              onPressedBotton(title.text, desc.text, isDone);
              Navigator.pop(context);
            },
            child: type == 'Add'
                ? const Text('Add ToDo')
                : const Text('Update ToDo'),
          ),
        ],
      ),
    );
  }

  void onPressedBotton(String title, String desc, bool isDone) {
    if (type == 'Add') {
      add(title, desc, isDone);
    } else {
      update(title, desc, isDone);
    }
  }

  void add(String title, String desc, bool isDone) async {
    var box = await Hive.openBox('todoDB');
    ToDo todo = ToDo(desc, isDone, title);
    await box.add(todo);
  }

  void update(String title, String desc, bool isDone) async {
    var box = await Hive.openBox('todoDB');
    ToDo todo = ToDo(desc, isDone, title);
    box.putAt(index, todo);
  }
}
