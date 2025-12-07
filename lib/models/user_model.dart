import 'package:json_path/json_path.dart';

class UserModel {
  final String login;
  final String fullName;
  final num level;
  final String location;
  final int evalPoints;
  final String email;
  final String profilImage;

  const UserModel({
    required this.login,
    required this.fullName,
    required this.level,
    required this.location,
    required this.evalPoints,
    required this.email,
    required this.profilImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    dynamic read(String path) {
      final matches = JsonPath(path).read(json).map((m) => m.value);
      return matches.isEmpty ? null : matches.first;
    }
    final login = (read(r'$.login') ?? '').toString();
    final fullName = (read(r'$.usual_full_name') ?? '').toString();
    final levelRaw = read(r'$.cursus_users[1].level');
    final double level = levelRaw is num
        ? levelRaw.toDouble()
        : double.tryParse(levelRaw?.toString() ?? '') ?? 0.0;
    final location = (read(r'$.campus[0].city') ?? '').toString();
    final evalRaw = read(r'$.correction_point') ?? 0;
    final int evalPoints = evalRaw is int
        ? evalRaw
        : evalRaw is num
            ? evalRaw.toInt()
            : int.tryParse(evalRaw?.toString() ?? '') ?? 0;
    final email = (read(r'$.email') ?? '').toString();
    final profilImage = (read(r'$.image.link') ?? '').toString();

    return UserModel(
      login: login,
      fullName: fullName,
      level: level,
      location: location,
      evalPoints: evalPoints,
      email: email,
      profilImage: profilImage,
    );
  }

  Map<String, dynamic> toJson() => {
        'login': login,
        'full_name': fullName,
        'level': level,
        'location': location,
        'eval_points': evalPoints,
        'email': email,
        'profil_image': profilImage,
      };
}
