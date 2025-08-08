import 'package:flutter/material.dart';
import 'package:green_app/Theme/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Optional: isi default values
    nameController.text = "Muhammad Samy Syafta";
    phoneController.text = "088888888888";
    emailController.text = "user@gmail.com";
    addressController.text = "Jl. Pondok Petir no 47 bla bla bla...";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarywhite,
      body: Stack(
        children: [
          // Bagian hijau atas
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset('assets/header_ep.png')),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 0, left: 16, right: 16),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: AppColors.primarywhite),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Center(
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                            color: AppColors.primarywhite,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/profile_img.png'), // Ganti dengan gambar kamu
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.green,
                          child: Icon(Icons.camera_alt, color: Colors.white, size: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  buildInputField("Name", nameController),
                  buildInputField("Nomor Telepon", phoneController, keyboardType: TextInputType.phone),
                  buildInputField("Email", emailController, keyboardType: TextInputType.emailAddress),
                  buildInputField("Alamat", addressController, maxLines: 2),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Simpan data
                      print("Saved");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                    ),
                    child: Text("save", style: TextStyle(fontSize: 16, color: AppColors.primarywhite)),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInputField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
