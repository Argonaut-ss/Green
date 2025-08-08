import 'package:flutter/material.dart';
import 'package:green_app/Theme/colors.dart';
import 'package:flutter/cupertino.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;
    final screenWidth = media.size.width;

    return Scaffold(
      backgroundColor: AppColors.primarywhite,
      body: SafeArea(
        child: Stack(
          children: [
            // Header Image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/header_ep.png',
                width: screenWidth,
                height: screenHeight * 0.22,
                fit: BoxFit.cover,
              ),
            ),

            Positioned(
              top: 32,
              left: 0,
              right: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Judul di tengah
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Tombol back di kiri
                  Positioned(
                    left: 16,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),


            // Scrollable Content
            Positioned.fill(
              top: screenHeight * 0.14,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Avatar
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: screenWidth * 0.15,
                          backgroundImage: AssetImage('assets/profile_img.png'),
                        ),
                        Positioned(
                          bottom: -10,
                          right: 0,
                          child: CircleAvatar(
                            radius: screenWidth * 0.05,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(CupertinoIcons.camera, size: 20, color: AppColors.primaryColor),
                              onPressed: () {
                                // Handle change avatar logic
                              },
                            ),
                          ),
                        ),
                      ]
                    ),
                    SizedBox(height: 16),

                    // Edit Profile Title
                    Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 24),

                    // Example Form Field (You can add more here)
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email Address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    SizedBox(height: 32),

                    // Save Button
                    ElevatedButton(
                      onPressed: () {
                        // Handle save logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.2,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Save",
                        style: TextStyle(color: AppColors.primarywhite),
                      ),
                    ),

                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
