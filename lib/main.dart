import 'package:flutter/material.dart';
import 'package:todo_list/page/todo_page.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
