import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:green_app/Custom/pesanan_card.dart';
import 'package:green_app/Theme/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class PesananList extends StatefulWidget {
  final void Function(Map<String, dynamic> article)? onPesananTap;
  const PesananList({super.key, this.onPesananTap});

  @override
  State<PesananList> createState() => _PesananListState();
}

class _PesananListState extends State<PesananList> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  Stream<QuerySnapshot> _getPesananStream([String? category]) {
    var collection = FirebaseFirestore.instance.collection('pesanan');
    
    // Get current user ID
    User? currentUser = FirebaseAuth.instance.currentUser;
    String? userId = currentUser?.uid;
    
    if (userId == null) {
      // If no user is logged in, return empty stream
      return Stream.empty();
    }
    
    // Start with user filter
    Query query = collection.where('userId', isEqualTo: userId);
    
    // Add category filter if provided
    if (category != null && category.isNotEmpty) {
      query = query.where('status', isEqualTo: category);
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
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: docs.length,          itemBuilder: (context, index) {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('green', style: TextStyle(color: Colors.green)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Cari',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      prefixIcon: Icon(Icons.search, color: Colors.green),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 27),
                Text("Menunggu Konfirmasi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey[600])),
                const SizedBox(height: 10),
                buildPesananList(_getPesananStream('Menunggu Konfirmasi')),
                const SizedBox(height: 27),
                Text("Sedang Dikerjakan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey[600])),
                const SizedBox(height: 10),
                buildPesananList(_getPesananStream('Sedang Dikerjakan')),
                const SizedBox(height: 27),
                Text("Selesai", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey[600])),
                const SizedBox(height: 10),
                buildPesananList(_getPesananStream('Selesai')),
              ],
            ),
          ),
        )
    );
  }
}