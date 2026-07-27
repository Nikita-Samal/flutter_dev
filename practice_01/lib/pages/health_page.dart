import 'package:flutter/material.dart';

class HealthPage extends StatelessWidget {
  HealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FB),
      appBar: AppBar(
        title: Text("Health"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [

          _buildCard(
            "Heart Rate",
            "98 bpm",
            Icons.favorite,
            Colors.red,
          ),

          SizedBox(height: 20),

          _buildCard(
            "Blood Pressure",
            "120/80",
            Icons.monitor_heart,
            Colors.blue,
          ),

          SizedBox(height: 20),

          _buildCard(
            "Weight",
            "58 kg",
            Icons.monitor_weight,
            Colors.orange,
          ),

          SizedBox(height: 20),

          _buildCard(
            "Calories",
            "1640 kcal",
            Icons.local_fire_department,
            Colors.deepOrange,
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [

          CircleAvatar(
            radius: 28,
            backgroundColor: color.withOpacity(.15),
            child: Icon(icon, color: color),
          ),

          SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 6),
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}