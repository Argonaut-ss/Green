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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset('assets/wm_icon.png', width: 42, height: 46),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.namaPesanan,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  widget.status,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w100,
                    color: widget.statusColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
