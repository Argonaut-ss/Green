import 'package:flutter/material.dart';

class PesananCard extends StatefulWidget {
  String namaPesanan;
  String status;
  Color? statusColor;
  PesananCard({super.key, required this.namaPesanan, required this.status, this.statusColor});

  @override
  State<PesananCard> createState() => _PesananCardState();
}

class _PesananCardState extends State<PesananCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        onTap: (){},
        title: Text(widget.namaPesanan),
        leading: Image.asset(
          'assets/wm_icon.png',
          width: 42,
          height: 46,
        ),
        subtitle: Text(widget.status)
      ),
    );
  }
}
