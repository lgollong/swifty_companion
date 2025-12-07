import 'package:flutter/material.dart';
import '../models/skill_model.dart';

class SkillsComponent extends StatelessWidget {
  final List<SkillModel> skills;

  const SkillsComponent({super.key, required this.skills});

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