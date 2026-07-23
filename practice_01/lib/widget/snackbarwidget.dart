import 'package:flutter/material.dart';

class Snackbarwidget extends StatelessWidget {
  const Snackbarwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SnackBar'),
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        child: Center(
          child:
          ElevatedButton(
              onPressed: () {
            final snackbar = SnackBar(
              duration: const Duration(milliseconds: 500),
              content: Text('This is an arror'),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          },
              child: Text('Show Snackbar',)
          ),
        ),
      ),
    );
  }
}
