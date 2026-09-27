import 'package:flutter_test/flutter_test.dart';
import 'package:flashcard_quiz/models/flashcard.dart';
import 'package:flashcard_quiz/utils/validators.dart';

void main() {
  group('Flashcard Model Tests', () {
    test('Flashcard toMap and fromMap serialization', () {
      final now = DateTime.now();
      final card = Flashcard(
        id: 'test-123',
        question: 'What is Flutter?',
        answer: 'Google UI framework',
        createdAt: now,
      );

      final map = card.toMap();
      expect(map['id'], 'test-123');
      expect(map['question'], 'What is Flutter?');
      expect(map['answer'], 'Google UI framework');

      final deserialized = Flashcard.fromMap(map);
      expect(deserialized.id, card.id);
      expect(deserialized.question, card.question);
      expect(deserialized.answer, card.answer);
    });

    test('Flashcard copyWith updates fields correctly', () {
      final card = Flashcard(
        id: 'id-1',
        question: 'Original Question',
        answer: 'Original Answer',
        createdAt: DateTime.now(),
      );

      final updated = card.copyWith(question: 'Updated Question');
      expect(updated.id, 'id-1');
      expect(updated.question, 'Updated Question');
      expect(updated.answer, 'Original Answer');
    });
  });

  group('Validators Tests', () {
    test('validateQuestion detects empty or short questions', () {
      expect(Validators.validateQuestion(''), 'Please enter a question');
      expect(Validators.validateQuestion('  '), 'Please enter a question');
      expect(Validators.validateQuestion('ab'), 'Question must be at least 3 characters long');
      expect(Validators.validateQuestion('Valid Question?'), null);
    });

    test('validateAnswer detects empty or short answers', () {
      expect(Validators.validateAnswer(''), 'Please enter an answer');
      expect(Validators.validateAnswer('a'), 'Answer must be at least 2 characters long');
      expect(Validators.validateAnswer('Valid Answer'), null);
    });
  });
}
