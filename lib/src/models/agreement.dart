enum Category {
  entertainment,
  restaurants,
  medicine,
  schools,
  construction,
  hotels,
  content,
  culture,
  miscellaneous,
}

class Agreement {
  final String id;
  final String name;
  final String description;
  final Category category;
  final bool isPremium;
  final String image;
  final double rating;

  Agreement(
      {required this.id,
      required this.name,
      required this.description,
      required this.category,
      required this.isPremium,
      required this.rating,
      required this.image});

  Agreement copyWith(
      {String? id,
      String? name,
      String? description,
      Category? category,
      bool? isPremium,
      double? rating,
      String? image}) {
    return Agreement(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      isPremium: isPremium ?? this.isPremium,
      rating: rating ?? this.rating,
      image: image ?? this.image,
    );
  }

  Agreement.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        description = json['description'] as String,
        category = json['category'] as Category,
        isPremium = json['isPremium'] as bool,
        rating = json['rating'] as double,
        image = json['image'] as String;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'category': category,
        'isPremium': isPremium,
        'rating': rating,
        'image': image,
      };
}
