
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/models/todo_model.dart';
import '../constants/constants.dart';

class ToDoScreen extends StatelessWidget {
  ToDoScreen({Key? key}) : super(key: key);
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGColor,
      appBar: AppBar(
        title: Text('home'),
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
              add(title.text, desc.text, false);
              Navigator.pop(context);

            },
            child: Text('save'),
          ),
        ],
      ),
    );
  }

  void add(String title, String desc, bool isDone) async {
    var box = await Hive.openBox('todoDB');
    ToDo toDo = ToDo(desc, isDone, title);
    await box.add(toDo);
  }
}
