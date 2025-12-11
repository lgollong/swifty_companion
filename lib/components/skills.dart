import 'package:flutter/material.dart';
// import '../models/user_model.dart';
import '../models/skill_model.dart';

class SkillsComponent extends StatelessWidget {
  // final int cursusId;
  // final UserModel? user;
  final List<SkillModel> skills;

  const SkillsComponent({super.key, required this.skills/*, required this.user, required this.cursusId*/});

  //   List<SkillModel> get skills {
  //   if (user == null) return [];
  //   final cursusList = user!.cursus;
  //   for (final cursus in cursusList) {
  //     if (cursus.cursusId == cursusId) {
  //       return cursus.skills;
  //     }
  //   }
  //   return [];
  // }

  @override
  Widget build(BuildContext context) {
    if (skills.isEmpty) {
      return const Center(child: Text('No skills'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: skills.length,
      itemBuilder: (context, index) {
        final skill = skills[index];
        final levelText = skill.level.toString();
        return ListTile(
          title: Text(skill.name),
          subtitle: Text('Level: $levelText'),
          trailing: Text(levelText),
        );
      },
    );
  }
}