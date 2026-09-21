import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  const new({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {

  final todoTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('"ADD TODO'),

      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: todoTitleController,
              decoration: InputDecoration(
                hintText: 'Title'

              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () {},
             child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}