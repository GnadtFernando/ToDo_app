import 'package:flutter/material.dart';
import 'package:todo_list/src/todo_page.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Afazeres"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: const ToDo(),
    );
  }
}
