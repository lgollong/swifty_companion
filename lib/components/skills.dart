import 'package:flutter/material.dart';
import '../models/skill_model.dart';
import 'level_bar.dart';

class SkillsComponent extends StatelessWidget {
  final List<SkillModel> skills;

  const SkillsComponent({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    if (skills.isEmpty) {
      return const Center(child: Text('No skills'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Center(
            child: Text(
              'SKILLS',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: skills.length,
          itemBuilder: (context, index) {
            final skill = skills[index];
            final level = skill.level;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(title: Text(skill.name)),
                LevelBar(
                  level: level.toInt(),
                  percentage: (((level - level.floor()) * 100).clamp(
                    0.0,
                    100.0,
                  )).round(),
                  color: Theme.of(context).colorScheme.tertiary,
                  height: 20,
                ),
                const Divider(),
              ],
            );
          },
        ),
      ],
    );
  }
}
