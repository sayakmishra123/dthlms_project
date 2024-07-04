class Option {
  final int optionId;
  final String optionName;

  Option({
    required this.optionId,
    required this.optionName,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      optionId: json['optionId'],
      optionName: json['optionName'],
    );
  }
}

class McqItem {
  final int mcqId;
  final String mcqType;
  final String? imageUrl;
  final String? videoUrl;
  final String mcqQuestion;
  final List<Option> options;

  McqItem({
    required this.mcqId,
    required this.mcqType,
    this.imageUrl,
    this.videoUrl,
    required this.mcqQuestion,
    required this.options,
  });

  factory McqItem.fromJson(Map<String, dynamic> json) {
    var optionsFromJson = json['options'] as List;
    List<Option> optionsList = optionsFromJson.map((i) => Option.fromJson(i)).toList();

    return McqItem(
      mcqId: json['mcqId'],
      mcqType: json['mcqType'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      mcqQuestion: json['mcqQuestion'],
      options: optionsList,
    );
  }
}
