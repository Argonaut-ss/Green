import 'package:flutter/material.dart';
import 'package:green_app/Custom/custom_decoration_field.dart';
import 'package:green_app/Pages/signin.dart';
import 'package:green_app/controller.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _obscurePassword = true;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

  final SignupController _signupController = SignupController();

  bool _isLoading = false;

  void _handleSignup() async {
    setState(() {
      _isLoading = true;
    });
    final error = await _signupController.signUpWithEmail(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      phone: _phoneController.text.trim(),
    );
    setState(() {
      _isLoading = false;
    });
    if (error == null) {
      // Success: Navigate or show success message
      // Use context from inside the Scaffold
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign up successful!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Signin()),
      );
    } else {
      // Error: Show error message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Signin()),
                                  );
                                },
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
                          const SizedBox(height: 80),
                          Column(
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
                          const SizedBox(height: 36),
                          TextField(
                            controller: _nameController,
                            decoration: customInputDecoration(
                              hint: 'Nama Lengkap',
                              iconPath: 'assets/user_profile_icon.png',
                            ),
                          ),
                          const SizedBox(height: 12),
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
                                icon: Image.asset(
                                  'assets/eye_icon.png',
                                  height: 20,
                                  width: 20,
                                ),
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
                            controller: _phoneController,
                            decoration: customInputDecoration(
                              hint: 'No Telp',
                              iconPath: 'assets/phone_icon.png',
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
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
                                onPressed: _isLoading ? null : _handleSignup,
                                child: _isLoading
                                    ? CircularProgressIndicator(color: Colors.white)
                                    : const Text(
                                  'sign up',
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
                  ),
                ),
              );
            },
          ),
        ));
        }
}
