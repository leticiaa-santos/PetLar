import 'dart:convert';
import 'package:app/modeloCard.dart';
import 'package:http/http.dart' as http;


class Pets{
  static const String dogApiKey = "live_a3felFHs0wuZ7yvwJIS6Cw7UxUyI0mAxFrVUigpyi8Bm6sR5HH3tUegMo9bi4PAg";
  static const String catApiKey = "live_pvwqPkabN0F0AFETU9KOlJmt1A6zCGRhcDvpWH6SshXUekYt6ZRk6RVKAvlOUiBj";

  static Future<List<CardModelo>> getDogs({int limit = 20}) async {
    final url = Uri.parse(
        "https://api.thedogapi.com/v1/images/search?limit=$limit&has_breeds=1");

    final response = await http.get(
      url,
      headers: {"x-api-key": dogApiKey},
    );

    final List data = json.decode(response.body);
    return data.map((d) => CardModelo.fromDogApi(d)).toList();
  }

  static Future<List<CardModelo>> getCats({int limit = 20}) async {
    final url = Uri.parse(
        "https://api.thecatapi.com/v1/images/search?limit=$limit&has_breeds=1");

    final response = await http.get(
      url,
      headers: {"x-api-key": catApiKey},
    );

    final List data = json.decode(response.body);
    return data.map((d) => CardModelo.fromCatApi(d)).toList();
  }

  static Future<List<CardModelo>> getAllPets() async {
    final dogs = await getDogs(limit: 20);
    final cats = await getCats(limit: 20);
    final all = [...dogs, ...cats];
    all.shuffle();
    return all;
  }
}
