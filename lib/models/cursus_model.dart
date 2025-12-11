import 'package:json_path/json_path.dart';
import 'skill_model.dart';
import 'project_model.dart';

class Cursus {
  final int cursusId;
  final String name;
  final String grade;
  final num level;
  final List<SkillModel> skills;
  final List<ProjectModel> projects;

  const Cursus({
    required this.cursusId,
    required this.name,
    required this.grade,
    required this.level,
    required this.skills,
    required this.projects,
  });

  static List<Cursus> listCursus(Map<String, dynamic> json) {
    final cursusPath = JsonPath(r'$.cursus_users[*]');
    final cursusNodes = cursusPath.read(json).map((m) => m.value).toList();
    final List<Cursus> cursus = [];
    for (int i = 0; i < cursusNodes.length; i++) {
      final node = cursusNodes[i];
      if (node is Map<String, dynamic> || node is Map) {
        final Map<String, dynamic> nodeMap = node is Map<String, dynamic>
            ? node
            : Map<String, dynamic>.from(node as Map);
        dynamic read(String path) {
          final matches = JsonPath(path).read(nodeMap).map((m) => m.value);
          return matches.isEmpty ? null : matches.first;
        }
        final idRaw = read(r'$.cursus_id') ?? 0;
        final int cursusId = idRaw is int
            ? idRaw
            : idRaw is num
            ? idRaw.toInt()
            : int.tryParse(idRaw?.toString() ?? '') ?? 0;
        final name = (read(r'$.cursus.name') ?? '').toString();
        final grade = (read(r'$.grade') ?? '').toString();
        final levelRaw = read(r'$.level');
        final num level = levelRaw is num
            ? levelRaw
            : double.tryParse(levelRaw?.toString() ?? '') ?? 0.0;
        final skills = SkillModel.listFromJson(json, i);
        final projects = ProjectModel.listFromJson(json, cursusId);
        cursus.add(
          Cursus(
            cursusId: cursusId,
            name: name,
            grade: grade,
            level: level,
            skills: skills,
            projects: projects,
          ),
        );
      } else {
        cursus.add(
          const Cursus(
            cursusId: 0,
            name: '',
            grade: '',
            level: 0,
            skills: [],
            projects: [],
          ),
        );
      }
    }
    return cursus;
  }
}