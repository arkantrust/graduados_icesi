enum Category {
  education,
  wellbeing,
  library,
}

class Benefit {
  final String id;
  final String name;
  final String description;
  final String url;
  final Category category;
  final bool isPremium;
  final String image;

  Benefit(
      {required this.id,
      required this.name,
      required this.description,
      required this.url,
      required this.category,
      required this.isPremium,
      required this.image});

  copyWith(
      {String? id,
      String? name,
      String? description,
      String? url,
      Category? category,
      bool? isPremium,
      String? image}) {
    return Benefit(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      url: url ?? this.url,
      category: category ?? this.category,
      isPremium: isPremium ?? this.isPremium,
      image: image ?? this.image,
    );
  }

  Benefit.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        description = json['description'] as String,
        url = json['url'] as String,
        category = json['category'] as Category,
        isPremium = json['isPremium'] as bool,
        image = json['image'] as String;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'url': url,
        'category': category,
        'isPremium': isPremium,
        'image': image,
      };
}
