import 'package:flutter/material.dart';
import 'package:green_app/Theme/colors.dart';
import 'package:flutter/cupertino.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bagian atas dengan background hijau dan avatar
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
              left: 0,
              right: 0,
              child: Image.asset('assets/header_profile.png')),
          Positioned(
            top: 40,
            right: 16,
            child: TextButton(onPressed: (){}, child: Text("Log Out", style: TextStyle(color: Colors.white, fontSize: 16))),
          ),
          Positioned.fill(
            top: 160,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/profile_img.png'), // ganti dengan image kamu
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
                            borderRadius: BorderRadius.circular(12))),
                    child: Text("Edit profile", style: TextStyle(color: AppColors.primarywhite),),
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/cp_icon.png', width: 24, height: 24),
                            SizedBox(width: 4),
                            Text("Contact Us",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                        SizedBox(height: 16),
                        contactTile('assets/wa_icon.png', "0898989898"),
                        contactTile('assets/gmail_icon.png', "sasdsd@gmail.com"),
                        contactTile('assets/tnc_icon.png', "Terms & Condition"),
                      ],
                    ),
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }

  Widget contactTile(String img, String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset(img, width: 24, height: 24),
          SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
