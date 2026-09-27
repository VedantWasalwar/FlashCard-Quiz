import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flashcard_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/stat_card.dart';
import '../widgets/flashcard_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/animated_progress.dart';
import '../widgets/empty_state.dart';
import 'add_edit_flashcard_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = Provider.of<FlashcardProvider>(context);
    final totalCards = provider.totalCards;
    final currentCard = provider.currentCard;

    return Scaffold(
      body: SafeArea(
        child: totalCards == 0
            ? EmptyState(
                title: 'No Flashcards Yet',
                message: 'Create your first flashcard to start learning and tracking your streak.',
                actionLabel: 'Create Flashcard',
                onAction: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddEditFlashcardScreen(),
                    ),
                  );
                },
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Greeting Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, Learner 👋',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Ready to test your knowledge?',
                              style: TextStyle(
                                fontSize: 14,
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.psychology_rounded,
                            color: AppColors.primary,
                            size: 28,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Statistics Row
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Total Cards',
                            value: '$totalCards',
                            icon: Icons.style_rounded,
                            iconColor: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Study Streak',
                            value: '${provider.studyStreak}d',
                            icon: Icons.local_fire_department_rounded,
                            iconColor: const Color(0xFFFF6B6B),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Reviewed',
                            value: '${provider.cardsReviewedCount}',
                            icon: Icons.task_alt_rounded,
                            iconColor: AppColors.success,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // Continue Learning Label
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Continue Learning',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          'Card ${provider.currentIndex + 1} of $totalCards',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Progress Bar
                    AnimatedProgress(
                      value: (provider.currentIndex + 1) / totalCards,
                    ),

                    const SizedBox(height: 20),

                    // Flashcard Display
                    if (currentCard != null)
                      FlashcardWidget(
                        flashcard: currentCard,
                        isAnswerRevealed: provider.isAnswerRevealed,
                        onFlipPressed: () {
                          provider.toggleAnswerRevealed();
                        },
                        cardIndex: provider.currentIndex,
                        totalCards: totalCards,
                      ),

                    const SizedBox(height: 20),

                    // Show / Hide Answer Action Button
                    CustomButton(
                      text: provider.isAnswerRevealed ? 'Hide Answer' : 'Show Answer',
                      icon: provider.isAnswerRevealed ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      onPressed: () {
                        provider.toggleAnswerRevealed();
                      },
                    ),

                    const SizedBox(height: 16),

                    // Navigation Controls Row (Previous / Next)
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: provider.currentIndex == 0
                                ? null
                                : () => provider.previousCard(),
                            icon: const Icon(Icons.arrow_back_rounded, size: 18),
                            label: const Text('Previous'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: provider.currentIndex == totalCards - 1
                                ? null
                                : () => provider.nextCard(),
                            icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                            label: const Text('Next'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
      ),
    );
  }
}
