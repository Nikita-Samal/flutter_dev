import 'package:flutter/material.dart';

class Rowscols extends StatelessWidget {
  const Rowscols({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Rows And Colums")
      ),
      body: Container(
        height: 200,
        width: 200,
        color: Colors.yellow,
        child: Center(
          child:

          Wrap(
            // mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(height: 60, width: 60,color: Colors.red,),
              Container(height: 60, width: 60,color: Colors.blue,),
              Container(height: 60, width: 60,color: Colors.black,),
              Container(height: 60, width: 60,color: Colors.green,),
              Container(height: 60, width: 60,color: Colors.purple,),

            ],
          ),
        ),
      ),
    );
  }
}
