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
    return ListTile(
      onTap: (){},
      leading: Image.asset('assets/wm_icon.png', width: 42, height: 46,),
      title: Text(
        widget.namaPesanan,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
      subtitle: Text(
        widget.status,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w100,
          color: widget.statusColor,
        ),
      ),
    );
  }
}
