import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:todo_list/controller/todo_controller.dart';

class ToDo extends StatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  final ToDoController _controller = ToDoController();
  @override
  void initState() {
    super.initState();

    _controller.readData().then((data) {
      setState(() {
        _controller.toDoList = json.decode(data!);
      });
    });
  }

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = {};
      newToDo["title"] = _controller.toDoController.text;
      _controller.toDoController.text = "";
      newToDo["ok"] = false;
      _controller.toDoList.add(newToDo);
      _controller.saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(17, 1, 7, 1),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller.toDoController,
                  decoration: const InputDecoration(
                    labelText: "Tarefa",
                    labelStyle: TextStyle(color: Colors.black87),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: const Text(
                  'Acrescentar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: _addToDo,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 10.0),
              itemCount: _controller.toDoList.length,
              itemBuilder: buildItem),
        )
      ],
    );
  }

  Widget buildItem(context, index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(
          _controller.toDoList[index]["title"],
        ),
        value: _controller.toDoList[index]["ok"],
        secondary: CircleAvatar(
          child: Icon(
              _controller.toDoList[index]["ok"] ? Icons.check : Icons.error),
        ),
        onChanged: (c) {
          setState(() {
            _controller.toDoList[index]["ok"] = c;
            _controller.saveData();
          });
        },
      ),
      onDismissed: (direction) {
        setState(
          () {
            _controller.lastRemoved = Map.from(_controller.toDoList[index]);
            _controller.lastRemovedPos = index;
            _controller.toDoList.removeAt(index);

            _controller.saveData();

            final snack = SnackBar(
              content: Text(
                  'Informação ${_controller.lastRemoved["title"]} removida'),
              action: SnackBarAction(
                label: "Desfazer",
                onPressed: () {
                  setState(() {
                    _controller.toDoList.insert(
                        _controller.lastRemovedPos, _controller.lastRemoved);
                    _controller.saveData();
                  });
                },
              ),
              duration: const Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(snack);
          },
        );
      },
    );
  }
}
