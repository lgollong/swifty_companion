class UserModel {
  final String username;
  final double level;
  final String location;
  final int evalPoints;
  final String email;
  final String profilImage;

  const UserModel({
    required this.username,
    required this.level,
    required this.location,
    required this.evalPoints,
    required this.email,
    required this.profilImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json['first_name'] as String? ?? '',
        level: (json['level'] is num)
            ? (json['level'] as num).toDouble()
            : double.tryParse(json['level']?.toString() ?? '') ?? 0.3,
        location: json['location'] as String? ?? '',
        evalPoints: (json['eval_points'] is int)
            ? json['eval_points'] as int
            : int.tryParse(json['eval_points']?.toString() ?? '') ?? 0,
        email: json['email'] as String? ?? '',
        profilImage: json['kind'] as String? ??
            json['kind'] as String? ??
            '',
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'level': level,
        'location': location,
        'eval_points': evalPoints,
        'email': email,
        'profil_image': profilImage,
      };
}
