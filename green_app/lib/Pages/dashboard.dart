import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_app/Custom/pesanan_card.dart';
import 'package:green_app/Pages/pesanan_list.dart';
import 'package:green_app/Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:green_app/controller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  Widget buildPesananList() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Text('Not signed in');
    }
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('pesanan')
          .where('userId', isEqualTo: user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No pesanan found');
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final data = snapshot.data!.docs[index];
            return PesananCard(
              namaPesanan: data['namaPesanan'] ?? '',
              status: data['status'] ?? '',
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(bottom: 35), // Add padding to avoid FAB overlay
        children: [
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(color: AppColors.primaryColor),
            height: 225,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Location', style: TextStyle(color: AppColors.primarywhite, fontWeight: FontWeight.w500, fontSize: 16),),
                    IconButton(
                      icon: Icon(Icons.notifications, color: AppColors.primarywhite, size: 24,),
                      onPressed: () {},
                    )
                  ],
                ),
                SizedBox(height: 18,),
                Row(
                  children: [
                    Icon(CupertinoIcons.location_solid, color: Colors.yellow,),
                    SizedBox(width: 8,),
                    Text('Your Location', style: TextStyle(fontSize: 16, color: AppColors.primarywhite),)
                  ],
                ),
                SizedBox(height: 28,),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'cari',
                    prefixIcon: Icon(CupertinoIcons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 19),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Jasa', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
                SizedBox(height: 26,),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to laundry service page
                          print('Cuci tapped');
                        },
                        child: Container(
                          height: 160,
                          decoration: BoxDecoration(
                            color: Color(0xFFE8F5E8), // Light green background
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                 'assets/dashboard_wash_icon.png',
                                 width: 200,
                                 height: 120,
                                 fit: BoxFit.contain,
                               ),
                              SizedBox(height: 1),
                              Text(
                                'Cuci',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to ironing service page
                          print('Setrika tapped');
                        },
                        child: Container(
                          height: 160,
                          decoration: BoxDecoration(
                            color: Color(0xFFE8F5E8), // Light green background
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                 'assets/dashboard_ironing_icon.png',
                                 width: 200,
                                 height: 120,
                                 fit: BoxFit.contain,
                               ),
                              SizedBox(height: 1),
                              Text(
                                'Setrika',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 26,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Jasa Popular', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
                SizedBox(height: 26,),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){},
                          child: SizedBox(
                            height: 140,
                            width: 268,
                            child: Stack(
                              children: [
                                Image.asset('assets/nyetrika.png', fit: BoxFit.cover, width: 268, height: 140,),
                                Padding(padding: EdgeInsets.all(16),
                                  child: Container(
                                    height: 33,
                                    width: 59,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.primarywhite
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('4.5', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                                        SizedBox(width: 4),
                                        Icon(CupertinoIcons.star_fill, color: Colors.yellow, size: 16,),
                                      ],
                                    ),
                                  ),
                                ),
                              ]
                            ),
                          ),
                        ),
                        SizedBox(width: 14,),
                        GestureDetector(
                          onTap: (){},
                          child: SizedBox(
                            height: 140,
                            width: 268,
                            child: Stack(
                                children: [
                                  ClipRRect(
                                      child: Image.asset('assets/nyuci.png', fit: BoxFit.cover, width: 268, height: 140,),
                                  borderRadius: BorderRadius.circular(15),
                                  ),
                                  Padding(padding: EdgeInsets.all(16),
                                    child: Container(
                                      height: 33,
                                      width: 59,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColors.primarywhite
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('4.9', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                                          SizedBox(width: 4),
                                          Icon(CupertinoIcons.star_fill, color: Colors.yellow, size: 16,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ),
                      ],
                    ),)
              ],
            ),
          ),
          SizedBox(height: 26,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Pesanan', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
                    Spacer(),
                    TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> PesananList()));
                      },
                      child: Text('Lihat Semua', style: TextStyle(fontSize: 14, color: AppColors.primaryColor),),
                    )
                  ],
                ),
                SizedBox(height: 26,),
                SizedBox(
                  height: 200,
                  child: buildPesananList(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
