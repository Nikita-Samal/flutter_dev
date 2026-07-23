// import 'package:flutter/material.dart';
//
// class DismissibleWidget extends StatefulWidget {
//   const DismissibleWidget({super.key});
//
//   @override
//   State<DismissibleWidget> createState() => _DismissibleWidgetState();
// }
//
// class _DismissibleWidgetState extends State<DismissibleWidget> {
//   List<String> fruits = ['orange', 'mango','banana', 'apple'];
//   Map fruits_person ={
//     'fruits': ['orange', 'mango','papaya', 'apple'],
//     'names' : ['karan', 'akshit','nikita', 'lucy']
//   };
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dismissible Package'),
//         backgroundColor: Colors.brown,
//       ),
//         body: Container(
//           child: ListView.builder(
//             itemCount: fruits.length,
//               itemBuilder: (context, index){
//               final fruit = fruits[index];
//               return Dismissible(
//                   onDismissed: (direction){
//                     if(direction)==DismissDirection.startToEnd{
//                       ScaffoldMessenger.of(context).showSnackBar(snackBar(context:Text()))
//                     }
//                   },
//                   key: Key(fruit), child: child)
//                 // return Card(
//                 //   child: ListTile(
//                 //     onTap: (){
//                 //       print((fruits_person['fruits'][index]));
//                 //     },
//                 //     leading: Icon(Icons.person),
//                 //     title: Text(fruits_person['fruits'][index]),
//                 //      subtitle: Text(fruits_person['names'][index]),
//                 //   ),
//                 );
//               }
//           ),
//         ),
//     );
//   }
// }
