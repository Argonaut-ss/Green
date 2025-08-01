import 'package:flutter/material.dart';
import 'package:green_app/Custom/pesanan_card.dart';
import 'package:green_app/Theme/colors.dart';

class PesananList extends StatefulWidget {
  const PesananList({super.key});

  @override
  State<PesananList> createState() => _PesananListState();
}

class _PesananListState extends State<PesananList> {
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
      ),
    );
  }
}
