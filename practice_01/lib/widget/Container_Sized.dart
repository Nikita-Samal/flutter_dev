import 'package:flutter/material.dart';
 class ContainerSized extends StatelessWidget {
   const ContainerSized({super.key});
 
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.blueAccent,
         title: Text("Container and SizedBox"),
       ),
       body:
         Center(
           child: Container(
             height: 100,
             width: 100,
             decoration: BoxDecoration(
                 color: Colors.indigo,
                 // shape: BoxShape.circle,
                 // borderRadius: BorderRadius.circular(20)
               borderRadius:  BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                 boxShadow: [
                   BoxShadow(
                     blurRadius: 5,
                     spreadRadius: 5,
                     color: Colors.black
                 )]
             ),
             child: Center(child: Text("Nikita", style: TextStyle(fontSize: 20),)),
             // color: Colors.deepPurple,
           ),
         )
       // Center(
       //   child: SizedBox(
       //     height: 50,
       //     width: 50,
       //     child: Text("Nikita"),
       //   ),
       // ),
     );
   }
 }
 