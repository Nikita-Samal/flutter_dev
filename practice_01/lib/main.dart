import 'package:flutter/material.dart';
import 'package:practice_01/widget/Container_Sized.dart';
import 'package:practice_01/widget/List_Grid.dart';
import 'package:practice_01/widget/alert_dialog_example.dart';
import 'package:practice_01/widget/button.dart';
import 'package:practice_01/widget/dismissible_widget.dart';
import 'package:practice_01/widget/drawer_example.dart';
import 'package:practice_01/widget/rowscols.dart';
import 'package:practice_01/widget/snackbarwidget.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.deepPurple
      ),
      home:
      // ContainerSized(),
      // Rowscols(),
      // Button(),
      // ListGrid(),
      // Snackbarwidget()
      // DismissibleWidget(),
      DrawerExample(),
      // AlertDialogExample(),
    );
  }
}
