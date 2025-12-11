import 'package:json_path/json_path.dart';

class ProjectModel {
  final String name;
  final int mark;
  final bool status;

  const ProjectModel({
    required this.name,
    required this.mark,
    required this.status,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    dynamic read(String path) {
      final matches = JsonPath(path).read(json).map((m) => m.value);
      return matches.isEmpty ? null : matches.first;
    }

    final name = (read(r'$.project.name') ?? '').toString();
    final markRaw = read(r'$.final_mark');
    final mark = markRaw is num
        ? markRaw.toInt()
        : int.tryParse(markRaw?.toString() ?? '') ?? 0;
    final statusRaw = read(r"$['validated?']");
    final status = statusRaw == null
        ? false
        : statusRaw is bool
        ? statusRaw
        : statusRaw is num
        ? statusRaw != 0
        : statusRaw.toString().toLowerCase() == 'true';
    return ProjectModel(name: name, mark: mark, status: status);
  }

  static List<ProjectModel> listFromJson(
    Map<String, dynamic> json,
    int cursusId,
  ) {
    final path = JsonPath(r'$.projects_users[*]');
    final projectNodes = path.read(json).map((m) => m.value).toList();
    final List<ProjectModel> projects = [];
    for (final node in projectNodes) {
      if (node is Map<String, dynamic>) {
        final nodeMap = node;
        final cursusIds = nodeMap['cursus_ids'];
        dynamic cursusIdRaw;
        if (cursusIds is List && cursusIds.isNotEmpty) {
          cursusIdRaw = cursusIds[0];
        } else {
          cursusIdRaw = null;
        }
        final nodeCursusId = cursusIdRaw is num
            ? cursusIdRaw.toInt()
            : int.tryParse(cursusIdRaw?.toString() ?? '') ?? 0;
        if (nodeCursusId == cursusId) {
          projects.add(ProjectModel.fromJson(Map<String, dynamic>.from(node)));
        }
      }
    }
    return projects;
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'mark': mark,
    'status': status,
  };
}
