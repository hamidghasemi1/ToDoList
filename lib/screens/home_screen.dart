import 'package:flutter/material.dart';
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
        title: const Text('Home'),
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
            return const Text('No Task');
          } else {
            return ListView.builder(
              itemCount: todoBox.length,
              itemBuilder: (context, index) {
                final ToDo todo = box.getAt(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  child: Card(
                    color: kCardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      onTap: () => MyNavigator(context, 'Update', todo.title,
                          todo.desc, todo.isDone, index),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration:
                              todo.isDone ? TextDecoration.lineThrough : null,
                          color: todo.isDone ? kLineColor : Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: todo.isDone
                          ? null
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                todo.desc,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                      leading: Checkbox(
                        value: todo.isDone,
                        shape: const CircleBorder(),
                        activeColor: kIconColor,
                        side: const BorderSide(
                          width: 2.0,
                          color: kIconColor,
                        ),
                        onChanged: (value) {
                          setState(() {
                            todo.isDone = value!;
                          });
                        },
                      ),
                      trailing: IconButton(
                        onPressed: () => remove(index),
                        icon: const Icon(
                          Icons.delete,
                        ),
                        color: kIconColor,
                      ),
                    ),
                  ),
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

  void remove(int index) {
    Box box = Hive.box('todoDB');
    box.deleteAt(index);
  }
}
