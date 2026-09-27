import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AnimatedProgress extends StatelessWidget {
  final double value; // 0.0 to 1.0

  const AnimatedProgress({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final clampedValue = value.clamp(0.0, 1.0);

    return Container(
      height: 8,
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? Colors.white10
            : AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: constraints.maxWidth * clampedValue,
                height: 8,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
