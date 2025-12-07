import 'package:flutter/material.dart';
import 'profil_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _username = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 48,
                  backgroundImage: AssetImage('assets/42_logo.png'),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 400,
                  height: 56,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _username,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            labelText: 'Enter Login',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final name = _username.text.trim();
                    if (name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please enter an username')),
                      );
                      return;
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => ProfilPage(username: name)),
                    );
                  },
                  child: const Text('Search'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
