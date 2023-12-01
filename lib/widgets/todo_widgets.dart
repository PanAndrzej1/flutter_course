// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_course/models/todo_models.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({
    Key? key,
    required this.todo,
    required this.removeTodo,
    required this.onTodoChange,
  }) : super(key: key);
final TodoModel todo;
final void Function(TodoModel todo) removeTodo;
final void Function(TodoModel todo) onTodoChange;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: Checkbox(
            value: todo.isDone,
            onChanged: (value) {onTodoChange(todo);},
          ),
          title: Text(todo.text),
          trailing: IconButton(
              onPressed: () {removeTodo(todo);},
              icon: Icon(
                Icons.delete_forever_rounded,
                color: Colors.red,
              )),
        ),
      ),
    );
  }
}
