import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;

  const CustomButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add search logic
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, backgroundColor: const Color.fromARGB(255, 221, 213, 213),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        minimumSize: const Size(200, 50),
        elevation: 0.0,
      ),
      child: Text(text),
    );
  }
}
