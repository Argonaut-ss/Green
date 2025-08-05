import 'package:flutter/material.dart';

InputDecoration customInputDecoration({required String hint, required String iconPath, Widget? suffixIcon, Color? backgroundColor, Color? iconColor}) {
    return InputDecoration(
      iconColor: iconColor,
      fillColor: backgroundColor,
      prefixIcon: Image.asset(iconPath, height: 20, width: 20),
      prefixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 20),
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 1, color: Color(0xFFBDBDBD)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 1, color: Color(0xFFBDBDBD)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 1.2, color: Color(0xFF2ECC40)),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      suffixIcon: suffixIcon,
    );
}