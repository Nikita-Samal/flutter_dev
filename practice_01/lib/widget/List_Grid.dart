import 'package:flutter/material.dart';

class ListGrid extends StatefulWidget {
  const ListGrid({super.key});

  @override
  State<ListGrid> createState() => _ListGridState();
}

class _ListGridState extends State<ListGrid> {
  List<String> fruits = ['orange', 'mango','banana', 'apple'];
  Map fruits_person ={
    'fruits': ['orange', 'mango','papaya', 'apple'],
    'names' : ['karan', 'akshit','nikita', 'lucy']
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List and Grid"),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: Container(
        // child: ListView.builder(
        //   itemCount: fruits.length,
        //     itemBuilder: (context, index){
        //       return Card(
        //         child: ListTile(
        //           onTap: (){
        //             print((fruits_person['fruits'][index]));
        //           },
        //           leading: Icon(Icons.person),
        //           title: Text(fruits_person['fruits'][index]),
        //            subtitle: Text(fruits_person['names'][index]),
        //         ),
        //       );
        //     }
        // ),

        // child: GridView(gridDelegate: gridDelegate),
      ),
    );
  }
}
