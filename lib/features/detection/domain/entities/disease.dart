class Disease {
  final int id;
  final String name;
  final String description;
  final String recomendation;
  final String sampleImg;
  String? createdAt;
  String? updatedAt;

  Disease({
    required this.id,
    required this.name,
    required this.description,
    required this.recomendation,
    required this.sampleImg,
    this.createdAt,
    this.updatedAt,
  });
}
