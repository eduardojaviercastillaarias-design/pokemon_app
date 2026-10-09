class Pokemon {
  final int id;
  final String name;
  final int height;
  final int weight;
  final String imageUrl;
  final List<String> types;

  Pokemon({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.types,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] as int,
      name: json['name'] as String,
      height: json['height'] as int,
      weight: json['weight'] as int,
      
      imageUrl: json['sprites']['other']['official-artwork']['front_default'] ?? 
                json['sprites']['front_default'] ?? '',
      types: (json['types'] as List)
          .map((item) => item['type']['name'] as String)
          .toList(),
    );
  }
}