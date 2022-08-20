import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ToDoScreen(),
              ));
        },
        backgroundColor: kIconColor,
        child: const Icon(Icons.access_time),
      ),
    );
  }
}
