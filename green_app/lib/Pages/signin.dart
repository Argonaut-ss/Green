import 'package:flutter/material.dart';
import 'package:green_app/Custom/bottom_navbar.dart';
import 'package:green_app/Custom/custom_decoration_field.dart';
import 'package:green_app/Pages/dashboard.dart';
import 'package:green_app/Pages/signup.dart';
import 'package:green_app/controller.dart';
import 'package:green_app/auth/google_auth.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool _obscurePassword = true;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _signInController = SignInController();

  String? _errorMessage;

  void _signIn() async {
    final result = await _signInController.signInWithEmail(
      _emailController.text,
      _passwordController.text,
    );
    if (result.userCredential != null) {
      // Fetch role from Firestore, not from profile
      String userRole = await FirebaseService().getUserRole();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign in successful!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomBottomNavBarPage(role: userRole)),
      );
      setState(() {
        _errorMessage = null;
      });
    } else {
      setState(() {
        _errorMessage = result.errorMessage;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // biar scrollable pas keyboard muncul
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const Signup()),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(top: 8.0, right: 2.0),
                              child: Text(
                                'Sign Up',
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
                      const SizedBox(height: 80),
                      Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/washing_machine_logo.png',
                              height: 133,
                              width: 120,
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
                      ),
                      const SizedBox(height: 36),
                      TextField(
                        controller: _emailController,
                        decoration: customInputDecoration(
                          hint: 'Email',
                          iconPath: 'assets/email_icon.png',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _passwordController,
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
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: TextButton(
                          onPressed: () {
                            // handle forgot password
                          },
                          child: const Text(
                            "Lupa Kata Sandi",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff168934),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("Atau", style: TextStyle(color: Colors.grey)),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 36),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // handle Apple sign in
                            },
                            child: Image.asset(
                              'assets/apple_logo.png',
                              width: 36,
                              height: 36,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final firebaseService = FirebaseService();
                              bool isAutoLogged = await firebaseService.autoSignInWithGoogle();
                              String userRole = 'client';

                              if (isAutoLogged) {
                                userRole = await firebaseService.getUserRole();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => CustomBottomNavBarPage(role: userRole)),
                                );
                              } else {
                                bool isLogged = await firebaseService.signinWithGoogle();
                                if (isLogged) {
                                  userRole = await firebaseService.getUserRole();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => CustomBottomNavBarPage(role: userRole)),
                                  );
                                }
                              }
                            },
                            child: Image.asset(
                              'assets/google_logo.png',
                              width: 36,
                              height: 36,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // handle FB sign in
                            },
                            child: Image.asset(
                              'assets/fb_logo.png',
                              width: 36,
                              height: 36,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
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
            onPressed: () {
              setState(() {
                _signIn();
              });
            },
            child: const Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}