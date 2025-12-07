import 'package:flutter/material.dart';
import '../models/user_model.dart';

class ProfilComponent extends StatelessWidget {
  final UserModel? user;

  const ProfilComponent({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final profilImage = user?.profilImage;
    final level = user?.level;
    final evalPoints = user?.evalPoints;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (profilImage != null && profilImage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(profilImage),
            ),
          ),
        Text('Login: ${user?.login ?? '-'}'),
        Text('Full Name: ${user?.fullName ?? '-'}'),
        Text('Level: ${level?.toString() ?? '-'}'),
        Text('Location: ${user?.location ?? '-'}'),
        Text('Eval Points: ${evalPoints?.toString() ?? '-'}'),
        Text('E-Mail: ${user?.email ?? '-'}'),
      ],
    );
  }
}