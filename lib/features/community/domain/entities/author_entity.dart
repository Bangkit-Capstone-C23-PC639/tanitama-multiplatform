class AuthorEntity {
  final int id;
  final String name;
  final String? photo;

  AuthorEntity({
    required this.id,
    required this.name,
    this.photo,
  });
}
