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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Center(
            child: Text(
              'PROJECTS',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 8.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 14.0,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 500),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: projects.length,
                separatorBuilder: (_, _) => const Divider(),
                itemBuilder: (context, i) {
                  final project = projects[i];
                  final markText = project.mark.toString();
                  final statusColor = project.status
                      ? Theme.of(context).colorScheme.tertiary
                      : Colors.red;
                  final statusIcon = project.status
                      ? Icons.check_circle
                      : Icons.cancel;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(child: Text(project.name)),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              markText,
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(statusIcon, color: statusColor, size: 20),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
