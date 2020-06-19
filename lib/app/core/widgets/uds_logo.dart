import 'package:flutter/material.dart';

class UDSLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: MediaQuery.of(context).size.width / 2,
    );
  }
}
