import 'package:flutter/material.dart';
import 'package:green_app/Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:green_app/auth/google_auth.dart';

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

  FirebaseService firebaseService = FirebaseService();

  Map<String, dynamic>? userData;
  bool isLoading = true;

  Future<void> fetchUserData() async {
    final data = await firebaseService.getUserData();
    if (data != null) {
      setState(() {
        userData = data;
        nameController.text = data['name'] ?? "";
        phoneController.text = data['phone'] ?? "";
        emailController.text = data['email'] ?? "";
        addressController.text = data['address'] ?? "";
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  void initState() {
    super.initState();
    // Optional: isi default values
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;
    final screenWidth = media.size.width;

    return Scaffold(
      backgroundColor: AppColors.primarywhite,
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Stack(
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
                          backgroundImage: NetworkImage(userData?['photoURL'] ?? 'https://static.vecteezy.com/system/resources/thumbnails/020/765/399/small_2x/default-profile-account-unknown-icon-black-silhouette-free-vector.jpg'),
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

                    buildInputField(
                      "Name",
                      nameController,
                      hint: (userData?['name']?.isEmpty ?? true) ? "Nama Lengkap" : userData!['name'],
                    ),
                    buildInputField(
                      "Nomor Telepon",
                      phoneController,
                      keyboardType: TextInputType.phone,
                      hint: (userData?['phone']?.isEmpty ?? true) ? "Nomor Telepon" : userData!['phone'],
                    ),
                    buildInputField(
                      "Email",
                      emailController,
                      keyboardType: TextInputType.emailAddress,
                      hint: (userData?['email']?.isEmpty ?? true) ? "Email" : userData!['email'],
                    ),
                    buildInputField(
                      "Alamat",
                      addressController,
                      maxLines: 2,
                      hint: (userData?['location']?.isEmpty ?? true) ? "Alamat" : userData!['location'],
                    ),

                    SizedBox(height: 24,),

                    // Save Button
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          final firebaseService = FirebaseService();

                          bool success = await firebaseService.updateUserData(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                            location: addressController.text,
                          );

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Data berhasil diperbarui')),
                            );
                            Navigator.pop(context); // Kembali ke halaman profile
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Gagal memperbarui data')),
                            );
                          }

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
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

  Widget buildInputField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1, String hint = ""}) {
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
            hint: Text(hint),
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
