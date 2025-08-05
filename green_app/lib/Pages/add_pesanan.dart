import 'package:flutter/material.dart';
import 'package:green_app/Custom/bottom_navbar.dart';
import 'package:green_app/Pages/pick_location.dart';
import 'package:green_app/Theme/colors.dart';
import 'package:green_app/controller.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/foundation.dart'; // Add this import
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPesanan extends StatefulWidget {
  const AddPesanan({super.key});

  @override
  State<AddPesanan> createState() => _AddPesananState();
}

class _AddPesananState extends State<AddPesanan> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final AddPesananAPI _pesananController = AddPesananAPI ();

  String namaPesanan = '';
  String phone = '';
  String alamat = '';
  String jasa = '';
  String deliv = '';
  String catatan = '';

  String? _selectedService;
  String? _selectedPickup;

  LatLng _center = const LatLng(-6.200000, 106.816666); // Jakarta example
  LatLng? _pickedLocation;

  void _onMapTap(TapPosition tapPosition, LatLng latlng) {
    setState(() {
      _pickedLocation = latlng;
    });
  }

  Future<void> updateAddressFromCoordinates(double lat, double lng) async {
    if (kIsWeb) {
      _addressController.text = 'Reverse geocoding not supported on web';
      return;
    }
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final address = '${place.street ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.country ?? ''}';
        _addressController.text = address;
      } else {
        _addressController.text = 'Address not found';
      }
    } catch (e) {
      print('Reverse geocoding error: $e');
      _addressController.text = 'Failed to get address';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Green', style: TextStyle(color: Colors.green)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.asset('assets/maps_image.png', fit: BoxFit.cover),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(width: 10, height: 4, margin: const EdgeInsets.only(bottom: 16), decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),  color: Colors.grey[300]),),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.drive_file_rename_outline),
                    hintText: 'Beri nama pesanan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.black45,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_pin),
                    hintText: 'Isi alamat',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.black45,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: 'Nomor telepon',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.black45,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: _selectedService,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.local_laundry_service_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.black45,
                        width: 1,
                      ),
                    ),                  
                  ),
                  hint: const Text('Pilih jasa'),
                  items: ['Cuci', 'Setrika', 'Cuci & Setrika']
                      .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedService = val;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedPickup,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.delivery_dining),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.black45,
                        width: 1,
                      ),
                    ),
                  ),
                  isExpanded: true,
                  hint: const Text('Taruh di toko atau dijemput ke rumah'),
                  items: ['Taruh di toko', 'Dijemput']
                      .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedPickup = val;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 12, bottom: 8),
                        child: Row(
                          children: [
                            Image.asset('assets/note_icon.png', height: 20, width: 20),
                            const SizedBox(width: 8),
                            const Text(
                              'Catatan',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                        child: TextField(
                          controller: _noteController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintText: '',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  try {
                    final result = await _pesananController.addPesananAPI(
                      namaPesanan: _nameController.text,
                      alamat: _addressController.text,
                      phone: _phoneController.text,
                      jasa: _selectedService ?? '',
                      deliv: _selectedPickup ?? '',
                      catatan: _noteController.text,
                    );
                    
                    if (result == null) {
                      // Success
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Pesanan berhasil ditambahkan!')),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomBottomNavBarPage()
                        ),
                      );
                    } else {
                      // Error
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $result')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e')),
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Next', style: TextStyle(color: AppColors.primarywhite)),
                    Spacer(),
                    Icon(Icons.arrow_forward, color: AppColors.primarywhite),
                  ],
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}
