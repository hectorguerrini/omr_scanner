import 'dart:math';

class OMRModel {
  List<Answer> answers;
  String imageB64;

  OMRModel({
    required this.answers,
    required this.imageB64,
  });

  int get percentCorrect {
    var correct = answers.where((element) => element.isCorrect()).length;
    var total = answers.length;
    return (correct / total * 100).round();
  }

  String get getEmoji {
    if (percentCorrect >= 80) {
      return ' \u{1f929}';
    } else if (percentCorrect >= 60) {
      return ' \u{1f610}';
    } else if (percentCorrect >= 40) {
      return ' \u{2639}';
    } else if (percentCorrect >= 20) {
      return ' \u{1f62d}';
    } else {
      return ' \u{1f635}';
    }
  }

  factory OMRModel.fromJson(Map<String, dynamic> json) {
    return OMRModel(
      answers: Answer.fromList(json['answers']),
      imageB64: (json['image_b64'] as String)
          .replaceAll('data:image/jpeg;base64,', ''),
    );
  }
}

class Answer {
  String marked;
  int question;
  final List<String> _list = ['A', 'B', 'C', 'D', 'E'];
  Answer({
    required this.marked,
    required this.question,
  });

  static fromList(List list) {
    return list.map((e) => Answer.fromJson(e)).toList();
  }

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      marked: json['marked'],
      question: json['question'],
    );
  }
  bool isCorrect() {
    var ran = Random();
    return marked == _list[ran.nextInt(5)];
  }
}
