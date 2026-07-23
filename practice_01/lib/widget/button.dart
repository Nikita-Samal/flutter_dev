import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Button Widget"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
                overlayColor: WidgetStatePropertyAll(Colors.black),
                elevation: WidgetStatePropertyAll(20),
                backgroundColor: WidgetStateProperty.all(Colors.yellow)
              ),

                onPressed: (){},
                child:Text("Press me")
            ),
            SizedBox(height: 10,),

            Container(
              child: ElevatedButton(
                  onPressed: (){
                    print("Like");
                  },
                  child: Text("Press me"),
                 style: ButtonStyle(
                   backgroundColor: WidgetStatePropertyAll(Colors.blue),
                   shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
                 ),
                  
              ),
            )
          ],

        ),
      ),
    );
  }
}
