import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:green_app/Pages/edit_profile.dart';
import 'package:green_app/Theme/colors.dart';
import 'package:green_app/auth/google_auth.dart';
import 'package:green_app/controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseService firebaseService = FirebaseService();

  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final data = await firebaseService.getUserData();
    setState(() {
      userData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;
    final screenWidth = media.size.width;

    return Scaffold(
      backgroundColor: AppColors.primarywhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight, // agar bisa scroll semua konten
            child: Stack(
              children: [
                // Header Background
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/header_profile.png',
                    width: screenWidth,
                    height: screenHeight * 0.3,
                    fit: BoxFit.cover,
                  ),
                ),

                // Logout Button
                Positioned(
                  top: 32,
                  right: 16,
                  child: TextButton(
                    onPressed: () async {
                      await logout();
                      Navigator.pushReplacementNamed(context, '/signin');
                    },
                    child: Text(
                      "Log Out",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),

                // Content
                Positioned(
                  top: screenHeight * 0.22,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        // Avatar
                        isLoading
                            ? CircularProgressIndicator()
                            :  Column(
                          children: [
                            CircleAvatar(
                              radius: screenWidth * 0.15,
                              backgroundImage: NetworkImage(userData?['photoURL'] ?? 'https://static.vecteezy.com/system/resources/thumbnails/020/765/399/small_2x/default-profile-account-unknown-icon-black-silhouette-free-vector.jpg'),
                            ),
                            SizedBox(height: 12),

                            // Name, Role, Location
                            Text(
                              userData?['name'] ?? 'No Name',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              userData?['role'] ?? 'Client',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.location_on, size: 16, color: Colors.grey),
                                SizedBox(width: 4),
                                Text(
                                  userData?['location'] ?? 'Unknown',
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        // Edit Profile Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditProfile()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Edit profile",
                            style: TextStyle(color: AppColors.primarywhite),
                          ),
                        ),
                        SizedBox(height: 24),

                        // Contact Us Section
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Image.asset('assets/cp_icon.png', width: 24, height: 24),
                              SizedBox(width: 4),
                              Text(
                                "Contact Us",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),

                        // Contact Tiles
                        contactTile('assets/wa_icon.png', "0898989898"),
                        contactTile('assets/gmail_icon.png', "sasdsd@gmail.com"),
                        contactTile('assets/tnc_icon.png', "Terms & Condition"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
}

  /// Contact Tile Component
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
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
