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
  int index = 0;
  bool _initialised = false;

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
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('No data found'));
            }

            final data = snapshot.data!;
            if (!_initialised && data.cursus.isNotEmpty) {
              final pos = data.cursus.indexWhere((c) {
                final name = c.name.toLowerCase();
                return name.contains('42cursus');
              });
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                setState(() {
                  if (pos != -1) index = pos;
                  _initialised = true;
                });
              });
            }

            if (data.cursus.isEmpty) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProfilComponent(user: data, index: 0),
                    const SizedBox(height: 16),
                    const Center(child: Text('No cursus available')),
                  ],
                ),
              );
            }
            if (index >= data.cursus.length) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) setState(() => index = 0);
              });
            }
            final selectedIndex = index.clamp(0, data.cursus.length - 1);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: selectedIndex,
                      isExpanded: true,
                      iconEnabledColor: Theme.of(context).colorScheme.secondary,
                      dropdownColor: Theme.of(context).colorScheme.secondary,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                      items: List.generate(
                        data.cursus.length,
                        (i) => DropdownMenuItem(
                          value: i,
                          child: Text(data.cursus[i].name),
                        ),
                      ),
                      onChanged: (int? value) {
                        if (value == null) return;
                        setState(() {
                          index = value;
                        });
                      },
                    ),
                  ),
                  ProfilComponent(user: data, index: selectedIndex),
                  const SizedBox(height: 16),
                  ProjectsComponent(
                    projects: data.cursus[selectedIndex].projects,
                  ),
                  const SizedBox(height: 16),
                  SkillsComponent(skills: data.cursus[selectedIndex].skills),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
