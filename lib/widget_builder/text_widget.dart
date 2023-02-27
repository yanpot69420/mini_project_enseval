import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String text;
  const Heading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 24.0,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class Heading5 extends StatelessWidget {
  final String text;
  const Heading5({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.white),
    );
  }
}

class BoldText extends StatelessWidget {
  final String text;
  const BoldText({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
    );
  }
}
