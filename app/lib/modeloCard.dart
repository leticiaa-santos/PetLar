class CardModelo {
  final String id;
  final String name;
  final String image;
  final String breed;
  final String type;

  CardModelo({
    required this.id,
    required this.name,
    required this.breed,
    required this.image,
    required this.type
  });

factory CardModelo.fromDogApi(Map data) {
    return CardModelo(
      id: data["id"] ?? "",
      name: data["breeds"] != null && data["breeds"].length > 0
          ? data["breeds"][0]["name"]
          : "Dog sem nome",
      breed: data["breeds"] != null && data["breeds"].length > 0
          ? data["breeds"][0]["breed_group"] ?? "Sem raça"
          : "Sem raça",
      image: data["url"],
      type: "dog",
    );
  }

  factory CardModelo.fromCatApi(Map data) {
    return CardModelo(
      id: data["id"] ?? "",
      name: data["breeds"] != null && data["breeds"].length > 0
          ? data["breeds"][0]["name"]
          : "Cat sem nome",
      breed: data["breeds"] != null && data["breeds"].length > 0
          ? data["breeds"][0]["origin"] ?? "Sem origem"
          : "Sem origem",
      image: data["url"],
      type: "cat",
    );
  }
}