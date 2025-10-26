class Challenge {
  const Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.goal,
    required this.reward,
    required this.isCommunity,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final String goal;
  final String reward;
  final bool isCommunity;

  Challenge copyWith({
    String? title,
    String? description,
    String? category,
    String? goal,
    String? reward,
    bool? isCommunity,
  }) {
    return Challenge(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      goal: goal ?? this.goal,
      reward: reward ?? this.reward,
      isCommunity: isCommunity ?? this.isCommunity,
    );
  }

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      goal: json['goal'] as String,
      reward: json['reward'] as String,
      isCommunity: json['isCommunity'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'goal': goal,
      'reward': reward,
      'isCommunity': isCommunity,
    };
  }
}
