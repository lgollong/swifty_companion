import 'package:flutter/material.dart';

class LevelBar extends StatelessWidget {
  final int level;
  final num percentage;
  final Color color;
  final double height;

  const LevelBar({
    super.key,
    required this.level,
    required this.percentage,
    required this.color,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 8.0;
    final bgColor = Colors.black.withAlpha((0.6 * 255).round());
    final fgColor = color;
    final labelStyle = const TextStyle(color: Colors.white, fontSize: 16);

    return LayoutBuilder(
      builder: (context, constraints) {
        final pctClamped = percentage.clamp(0.0, 100.0);
        final percent = pctClamped.round();
        final fraction = pctClamped / 100.0;
        final fillWidth = (constraints.maxWidth.isFinite)
            ? constraints.maxWidth * fraction
            : 0.0;
        final displayText = 'level $level - $percent%';

        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: height,
                    width: double.infinity,
                    color: bgColor,
                  ),
                  if (fillWidth > 0)
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: fillWidth,
                        height: height,
                        decoration: BoxDecoration(
                          color: fgColor,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(borderRadius),
                            right: fraction >= 1.0
                                ? Radius.circular(borderRadius)
                                : Radius.circular(0),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: height,
                    child: Center(child: Text(displayText, style: labelStyle)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }
}
