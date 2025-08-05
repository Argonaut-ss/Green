import 'package:flutter/material.dart';
import 'package:green_app/Pages/add_pesanan.dart';
import 'package:green_app/Pages/dashboard.dart';
import 'package:green_app/Pages/location.dart';
import 'package:green_app/Pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:green_app/Pages/settings.dart';
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
    const SettingsPage(),
    const AddPesanan(),
    const LocationPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addPesanan');
        },
        backgroundColor: AppColors.secondaryColor,
        elevation: 4,
        shape: CircleBorder(),
        child: Icon(CupertinoIcons.plus_app, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: screens[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomAppBar(
          shape: SmoothNotchedShape(),
          height: 70,
          notchMargin: 5,
          color: Color(0xffFFFFF),
          elevation: 1,
          shadowColor: Color(0xff000000).withOpacity(0.1),
          surfaceTintColor: Color(0xffFFFFF),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  CupertinoIcons.house,
                  color: currentIndex == 0 ? AppColors.secondaryColor : AppColors.primaryColor,
                ),
                onPressed: () => setState(() => currentIndex = 0),
              ),
              IconButton(
                icon: Icon(
                  CupertinoIcons.gear,
                  color: currentIndex == 1 ? AppColors.secondaryColor : AppColors.primaryColor,
                ),
                onPressed: () => setState(() => currentIndex = 1),
              ),
              SizedBox(width: 48),
              IconButton(
                icon: Icon(
                  CupertinoIcons.location_solid,
                  color: currentIndex == 3? AppColors.secondaryColor : AppColors.primaryColor,
                ),
                onPressed: () => setState(() => currentIndex = 3),
              ),// Space for the floating action button
              IconButton(
                icon: Icon(
                  CupertinoIcons.person,
                  color: currentIndex == 4 ? AppColors.secondaryColor : AppColors.primaryColor,
                ),
                onPressed: () => setState(() => currentIndex = 4),
              ),

            ],
          ),
        ),
      )
    );
  }
}

class SmoothNotchedShape extends NotchedShape {
  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null) return Path()..addRect(host);

    final double notchRadius = guest.width / 2.0;
    final double s1 = 15.0;
    final double s2 = 1.0;

    final double r = notchRadius;
    final double a = -1.0 * r - s2;
    final double b = host.top;

    final Path path = Path()
      ..moveTo(host.left, host.top)
      ..lineTo(guest.center.dx + a, host.top);

    final Rect notchRect = Rect.fromCircle(center: guest.center, radius: r + s1);

    path.arcTo(notchRect, 3.14, -3.14, false);

    path
      ..lineTo(guest.center.dx - a, host.top)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();

    return path;
  }
}
