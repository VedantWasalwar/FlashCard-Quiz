import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/flashcard.dart';
import '../providers/flashcard_provider.dart';
import '../theme/app_colors.dart';
import '../utils/validators.dart';
import '../widgets/custom_button.dart';

class AddEditFlashcardScreen extends StatefulWidget {
  final Flashcard? flashcard;

  const AddEditFlashcardScreen({
    super.key,
    this.flashcard,
  });

  bool get isEditing => flashcard != null;

  @override
  State<AddEditFlashcardScreen> createState() => _AddEditFlashcardScreenState();
}

class _AddEditFlashcardScreenState extends State<AddEditFlashcardScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _questionController;
  late TextEditingController _answerController;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: widget.flashcard?.question ?? '');
    _answerController = TextEditingController(text: widget.flashcard?.answer ?? '');
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  Future<void> _saveFlashcard() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    final provider = Provider.of<FlashcardProvider>(context, listen: false);

    if (widget.isEditing) {
      await provider.updateFlashcard(
        widget.flashcard!.id,
        _questionController.text,
        _answerController.text,
      );
    } else {
      await provider.addFlashcard(
        _questionController.text,
        _answerController.text,
      );
    }

    if (!mounted) return;

    final message = widget.isEditing
        ? 'Flashcard updated successfully!'
        : 'Flashcard created successfully!';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Text(message),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final titleText = widget.isEditing ? 'Edit Flashcard' : 'Create Flashcard';
    final buttonText = widget.isEditing ? 'Save Changes' : 'Create Flashcard';

    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          widget.isEditing ? Icons.edit_note_rounded : Icons.post_add_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              titleText,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.isEditing
                                  ? 'Modify question or answer details'
                                  : 'Add a new card to your study set',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Question Field Section
                Text(
                  'QUESTION',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _questionController,
                  validator: Validators.validateQuestion,
                  maxLines: 4,
                  maxLength: 250,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Enter your question...',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: Icon(Icons.help_outline_rounded),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Answer Field Section
                Text(
                  'ANSWER',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _answerController,
                  validator: Validators.validateAnswer,
                  maxLines: 5,
                  maxLength: 500,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: 'Enter the answer...',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(bottom: 70),
                      child: Icon(Icons.check_circle_outline_rounded),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Submit Button
                CustomButton(
                  text: buttonText,
                  icon: widget.isEditing ? Icons.save_rounded : Icons.check_rounded,
                  onPressed: _isSaving ? null : _saveFlashcard,
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
