import 'package:flutter/material.dart';
// import '../models/user_model.dart';
import '../models/project_model.dart';

class ProjectsComponent extends StatelessWidget {
  // final int cursusId;
  // final UserModel? user;
  final List<ProjectModel> projects;

  const ProjectsComponent({super.key, required this.projects/*, required this.user, required this.cursusId*/});

  // List<ProjectModel> get projects {
  //   if (user == null) return [];
  //   final cursusList = user!.cursus;
  //   for (final cursus in cursusList) {
  //     if (cursus.cursusId == cursusId) {
  //       return cursus.projects;
  //     }
  //   }
  //   return [];
  // }

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) {
      return const Center(child: Text('No projects'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        final markText = project.mark.toString();
        return ListTile(
          title: Text(project.name),
          subtitle: Text('Status: ${project.status}'),
          trailing: Text(markText),
        );
      },
    );
  }
}