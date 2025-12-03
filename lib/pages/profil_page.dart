import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/user_model.dart';
import '../config/env.dart';

class ProfilPage extends StatelessWidget {
  final String username;
  const ProfilPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(username)),
      body: FutureBuilder<UserModel?>(
        future: ApiService.instance.getUser(username),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Fehler: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text(Env.baseUrl));
          }
          final user = snapshot.data!;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundImage: user.profilImage.isNotEmpty
                        ? NetworkImage(user.profilImage)
                        : null,
                    child: user.profilImage.isEmpty
                        ? const Icon(Icons.person, size: 48)
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Text(user.username,
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text('Level: ${user.level}'),
                  Text('Location: ${user.location}'),
                  Text('Eval Points: ${user.evalPoints}'),
                  Text('Email: ${user.email}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
