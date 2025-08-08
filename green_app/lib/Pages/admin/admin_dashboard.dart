import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_app/Custom/pesanan_card.dart';
import 'package:green_app/Pages/pesanan_list.dart';
import 'package:green_app/Theme/colors.dart';
import 'package:flutter/cupertino.dart';

class AdminDashboard extends StatefulWidget {
  final void Function(Map<String, dynamic> article)? onPesananTap;
  const AdminDashboard({super.key, this.onPesananTap});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  Stream<QuerySnapshot> _getPesananStream([String? deliv, String? status]) {
    CollectionReference collection = FirebaseFirestore.instance.collection('pesanan');
    Query query = collection;

    if (deliv != null && deliv.isNotEmpty) {
      query = query.where('deliv', isEqualTo: deliv);
    }
    if (status != null && status.isNotEmpty) {
      query = query.where('status', isEqualTo: status);
    }

    return query.snapshots();
  }

  Widget buildPesananList(Stream<QuerySnapshot> stream) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // Check if user is logged in
        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser == null) {
          return Center(child: Text('Silakan login terlebih dahulu untuk melihat pesanan Anda.'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Tidak ada pesanan yang ditemukan.'));
        }
        final docs = snapshot.data!.docs;
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: GestureDetector(
                onTap: () {
                  widget.onPesananTap?.call({
                    'namaPesanan': data['namaPesanan'] ?? 'No Pesanan Name',
                    'alamat': data['alamat'] ?? 'No Address',
                    'catatan': data['catatan'] ?? 'No notes available.',
                    'deliv': data['deliv'] ?? 'Unknown',
                    'jasa': data['jasa'] ?? 'Unknown.',
                    'status': data['status'] ?? 'Not Ready',
                  });
                },
                child: PesananCard(
                  namaPesanan: data['namaPesanan'] ?? 'Gada',
                  status: data['status'] ?? 'Not Ready',
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSectionedPesananList(String deliveryType) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pesanan Masuk", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey[600])),
              Spacer(),
              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PesananList()));
                },
                child: Text('Lihat Semua', style: TextStyle(fontSize: 14, color: AppColors.primaryColor),),
              )
            ],
          ),
          const SizedBox(height: 10),
          buildPesananList(_getPesananStream(deliveryType, 'Menunggu Konfirmasi')),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Sedang Dikerjakan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey[600])),
              Spacer(),
              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PesananList()));
                },
                child: Text('Lihat Semua', style: TextStyle(fontSize: 14, color: AppColors.primaryColor),),
              )
            ],
          ),
          const SizedBox(height: 10),
          buildPesananList(_getPesananStream(deliveryType, 'Sedang Dikerjakan')),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Selesai", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey[600])),
              Spacer(),
              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PesananList()));
                },
                child: Text('Lihat Semua', style: TextStyle(fontSize: 14, color: AppColors.primaryColor),),
              )
            ],
          ),
          const SizedBox(height: 10),
          buildPesananList(_getPesananStream(deliveryType, 'Selesai')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 19, vertical: 24),
              decoration: BoxDecoration(color: AppColors.primaryColor),
              height: 200,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Green',
                          style: TextStyle(
                            color: AppColors.primarywhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.notifications, color: AppColors.primarywhite, size: 24),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'cari',
                        hintStyle: TextStyle(
                          color: Color(0xFF2E7D32), // Dark green text color
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          CupertinoIcons.search,
                          color: Color(0xFF2E7D32), // Green search icon
                          size: 20,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                      style: TextStyle(
                        color: Color(0xFF2E7D32), // Dark green text color
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
            TabBar(
              dividerColor: Colors.transparent,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.primaryColor,
              tabs: const [
                Tab(text: 'Ditaro'),
                Tab(text: 'Deliver'),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                children: [
                  _buildSectionedPesananList('Taruh di toko'),
                  _buildSectionedPesananList('Dijemput'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}