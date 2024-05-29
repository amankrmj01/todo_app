// ignore: file_names
import 'package:flutter/material.dart';

class CustomError extends StatefulWidget {
  const CustomError({super.key});

  static errorDialog(String text, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  @override
  State<CustomError> createState() => _CustomErrorState();
}

class _CustomErrorState extends State<CustomError> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
