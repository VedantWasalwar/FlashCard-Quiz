class Validators {
  static String? validateQuestion(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a question';
    }
    if (value.trim().length < 3) {
      return 'Question must be at least 3 characters long';
    }
    return null;
  }

  static String? validateAnswer(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter an answer';
    }
    if (value.trim().length < 2) {
      return 'Answer must be at least 2 characters long';
    }
    return null;
  }
}
