class coffee {
  final String title;
  final String description;
  final String image;
  final int id;

  coffee({
    required this.title,
    required this.description,
    required this.image,
    required this.id,
  });

  factory coffee.fromJson(Map<String, dynamic> json) {
    return coffee(
      title: json['title'],
      description: json['description'],      
      image: json['image'],
      id: json['id'],
    );
  }
}