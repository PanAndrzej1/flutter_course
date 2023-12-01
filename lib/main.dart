import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_course/models/todo_models.dart';
import 'package:flutter_course/widgets/todo_botton_sheet.dart';
import 'package:flutter_course/widgets/todo_widgets.dart';

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

  void addTodoItem() {
    // setState(() {
    //   todos.add(TodoModel(text: "Todo numer: $todoNumber"));
    // });
    // todoNumber++;

    showModalBottomSheet(context: context, builder: (context)=>TodoBottomSheet()).then((value) => print(value));
  }
  void removeTodo(TodoModel todo){
    setState(() {
      todos.removeWhere((element) => element.text==todo.text);//to do zmiany bo bedzie usuwać wszystko co ma taki sam tekst
    });
  }

void onTodoChange(TodoModel todo){
  setState(() {
    todo.isDone=!todo.isDone;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: Text("To do"),
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
                removeTodo: (TodoModel todo) {removeTodo(todo);},
                onTodoChange: (TodoModel todo) {onTodoChange(todo);},
              ),
            ),
    );
  }
}
