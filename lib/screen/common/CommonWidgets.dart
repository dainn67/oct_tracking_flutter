import 'package:flutter/material.dart';

import '../../utils/images.dart';

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
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
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

Widget buildButton(String name, String type, void Function()? func) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            type == 'signin' || type == 'signup'
                ? Colors.lightBlueAccent
                : Colors.blueAccent),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
      onPressed: func,
      child: SizedBox(
        height: 50,
        child: Center(
          child: Text(
            name,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    ),
  );
}

showScaffoldMessage(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
    children: [
      Text(message, style: const TextStyle(color: Colors.white)),
      ElevatedButton(onPressed: () {}, child: const Text('Dismiss'))
    ],
  )));
}

showAlertDialog(BuildContext context, String title, String subtitle) {
  showDialog(
      context: context,
      builder: (context) => Center(
        child: Wrap(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.asset(Images.warning),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(subtitle, style: const TextStyle(color: Colors.white, fontSize: 14)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
      ));
}
