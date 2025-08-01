import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:green_app/Custom/custom_decoration_field.dart';
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

  final AddPesananAPI addPesananAPI = AddPesananAPI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Column(
                        children: [
                          Image.asset('assets/laundry_icon.png', width: 71, height: 71),
                          SizedBox(height: 4,),
                          Text('Cuci', style: TextStyle(fontSize: 15),)
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    GestureDetector(
                      onTap: (){},
                      child: Column(
                        children: [
                          Image.asset('assets/iron_icon.png', width: 71, height: 71),
                          SizedBox(height: 4),
                          Text('Setrika', style: TextStyle(fontSize: 15),)
                        ],
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
                PesananCard(namaPesanan: 'Nama Pesanan', status: 'Bentar')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
