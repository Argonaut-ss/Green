import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:green_app/Custom/bottom_navbar.dart';
import 'package:green_app/Pages/add_pesanan.dart';
import 'package:green_app/Pages/profile.dart';
import 'package:green_app/Pages/settings.dart';
import 'package:green_app/Pages/signin.dart';
import 'package:green_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Green App',
      home: user == null ? Signin() : CustomBottomNavBarPage(role: user.displayName ?? 'client'),
      routes: {
        '/signin': (context) => Signin(),
        '/settings': (context) => SettingsPage(),
        '/profile': (context) => ProfilePage(),
        '/addPesanan': (context) => const AddPesanan(),
      },
    );
  }
}