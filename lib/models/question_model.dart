class Question {
  final String id;
  final String title;
  final List<String> options;
  final String correct;

  Question({
    required this.id,
    required this.title,
    required this.options,
    required this.correct,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'].toString(),
      title: map['title'],
      options: List<String>.from(map['options']),
      correct: map['correct_answer'],
    );
  }
}