import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Bagian atas dengan background hijau dan avatar
      body: Stack(
        children: [
          Container(
            height: 250,
            color: Colors.green,
          ),
          Positioned(
            top: 40,
            left: 16,
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: Text("Log Out",
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile.jpg'), // ganti dengan image kamu
                ),
                SizedBox(height: 12),
                Text("Melissa peters",
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text("Interior designer",
                    style: TextStyle(color: Colors.grey.shade600)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text("Lagos, Nigeria",
                        style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text("Edit profile"),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Contact Us",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 16),
                      contactTile(Icons.chat, "0898989898"),
                      contactTile(Icons.email, "sasdsd@gmail.com"),
                      contactTile(Icons.description, "Terms & Condition"),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),

      // FAB dan Bottom Navigation
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.home, color: Colors.green),
              Icon(Icons.settings, color: Colors.green),
              SizedBox(width: 40), // untuk notch FAB
              Icon(Icons.location_on, color: Colors.green),
              Icon(Icons.person, color: Colors.green),
            ],
          ),
        ),
      ),
    );
  }

  Widget contactTile(IconData icon, String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
