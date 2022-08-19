import 'package:flutter/material.dart';
import 'package:todo_list/constants/constants.dart';

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
    );
  }
}
