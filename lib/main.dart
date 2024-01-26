import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tareas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Lista de Tareas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _textController = TextEditingController();

  void _addTask(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _tasks.add({'task': task, 'isDone': false});
      });
      _textController.clear();
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Añadir tarea',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    _tasks[index]['task'],
                    style: _tasks[index]['isDone']
                        ? const TextStyle(
                            decoration: TextDecoration.lineThrough,
                          )
                        : null,
                  ),
                  leading: Checkbox(
                    value: _tasks[index]['isDone'],
                    onChanged: (bool? value) {
                      setState(() {
                        _tasks[index]['isDone'] = value;
                      });
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteTask(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Añadir tarea'),
                content: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: 'Escribe tu tarea aquí',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _textController.clear();
                    },
                  ),
                  TextButton(
                    child: const Text('Aceptar'),
                    onPressed: () {
                      _addTask(_textController.text);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Añadir tarea',
        child: const Icon(Icons.add),
      ),
    );
  }
}
