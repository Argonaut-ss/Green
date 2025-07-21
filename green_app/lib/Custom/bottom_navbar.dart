import 'package:flutter/material.dart';
import 'package:green_app/Pages/add_pesanan.dart';
import 'package:green_app/Pages/dashboard.dart';
import 'package:green_app/Pages/location.dart';
import 'package:green_app/Pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:green_app/Theme/colors.dart';

class CustomBottomNavBarPage extends StatefulWidget {
  const CustomBottomNavBarPage({Key? key}) : super(key: key);

  @override
  _CustomBottomNavBarPageState createState() => _CustomBottomNavBarPageState();
}

class _CustomBottomNavBarPageState extends State<CustomBottomNavBarPage> {
  int currentIndex = 0;

  final screens = [
    const Dashboard(),
    const AddPesanan(),
    const ProfilePage(),
    const LocationPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: AppColors.secondaryColor,
        selectedItemColor: AppColors.secondaryColor,
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house),
              label: 'Home',
              activeIcon: Icon(
                  CupertinoIcons.house_fill),
            ),
            BottomNavigationBarItem(
              label: 'Add',
              icon: Icon(CupertinoIcons.plus_app),
              activeIcon: Icon(
                  CupertinoIcons.plus_app_fill),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(CupertinoIcons.person),
              activeIcon: Icon(
                  CupertinoIcons.person_fill),
            ),
            BottomNavigationBarItem(
              label: 'Location',
              icon: Icon(CupertinoIcons.location_solid),
              activeIcon: Icon(
                  CupertinoIcons.location_solid),
            ),
          ]
      ),
    );
  }
}