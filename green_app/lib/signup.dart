import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _obscurePassword = true;

  InputDecoration customInputDecoration({required String hint, required String iconPath, Widget? suffixIcon}) {
    return InputDecoration(
      prefixIcon: Image.asset(iconPath, height: 20, width: 20),
      prefixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 20),
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 1, color: Color(0xFFBDBDBD)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 1, color: Color(0xFFBDBDBD)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 1.2, color: Color(0xFF2ECC40)),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      suffixIcon: suffixIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    // Baris atas untuk Sign In pojok kanan
                    const SizedBox(height: 36),
                    Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(top: 8.0, right: 2.0),
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Color(0xFF2ECC40),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Spacer untuk mendorong logo ke tengah
                    const SizedBox(height: 80),
                    // Logo dan teks 'green'
                    Column(
                      children: [
                        Image.asset(
                          'assets/washing_machine_logo.png',
                          height: 140,
                          width: 140,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'green',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2ECC40),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),
                    // Form input
                    TextField(
                      decoration: customInputDecoration(
                        hint: 'Nama Lengkap',
                        iconPath: 'assets/user_profile_icon.png',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: customInputDecoration(
                        hint: 'Email',
                        iconPath: 'assets/email_icon.png',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      obscureText: _obscurePassword,
                      decoration: customInputDecoration(
                        hint: 'Kata Sandi',
                        iconPath: 'assets/lock_icon.png',
                        suffixIcon: IconButton(
                          icon: Image.asset('assets/eye_icon.png', height: 20, width: 20),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: customInputDecoration(
                        hint: 'No Telp',
                        iconPath: 'assets/phone_icon.png',
                      ),
                    ),
                    // Spacer agar tombol selalu di bawah
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2ECC40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'sign in',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}