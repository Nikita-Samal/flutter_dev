import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nikita Grocery App'),
      ),
      body: Center(
        child: Text('Welcome to Nikita Grocery App!'),
      )
    );
  }
}
