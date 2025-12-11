import 'package:json_path/json_path.dart';
import 'cursus_model.dart';

class UserModel {
  final String login;
  final String fullName;
  final String location;
  final int evalPoints;
  final String email;
  final String profilImage;
  final List<Cursus> cursus;

  const UserModel({
    required this.login,
    required this.fullName,
    required this.location,
    required this.evalPoints,
    required this.email,
    required this.profilImage,
    required this.cursus,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    dynamic read(String path) {
      final matches = JsonPath(path).read(json).map((m) => m.value);
      return matches.isEmpty ? null : matches.first;
    }

    final login = (read(r'$.login') ?? '').toString();
    final fullName = (read(r'$.usual_full_name') ?? '').toString();
    final location = (read(r'$.campus[0].city') ?? '').toString();
    final evalRaw = read(r'$.correction_point') ?? 0;
    final int evalPoints = evalRaw is int
        ? evalRaw
        : evalRaw is num
        ? evalRaw.toInt()
        : int.tryParse(evalRaw?.toString() ?? '') ?? 0;
    final email = (read(r'$.email') ?? '').toString();
    final profilImage = (read(r'$.image.link') ?? '').toString();
    final cursus = Cursus.listCursus(json);
    return UserModel(
      login: login,
      fullName: fullName,
      location: location,
      evalPoints: evalPoints,
      email: email,
      profilImage: profilImage,
      cursus: cursus,
    );
  }

  Map<String, dynamic> toJson() => {
    'login': login,
    'full_name': fullName,
    'location': location,
    'eval_points': evalPoints,
    'email': email,
    'profil_image': profilImage,
    'cursus': cursus,
  };
}
