import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_app/Pages/add_pesanan.dart';
import 'package:green_app/Pages/admin/admin_dashboard.dart';
import 'package:green_app/Pages/dashboard.dart';
import 'package:green_app/Pages/location.dart';
import 'package:green_app/Pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:green_app/Pages/settings.dart';
import 'package:green_app/Theme/colors.dart';

class CustomBottomNavBarPage extends StatefulWidget {
  final String role;
  CustomBottomNavBarPage({Key? key, required this.role}) : super(key: key);

  @override
  _CustomBottomNavBarPageState createState() => _CustomBottomNavBarPageState();
}

class _CustomBottomNavBarPageState extends State<CustomBottomNavBarPage> {
  int currentIndex = 0;

  List<Widget> get screens => [
    widget.role == "client" ? Dashboard() : AdminDashboard(),
    const SettingsPage(),
    const AddPesanan(),
    const LocationPage(),
    const ProfilePage()
  ];

  @override
  void initState() {
    super.initState();
    if (widget.role == "penjual") {
      _fetchAdminRole();
    }
  }

  Stream<QuerySnapshot> _fetchAdminRole([String? role]) {
    var collection = FirebaseFirestore.instance.collection('users');

    // Get current user ID
    User? currentUser = FirebaseAuth.instance.currentUser;
    String? userId = currentUser?.uid;

    if (userId == null) {
      return Stream.empty();
    }

    // Start with user filter
    Query query = collection.where('userId', isEqualTo: userId);

    // Add category filter if provided
    if (role != null && role.isNotEmpty) {
      query = query.where('role', isEqualTo: role);
    }

    return query.snapshots();
  }


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
      bottomNavigationBar: Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 70),
            painter: BottomNavBarBorderPainter(
              notchedShape: CustomCircularNotchedRectangle(),
              borderColor: Colors.grey,
              borderWidth: 1.0,
            ),
          ),
          BottomAppBar(
            shape: CustomCircularNotchedRectangle(),
            notchMargin: 6,
            height: 70,
            color: AppColors.primarywhite,
            elevation: 0, // remove shadow for better custom border
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
                    color: currentIndex == 3 ? AppColors.secondaryColor : AppColors.primaryColor,
                  ),
                  onPressed: () => setState(() => currentIndex = 3),
                ),
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
        ],
      ),

    );
  }
}

class CustomCircularNotchedRectangle extends NotchedShape {
  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) {
      return Path()..addRect(host);
    }

    final notchRadius = 30;
    const notchMargin = 8.0;
    final r = notchRadius + notchMargin;

    final notchCenterX = guest.center.dx;

    final s1 = 20.0;
    final s2 = 5.0;

    final Path path = Path()
      ..moveTo(host.left, host.top)
      ..lineTo(notchCenterX - r - s1, host.top)
      ..quadraticBezierTo(
        notchCenterX - r - s2, host.top,
        notchCenterX - r, host.top + s2,
      )
      ..arcToPoint(
        Offset(notchCenterX + r, host.top + s2),
        radius: Radius.circular(r),
        clockwise: false,
      )
      ..quadraticBezierTo(
        notchCenterX + r + s2, host.top,
        notchCenterX + r + s1, host.top,
      )
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();

    return path;
  }
}




class BottomNavBarBorderPainter extends CustomPainter {
  final NotchedShape notchedShape;
  final Color borderColor;
  final double borderWidth;

  BottomNavBarBorderPainter({
    required this.notchedShape,
    this.borderColor = Colors.black,
    this.borderWidth = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final host = Offset.zero & size;
    final guest = Rect.fromCircle(
      center: Offset(size.width / 2, 0), // FAB position (center top)
      radius: 30, // Same as FAB radius
    );

    final path = notchedShape.getOuterPath(host, guest);

    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

