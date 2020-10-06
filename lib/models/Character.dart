class Character {
  int id;
  String name;
  String image;

  Character({
    this.id,
    this.name,
    this.image,
  });

  factory Character.fromMap(Map<dynamic, dynamic> data) {
    if (data != null) {
      return Character(
        id: data['id'],
        name: data['name'] ?? '',
        image: data['image'] ?? '',
      );
    }

    return Character();
  }
}
