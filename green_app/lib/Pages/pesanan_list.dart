import 'package:flutter/material.dart';
import 'package:green_app/Custom/pesanan_card.dart';
import 'package:green_app/Theme/colors.dart';

class PesananList extends StatefulWidget {
  const PesananList({super.key});

  @override
  State<PesananList> createState() => _PesananListState();
}

class _PesananListState extends State<PesananList> {
<<<<<<< Updated upstream
=======

  Stream<QuerySnapshot> _getPesananStream([String? category]) {
    var collection = FirebaseFirestore.instance.collection('pesanan');
    if (category != null && category.isNotEmpty) {
      return collection.where('category', isEqualTo: category).snapshots();
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
        return Column(
          children: docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return GestureDetector(
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
            );
          }).toList(),
        );
      },
    );
  }


>>>>>>> Stashed changes
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

      body: ListView(
        padding: const EdgeInsets.all(16.0),
<<<<<<< Updated upstream
        children: [
          Text("Pesanan", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
          const SizedBox(height: 27),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2, // Example item count
            itemBuilder: (context, index) {
              return PesananCard(namaPesanan: 'Pesanan 1', status: 'Sudah selesai');
            },
          ),
          const SizedBox(height: 27),
          Text("Sedang dikerjakan", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
          const SizedBox(height: 27),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2, // Example item count
            itemBuilder: (context, index) {
              return PesananCard(namaPesanan: 'Pesanan 1', status: 'Dikerjakan');
            },
          ),
        ],
=======
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Pesanan", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              buildPesananList(_getPesananStream()),
              const SizedBox(height: 16),
              Text("Sedang dikerjakan", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Column(
                children: List.generate(2, (index) {
                  return PesananCard(namaPesanan: 'Pesanan 1', status: 'Dikerjakan');
                }),
              ),
            ],
          ),
        ),
>>>>>>> Stashed changes
      ),
    );
  }
}
