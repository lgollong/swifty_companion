import 'package:flutter/material.dart';
import '../services/api_service.dart';
// import '../models/user_model.dart';
// import '../models/skill_model.dart';
// import '../models/project_model.dart';
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
  late Future<UserData?> _userData;

  @override
  void initState() {
    super.initState();
    _userData = ApiService.instance.getUser(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.username)),
      body: FutureBuilder<UserData?>(
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
                ProfilComponent(user: data.user),
                const SizedBox(height: 16),
                SkillsComponent(skills: data.skills),
                const SizedBox(height: 16),
                ProjectsComponent(projects: data.project),
              ],
            ),
          );
        },
      ),
    );
  }
}
