import 'package:flutter/material.dart';

AppBar buildAppBar(String title) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.black),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1.0),
      child: Container(
        color: Colors.grey.withOpacity(0.5),
        height: 1.0,
      ),
    ),
    title: Center(
      child: Text(title,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black)),
    ),
    backgroundColor: Colors.white,
    elevation: 0,
  );
}

Widget reusableText(String text) {
  return Text(text,
      style: TextStyle(
          color: Colors.grey.withOpacity(0.8),
          fontWeight: FontWeight.normal,
          fontSize: 14));
}




