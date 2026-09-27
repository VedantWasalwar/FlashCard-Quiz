import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../services/preferences_service.dart';
import '../services/storage_service.dart';

class FlashcardProvider extends ChangeNotifier {
  final StorageService _storageService;
  final PreferencesService _prefsService;

  List<Flashcard> _flashcards = [];
  int _currentIndex = 0;
  bool _isAnswerRevealed = false;
  String _searchQuery = '';

  int _cardsReviewedCount = 0;
  int _studyStreak = 0;

  FlashcardProvider(this._storageService, this._prefsService) {
    _loadData();
  }

  List<Flashcard> get allFlashcards => List.unmodifiable(_flashcards);

  List<Flashcard> get filteredFlashcards {
    if (_searchQuery.trim().isEmpty) return _flashcards;
    final query = _searchQuery.toLowerCase().trim();
    return _flashcards.where((card) {
      return card.question.toLowerCase().contains(query) ||
             card.answer.toLowerCase().contains(query);
    }).toList();
  }

  int get totalCards => _flashcards.length;
  int get currentIndex => _currentIndex;
  bool get isAnswerRevealed => _isAnswerRevealed;
  String get searchQuery => _searchQuery;

  int get cardsReviewedCount => _cardsReviewedCount;
  int get studyStreak => _studyStreak;

  Flashcard? get currentCard {
    if (_flashcards.isEmpty || _currentIndex < 0 || _currentIndex >= _flashcards.length) {
      return null;
    }
    return _flashcards[_currentIndex];
  }

  void _loadData() {
    _flashcards = _storageService.getFlashcards();
    _cardsReviewedCount = _prefsService.getCardsReviewedCount();
    _studyStreak = _prefsService.getStudyStreak();
    _clampIndex();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleAnswerRevealed() {
    if (_isAnswerRevealed) {
      _isAnswerRevealed = false;
    } else {
      _isAnswerRevealed = true;
      _onAnswerRevealed();
    }
    notifyListeners();
  }

  Future<void> _onAnswerRevealed() async {
    await _prefsService.incrementCardsReviewed();
    await _prefsService.registerStudySession();
    _cardsReviewedCount = _prefsService.getCardsReviewedCount();
    _studyStreak = _prefsService.getStudyStreak();
  }

  void nextCard() {
    if (_currentIndex < _flashcards.length - 1) {
      _currentIndex++;
      _isAnswerRevealed = false;
      notifyListeners();
    }
  }

  void previousCard() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _isAnswerRevealed = false;
      notifyListeners();
    }
  }

  void setCardIndex(int index) {
    if (index >= 0 && index < _flashcards.length) {
      _currentIndex = index;
      _isAnswerRevealed = false;
      notifyListeners();
    }
  }

  Future<void> addFlashcard(String question, String answer) async {
    await _storageService.addFlashcard(question, answer);
    _flashcards = _storageService.getFlashcards();
    _currentIndex = 0; // Jump to newest created card
    _isAnswerRevealed = false;
    notifyListeners();
  }

  Future<void> updateFlashcard(String id, String question, String answer) async {
    await _storageService.updateFlashcard(id, question, answer);
    _flashcards = _storageService.getFlashcards();
    notifyListeners();
  }

  Future<void> deleteFlashcard(String id) async {
    await _storageService.deleteFlashcard(id);
    _flashcards = _storageService.getFlashcards();
    _clampIndex();
    _isAnswerRevealed = false;
    notifyListeners();
  }

  void _clampIndex() {
    if (_flashcards.isEmpty) {
      _currentIndex = 0;
    } else if (_currentIndex >= _flashcards.length) {
      _currentIndex = _flashcards.length - 1;
    }
  }
}
