class Option {
  final String text;
  final bool isCorrect;

  Option({required this.text, required this.isCorrect});

  factory Option.fromJson(Map<String, dynamic> json) {
    // Debug: print each option's data
    print('Option: $json');
    return Option(
      text: json['description'] ?? '',  // Default to empty string if null
      isCorrect: json['is_correct'] ?? false,  // Default to false if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'is_correct': isCorrect,
    };
  }
}

class Question {
  final int id;
  final String description;
  final bool isMandatory;
  final List<Option> options;

  Question({
    required this.id,
    required this.description,
    required this.isMandatory,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    // Debug: print the question data
    print('Question: $json');
    return Question(
      id: json['id'] ?? 0,  // Default to 0 if id is null
      description: json['description'] ?? '',  // Default to empty string if null
      isMandatory: json['is_mandatory'] ?? false,  // Default to false if null
      options: json['options'] != null
          ? (json['options'] as List<dynamic>)
              .map((option) => Option.fromJson(option))
              .toList()
          : [],  // Empty list if options are null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'is_mandatory': isMandatory,
      'options': options.map((option) => option.toJson()).toList(),
    };
  }
}
