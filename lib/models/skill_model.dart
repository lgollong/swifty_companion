import 'package:json_path/json_path.dart';

class SkillModel {
  final String name;
  final num level;
  final int cursusId;

  const SkillModel({
    required this.name,
    required this.level,
    required this.cursusId
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    dynamic read(String path) {
      final matches = JsonPath(path).read(json).map((m) => m.value);
      return matches.isEmpty ? null : matches.first;
    }
    final name = (read(r'$.name') ?? '').toString();
    final levelRaw = read(r'$.level');
    final num level = levelRaw is num
        ? levelRaw
        : double.tryParse(levelRaw?.toString() ?? '') ?? 0.0;
    final cursusIdRaw = read(r'$.cursus_id');
    final cursusId = cursusIdRaw is num
      ? cursusIdRaw.toInt()
      : int.tryParse(cursusIdRaw?.toString() ?? '') ?? 0;
    return SkillModel(
      name: name,
      level: level,
      cursusId: cursusId
    );
  }

  static List<SkillModel> listFromJson(Map<String, dynamic> json) {
    final skillNodes = JsonPath(r'$.cursus_users[*].skills[*]').read(json).map((m) => m.value);

    final List<SkillModel> skills = [];
    for (final node in skillNodes) {
      if (node is Map<String, dynamic>) {
        skills.add(SkillModel.fromJson(node));
      } else if (node is Map) {
        skills.add(SkillModel.fromJson(Map<String, dynamic>.from(node)));
      } else {
        skills.add(const SkillModel(name: '', level: 0, cursusId: 0));
      }
    }
    // print(skills);
    return skills;
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'level': level,
        'cursus_id': cursusId
      };
}
