import 'package:json_path/json_path.dart';

class ProjectModel {
  final String name;
  final int mark;
  final String status;
  final int cursusId;

  const ProjectModel({
    required this.name,
    required this.mark,
    required this.status,
    required this.cursusId
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
    final status = (read(r'$.status') ?? '').toString();
    final cursusIdRaw = read(r'$.cursus_ids[0]');
    final cursusId = cursusIdRaw is num
      ? cursusIdRaw.toInt()
      : int.tryParse(cursusIdRaw?.toString() ?? '') ?? 0;
    return ProjectModel(
      name: name,
      mark: mark,
      status: status,
      cursusId: cursusId
    );
  }

    static List<ProjectModel> listFromJson(Map<String, dynamic> json) {
    final projectNodes = JsonPath(r'$.projects_users[*]').read(json).map((m) => m.value);

    final List<ProjectModel> projects = [];
    for (final node in projectNodes) {
      if (node is Map<String, dynamic>) {
        projects.add(ProjectModel.fromJson(node));
      } else if (node is Map) {
        projects.add(ProjectModel.fromJson(Map<String, dynamic>.from(node)));
      } else {
        projects.add(const ProjectModel(name: '', mark: 0, status: '', cursusId: 0));
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
