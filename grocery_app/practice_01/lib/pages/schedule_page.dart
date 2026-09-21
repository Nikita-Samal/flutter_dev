import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FB),
      appBar: AppBar(
        title: Text("Appointments"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: 5,
        itemBuilder: (_, index) {
          return Card(
            margin: EdgeInsets.only(bottom: 18),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.medical_services),
              ),
              title: Text("Dr. Aditya Pattnaik"),
              subtitle: Text("Today • 4:30 PM"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      ),
    );
  }
}