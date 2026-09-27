import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/flashcard.dart';
import 'preferences_service.dart';

class StorageService {
  static const String _boxName = 'flashcards_box';
  Box? _box;
  final List<Flashcard> _inMemoryCards = [];

  Future<void> init(PreferencesService prefsService) async {
    try {
      await Hive.initFlutter();
      _box = await Hive.openBox(_boxName);
    } catch (e) {
      debugPrint('Hive initialization warning: $e');
      _box = null;
    }

    if (_box != null && _box!.isOpen) {
      if (!prefsService.isSeeded() && _box!.isEmpty) {
        await _seedSampleFlashcards(prefsService);
      }
    } else {
      _box = null;
      if (_inMemoryCards.isEmpty) {
        _seedInMemory();
      }
    }
  }

  List<Flashcard> getFlashcards() {
    if (_box != null && _box!.isOpen) {
      final List<Flashcard> list = [];
      try {
        for (final rawData in _box!.values) {
          if (rawData is Map) {
            list.add(Flashcard.fromMap(rawData));
          }
        }
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return list;
      } catch (e) {
        debugPrint('Error fetching flashcards from Hive: $e');
      }
    }
    return List.from(_inMemoryCards)..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> addFlashcard(String question, String answer) async {
    final uuid = const Uuid().v4();
    final card = Flashcard(
      id: uuid,
      question: question.trim(),
      answer: answer.trim(),
      createdAt: DateTime.now(),
    );

    if (_box != null && _box!.isOpen) {
      await _box!.put(card.id, card.toMap());
    } else {
      _inMemoryCards.add(card);
    }
  }

  Future<void> updateFlashcard(String id, String question, String answer) async {
    if (_box != null && _box!.isOpen) {
      final existingRaw = _box!.get(id);
      if (existingRaw is Map) {
        final existingCard = Flashcard.fromMap(existingRaw);
        final updatedCard = existingCard.copyWith(
          question: question.trim(),
          answer: answer.trim(),
        );
        await _box!.put(id, updatedCard.toMap());
      }
    } else {
      final index = _inMemoryCards.indexWhere((c) => c.id == id);
      if (index != -1) {
        _inMemoryCards[index] = _inMemoryCards[index].copyWith(
          question: question.trim(),
          answer: answer.trim(),
        );
      }
    }
  }

  Future<void> deleteFlashcard(String id) async {
    if (_box != null && _box!.isOpen) {
      await _box!.delete(id);
    } else {
      _inMemoryCards.removeWhere((c) => c.id == id);
    }
  }

  Future<void> _seedSampleFlashcards(PreferencesService prefsService) async {
    final sampleCards = _generateSampleCards();
    for (final card in sampleCards) {
      await _box!.put(card.id, card.toMap());
    }
    await prefsService.setSeeded(true);
  }

  void _seedInMemory() {
    _inMemoryCards.addAll(_generateSampleCards());
  }

  List<Flashcard> _generateSampleCards() {
    return [
      Flashcard(
        id: const Uuid().v4(),
        question: 'What is Flutter?',
        answer: 'Flutter is an open-source UI software development kit created by Google for building natively compiled applications for mobile, web, and desktop from a single codebase.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      Flashcard(
        id: const Uuid().v4(),
        question: 'What is Dart?',
        answer: 'Dart is a client-optimized programming language developed by Google for fast apps on any platform, featuring sound null safety and JIT/AOT compilation.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 9)),
      ),
      Flashcard(
        id: const Uuid().v4(),
        question: 'What is an API?',
        answer: 'API stands for Application Programming Interface. It is a set of rules and protocols that allows different software applications to communicate with each other.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 8)),
      ),
      Flashcard(
        id: const Uuid().v4(),
        question: 'What is OOP?',
        answer: 'Object-Oriented Programming (OOP) is a programming paradigm based on "objects", which contain data and code. Its pillars are Encapsulation, Abstraction, Inheritance, and Polymorphism.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 7)),
      ),
      Flashcard(
        id: const Uuid().v4(),
        question: 'What is Git?',
        answer: 'Git is a distributed version control system designed to track changes in source code during software development and support collaborative workflows.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 6)),
      ),
      Flashcard(
        id: const Uuid().v4(),
        question: 'What is REST?',
        answer: 'REST (Representational State Transfer) is an architectural style for designing networked applications using standard HTTP methods like GET, POST, PUT, and DELETE.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      Flashcard(
        id: const Uuid().v4(),
        question: 'What is SQL?',
        answer: 'SQL (Structured Query Language) is a domain-specific language used for managing, querying, and manipulating data stored in relational database management systems (RDBMS).',
        createdAt: DateTime.now().subtract(const Duration(minutes: 4)),
      ),
      Flashcard(
        id: const Uuid().v4(),
        question: 'What is a Database?',
        answer: 'A database is an organized collection of structured data or information stored electronically in a computer system and managed by a Database Management System (DBMS).',
        createdAt: DateTime.now().subtract(const Duration(minutes: 3)),
      ),
      Flashcard(
        id: const Uuid().v4(),
        question: 'What is State Management in Flutter?',
        answer: 'State management is the mechanism of managing the state of UI controls to ensure the user interface accurately reflects current application data at all times.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
      ),
      Flashcard(
        id: const Uuid().v4(),
        question: 'What is Async/Await in Dart?',
        answer: 'Async and await are Dart keywords that enable asynchronous programming, allowing non-blocking execution of delayed operations like network calls or file reads.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 1)),
      ),
    ];
  }
}
