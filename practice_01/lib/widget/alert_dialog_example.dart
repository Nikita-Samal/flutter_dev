import 'package:flutter/material.dart';

class AlertDialogExample extends StatelessWidget {
  const AlertDialogExample({super.key});

  void showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow:  [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 25,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffFF6B6B),
                        Color(0xffFF3B3B),
                      ],
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: const Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Delete Item",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                 Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 20,
                  ),
                  child: Text(
                    "Are you sure you want to permanently delete this item?\n\nThis action cannot be undone.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ),

                 Divider(height: 1),

                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 50),
                            side: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(0, 50),
                            elevation: 8,
                            shadowColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Item deleted successfully"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                          icon: const Icon(Icons.delete),
                          label: const Text(
                            "Delete",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.red,
        title: const Text(
          "Alert Dialog",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 35,
              vertical: 16,
            ),
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            showMyDialog(context);
          },
          icon: const Icon(Icons.warning_amber_rounded),
          label: const Text(
            "Show Dialog",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}