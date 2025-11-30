class CardModelo {
  final String id;
  final String name;
  final String image;
  final String breed;
  final String type;

  final String temperament;
  final String origin;
  final String lifeSpan;
  final String weight;
  final String height;

  CardModelo({
    required this.id,
    required this.name,
    required this.breed,
    required this.image,
    required this.type,
    required this.temperament,
    required this.origin,
    required this.lifeSpan,
    required this.weight,
    required this.height,
  });

  // Para salvar no Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'breed': breed,
      'type': type,
      'temperament': temperament,
      'origin': origin,
      'lifeSpan': lifeSpan,
      'weight': weight,
      'height': height,
    };
  }

  // Para ler do Firestore
  factory CardModelo.fromMap(Map<String, dynamic> data) {
    return CardModelo(
      id: data['id'] ?? '',
      name: data['name'] ?? 'Sem nome',
      image: data['image'] ?? '',
      breed: data['breed'] ?? 'Sem raça',
      type: data['type'] ?? '',
      temperament: data['temperament'] ?? 'Não informado',
      origin: data['origin'] ?? 'Origem desconhecida',
      lifeSpan: data['lifeSpan'] ?? '--',
      weight: data['weight'] ?? '--',
      height: data['height'] ?? '--',
    );
  }

  // DOG API
  factory CardModelo.fromDogApi(Map data) {
    final breedData = (data["breeds"] != null && data["breeds"].length > 0)
        ? data["breeds"][0]
        : null;

    return CardModelo(
      id: data["id"] ?? "",
      name: breedData?["name"] ?? "Cachorro sem nome",
      breed: breedData?["breed_group"] ?? "Sem grupo",
      image: data["url"] ?? "",
      type: "Cachorro",
      temperament: breedData?["temperament"] ?? "Não informado",
      origin: breedData?["origin"] ?? "Origem desconhecida",
      lifeSpan: breedData?["life_span"] ?? "--",
      weight: breedData?["weight"]?["metric"] ?? "--",
      height: breedData?["height"]?["metric"] ?? "--",
    );
  }

  // CAT API
  factory CardModelo.fromCatApi(Map data) {
    final breedData = (data["breeds"] != null && data["breeds"].length > 0)
        ? data["breeds"][0]
        : null;

    return CardModelo(
      id: data["id"] ?? "",
      name: breedData?["name"] ?? "Gato sem nome",
      breed: breedData?["origin"] ?? "Sem origem",
      image: data["url"] ?? "",
      type: "Gato",
      temperament: breedData?["temperament"] ?? "Não informado",
      origin: breedData?["origin"] ?? "Origem desconhecida",
      lifeSpan: breedData?["life_span"] ?? "--",
      weight: breedData?["weight"]?["metric"] ?? "--",
      height: breedData?["height"]?["metric"] ?? "--",
    );
  }
}
