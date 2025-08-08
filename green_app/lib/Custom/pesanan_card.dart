import 'package:flutter/material.dart';
import 'package:green_app/Theme/colors.dart';

class PesananCard extends StatefulWidget {
  final String namaPesanan;
  final String status;

  PesananCard({
    super.key,
    required this.namaPesanan,
    required this.status,
  });

  @override
  State<PesananCard> createState() => _PesananCardState();
}

class _PesananCardState extends State<PesananCard> {
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return Colors.green;
      case 'menunggu konfirmasi':
        return Colors.grey;
      case 'sedang dikerjakan':
        return Colors.lime;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: AppColors.primarywhite,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.transparent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        onTap: () {},
        title: Text(widget.namaPesanan),
        leading: Image.asset(
          'assets/wm_icon.png',
          width: 42,
          height: 46,
        ),
        subtitle: Text(
          widget.status,
          style: TextStyle(
            color: getStatusColor(widget.status),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
