import 'package:flutter/material.dart';
import 'package:practice_01/pages/chat_page.dart';
import 'package:practice_01/pages/health_page.dart';
import 'package:practice_01/pages/profile_page.dart';
import 'package:practice_01/pages/schedule_page.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FB),
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            buildSearchBar(),
            SizedBox(height: 25),
            buildSectionTitle("Health Overview"),
            SizedBox(height: 15),
            buildHealthOverview(),
            SizedBox(height: 25),
            buildSectionTitle("Upcoming Appointment"),
            SizedBox(height: 15),
            buildAppointmentCard(),
            SizedBox(height: 25),
            buildSectionTitle("Quick Actions"),
            SizedBox(height: 15),
            buildQuickActions(),
            SizedBox(height: 25),
            buildHealthTip(),
            SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }
  // AppBar
  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xffF5F7FB),
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xffE8F3F1),
            child: Icon(
              Icons.person,
              color: Color(0xff0F9D8A),
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Back",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
              Text(
                "Nikita",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
              )
            ],
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none),
          ),
        ),
      ],
    );
  }
  Widget buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search doctor, medicine...",
          prefixIcon: Icon(Icons.search),
          suffixIcon: Icon(Icons.tune),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
  // Section Title
  Widget buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text("See All"),
        )
      ],
    );
  }
  // Health Overview
  Widget buildHealthOverview() {
    return Row(
      children: [
        Expanded(
          child: buildHealthCard(
            "Heart Rate",
            "98 bpm",
            Icons.favorite,
            Colors.red,
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: buildHealthCard(
            "Steps",
            "7500",
            Icons.directions_walk,
            Colors.green,
          ),
        ),
      ],
    );
  }
  Widget buildHealthCard(
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(.15),
            child: Icon(
              icon,
              color: color,
            ),
          ),

          SizedBox(height: 20),

          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 5),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
  // Appointment Card
  Widget buildAppointmentCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff23B6A6),
            Color(0xff0F8F8C),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [

          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.medical_services,
              color: Color(0xff0F8F8C),
              size: 32,
            ),
          ),

          SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Dr. Aditya Pattnaik",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  "Cardiologist",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),

                SizedBox(height: 12),

                Row(
                  children: [
                    Icon(Icons.access_time,
                        color: Colors.white,
                        size: 18),
                    SizedBox(width: 6),
                    Text(
                      "Today • 4:30 PM",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),

          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
  // Quick Actions
  Widget buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildAction(Icons.calendar_today, "Appointment"),
        buildAction(Icons.medication, "Medicine"),
        buildAction(Icons.analytics, "Reports"),
        buildAction(Icons.local_hospital, "Doctors"),
      ],
    );
  }
  Widget buildAction(
      IconData icon,
      String title,
      ) {
    return Column(
      children: [

        Container(
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Color(0xff0F9D8A),
            size: 30,
          ),
        ),

        SizedBox(height: 10),

        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
  // Health Tip
  Widget buildHealthTip() {
    return Container(
      padding: EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [
            Color(0xff5B8DEF),
            Color(0xff6D5FFD),
          ],
        ),
      ),
      child: Row(
        children: [

          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white24,
            child: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),

          SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Today's Health Tip",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "Drink 8 glasses of water and walk for at least 20 minutes today.",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  // Bottom Navigation Bar
  Widget buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xff0F9D8A),
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        switch (index) {
          case 0:
            break;

          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HealthPage(),
              ),
            );
            break;

          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SchedulePage(),
              ),
            );
            break;

          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatPage(),
              ),
            );
            break;

          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfilePage(),
              ),
            );
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: "Health",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: "Schedule",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: "Chat",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Profile",
        ),
      ],
    );
  }
}