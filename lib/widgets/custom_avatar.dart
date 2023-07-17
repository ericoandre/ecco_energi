import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String profileImage = "assets/images/user_avatar.png";
  final User? user;

  const CustomAvatar({super.key, required this.user});

  user_imag(user) {
    try {
      return NetworkImage(user!.photoURL!);
    } catch (e) {
      return AssetImage(profileImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: CircleAvatar(radius: 24, backgroundImage: user_imag(user)));
  }
}
