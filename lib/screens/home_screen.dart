import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/constants/constants.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/screens/todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGColor,
      appBar: AppBar(
        title: Text('home'),
        centerTitle: true,
        backgroundColor: kBGColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MyNavigator(context, 'Add', '', '', false, -1);
        },
        backgroundColor: kIconColor,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: Hive.openBox('todoDB'),
        builder: ((context, snapshot) {
          return ToDoList();
        }),
      ),
    );
  }

  Widget ToDoList() {
    Box todoBox = Hive.box('todoDB');
    return ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
        builder: ((context, Box box, child) {
          if (box.values.isEmpty) {
            return Text('No Task');
          } else {
            return ListView.builder(
              itemCount: todoBox.length,
              itemBuilder: (context, index) {
                final ToDo todo = box.getAt(index);
                return ListTile(
                  onTap: () => MyNavigator(context, 'Update', todo.title,
                      todo.desc, todo.isDone, index),
                  title: Text(todo.title),
                  subtitle: Text(todo.desc),
                );
              },
            );
          }
        }));
  }

  MyNavigator(
      context, String type, String title, String desc, bool isDone, int index) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ToDoScreen(
            type: type,
            getTitle: title,
            getDesc: desc,
            isDone: isDone,
            index: index,
          ),
        ));
  }
}
