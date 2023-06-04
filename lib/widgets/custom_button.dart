import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color backColor;
  final String text;
  final Color textColor;
  final String? pngIconPath;
  final VoidCallback onPressed;

  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.textColor,
      this.pngIconPath,
      required this.backColor});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(textColor),
        backgroundColor: MaterialStateProperty.all<Color>(backColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          if (pngIconPath != null) ...[
            Image.asset(
              pngIconPath!,
              //color: Colors.white,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 8),
          ]
        ],
      ),
    );
  }
}
