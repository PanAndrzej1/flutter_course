import 'package:flutter/material.dart';

class TodoBottomSheet extends StatefulWidget {
  const TodoBottomSheet({super.key});

  @override
  State<TodoBottomSheet> createState() => _TodoBottomSheetState();
}

TextEditingController textControler = TextEditingController();
String? errorText;

// String? get _errorText{
//   final text=textControler.value.text;
//   if (text.isEmpty) {
//     return "Pole nie może być puste";
//   }
//   return null;
// }

class _TodoBottomSheetState extends State<TodoBottomSheet> {
  bool validate() {
    final text = textControler.value.text;
    if (text.isEmpty) {
      setState(() {
        errorText = "Pole nie może być puste";
      });
      return false;
    }
    setState(() {
      errorText = null;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Wrap(
        runSpacing: 30,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              controller: textControler,
              decoration: InputDecoration(
                hintText: "Co musisz zrobić?",
                labelText: "Dodaj element do listy spraw do załatwienia",
                errorText: errorText,
                border: OutlineInputBorder(),
              ),
              onChanged: (value){
                validate();
              },
              onEditingComplete: () {
                validate()?
                Navigator.pop(context, textControler.text):null;
                textControler.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
