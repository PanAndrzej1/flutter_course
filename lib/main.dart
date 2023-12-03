import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_course/models/todo_models.dart';
import 'package:flutter_course/widgets/todo_botton_sheet.dart';
import 'package:flutter_course/widgets/todo_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        // brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoModel> todos = [];
  int todoNumber = 0;

  late SharedPreferences pref;

  @override
  void initState() {
    loadSheredPreferences();
    super.initState();
  }

  void loadSheredPreferences() async {
    pref = await SharedPreferences.getInstance();
    loadTodo();
  }

  Future<void> saveTodo() async {
    List<String> todoStingList =
        todos.map((e) => jsonEncode(e.toJson())).toList();
    await pref.setStringList("todo", todoStingList);
  }

  Future<void> loadTodo() async {
    List<String>? todoStringList =  pref.getStringList("todo");
    print(todoStringList);
    if (todoStringList == null) return;
    setState(() {
      todos = todoStringList
          .map((e) => TodoModel.fromJson(json.decode(e)))
          .toList();
    });
  }

  void addTodoItem() {
    showModalBottomSheet(
        context: context, builder: (context) => TodoBottomSheet()).then(
      (value) async {
        setState(() {
          todos.add(TodoModel(text: value));
        });
        await saveTodo();
      },
    );
  }

  void removeTodo(TodoModel todo)async {
    setState(() {
      todos.removeWhere((element) =>
          element.text ==
          todo.text); //to do zmiany bo bedzie usuwać wszystko co ma taki sam tekst
    });
await saveTodo();
  }

  void onTodoChange(TodoModel todo) async{
    setState(() {
      todo.isDone = !todo.isDone;
    });
    await saveTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: Text("Lista spraw do załatwienia"),
        actions: [
          // MaterialButton(
          //   shape: CircleBorder(),
          //   onPressed: () {},
          //   child: Icon(Icons.add),
          // ),
          IconButton(
            onPressed: addTodoItem,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      //Warunek ? prawda :fałsz
      body: todos.isEmpty
          ? Center(
              child: Text("Dodaj zadania"),
            )
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (contex, index) => TodoWidget(
                todo: todos[index],
                removeTodo: (TodoModel todo) {
                  removeTodo(todo);
                },
                onTodoChange: (TodoModel todo) {
                  onTodoChange(todo);
                },
              ),
            ),
    );
  }
}
