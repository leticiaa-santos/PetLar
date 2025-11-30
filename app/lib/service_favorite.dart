import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Favorite {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // ID do usuário logado
  static String get uid => _auth.currentUser!.uid;

  // verificação se está favoritado

  static Future<bool> isFavorited(String petId) async {
    final doc = await _db
      .collection("usuarios")
      .doc(uid)
      .collection("favoritos")
      .doc(petId)
      .get();
    return doc.exists;
  }

  // adicionar aos favoritos
  static Future<void> addFavorito(String petId, Map<String, dynamic> petData) async {
    await _db
      .collection("usuarios")
      .doc(uid)
      .collection("favoritos")
      .doc(petId)
      .set(petData);
  }

  // remover aos favoritos
  static Future<void> removeFavorito(String petId) async {
    await _db
      .collection("usuarios")
      .doc(uid)
      .collection("favoritos")
      .doc(petId)
      .delete();
  }

  // alternar opções
  static Future<void> toggleFavorite(String petId, Map<String, dynamic> petData) async {
    final fav = await isFavorited(petId);
    if (fav) {
      await removeFavorito(petId);
    } else {
      await addFavorito(petId, petData);
    }
  }


}