import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:green_app/Custom/pesanan_card.dart';
import 'package:green_app/Theme/colors.dart';
import 'package:firebase_core/firebase_core.dart';

class PesananList extends StatefulWidget {
  final void Function(Map<String, dynamic> article)? onPesananTap;
  const PesananList({super.key, this.onPesananTap});

  @override
  State<PesananList> createState() => _PesananListState();
}

class _PesananListState extends State<PesananList> {
  Stream<QuerySnapshot> _getPesananStream([String? category]) {
    var collection = FirebaseFirestore.instance.collection('pesanan');
    if (category != null && category.isNotEmpty) {
      return collection.where('status', isEqualTo: category).snapshots();
    }
    return collection.snapshots();
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
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No pesanan found.'));
        }
        final docs = snapshot.data!.docs;
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: docs.length,          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0, left: 16),
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
                Text("Pesanan", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                const SizedBox(height: 27),
                buildPesananList(_getPesananStream()),
                const SizedBox(height: 27),
                Text("Sedang dikerjakan", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                const SizedBox(height: 27),
                buildPesananList(_getPesananStream('Sedang Dikerjakan')),
              ],
            ),
          ),
        )
    );
  }
}