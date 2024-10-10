import 'package:flutter/material.dart';

Widget buildSettingsOption({
  required String title,
  required VoidCallback onTap,
  Color titleColor = Colors.black,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.05),
          blurRadius: 5,
          spreadRadius: 2,
        ),
      ],
    ),
    child: ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: titleColor,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    ),
  );
}