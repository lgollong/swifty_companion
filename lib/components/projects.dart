import 'package:flutter/material.dart';
import '../models/project_model.dart';

class ProjectsComponent extends StatelessWidget {
  final List<ProjectModel> projects;

  const ProjectsComponent({super.key, required this.projects});

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
        if (project.cursusId == 21){
          return ListTile(
            title: Text(project.name),
            subtitle: Text('Status: ${project.status}'),
            trailing: Text(markText),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}