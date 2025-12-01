import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  final String username;
  const ProfilPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(username)),
      body: Center(
       
      ),
    );
  }
}