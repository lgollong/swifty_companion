import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/user_model.dart';
import '../components/profil.dart';
import '../components/projects.dart';
import '../components/skills.dart';

class ProfilPage extends StatefulWidget {
  final String username;
  const ProfilPage({super.key, required this.username});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late Future<UserModel?> _userData;
  late int index = 1;
  late String cursusName = '';

  @override
  void initState() {
    super.initState();
    _userData = ApiService.instance.getUser(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.username)),
      body: SafeArea(
        child: FutureBuilder<UserModel?>(
          future: _userData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Fehler: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('Daten nicht gefunden'));
            }

            final data = snapshot.data!;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: index,
                      items: [
                        DropdownMenuItem(value: 0, child: Text('C Piscine')),
                        DropdownMenuItem(value: 1, child: Text('42 Cursus')),
                        DropdownMenuItem(
                          value: 2,
                          child: Text('Basecamp Warm Up Germany'),
                        ),
                        DropdownMenuItem(
                          value: 3,
                          child: Text('Basecamp Germany'),
                        ),
                      ],
                      onChanged: (int? value) {
                        if (value == null) return;
                        setState(() {
                          index = value;
                        });
                      },
                    ),
                  ),
                  ProfilComponent(user: data, index: index),
                  const SizedBox(height: 16),
                  ProjectsComponent(projects: data.cursus[index].projects),
                  const SizedBox(height: 16),
                  SkillsComponent(skills: data.cursus[index].skills),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
