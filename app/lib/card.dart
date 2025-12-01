import 'package:flutter/material.dart';
import 'package:app/modeloCard.dart';
import 'package:app/service_favorite.dart'; // seu arquivo de favoritos

class CardPet extends StatefulWidget {
  final CardModelo pet;

  const CardPet({super.key, required this.pet});

  @override
  State<CardPet> createState() => _CardPetState();
}

class _CardPetState extends State<CardPet> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    _loadFavorite();
  }

  // verifica no Firestore se já está favoritado
  void _loadFavorite() async {
    bool fav = await Favorite.isFavorited(widget.pet.id);
    setState(() => isFav = fav);
  }

  // alterna favorito / desfavorito
  void _toggleFavorite() async {
    await Favorite.toggleFavorite(widget.pet.id, widget.pet.toMap());
    setState(() => isFav = !isFav);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------- IMAGEM ----------------
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: Image.network(
                widget.pet.image,
                fit: BoxFit.fill,
                errorBuilder: (ctx, err, _) => Container(
                  color: Colors.grey[200],
                  child: Icon(Icons.image_not_supported,
                      color: Colors.grey, size: 40),
                ),
              ),
            ),
          ),

          // ------------- INFORMAÇÕES ----------------
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nome + coração
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.pet.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xff3E5674),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // ÍCONE DE FAVORITAR
                    GestureDetector(
                      onTap: _toggleFavorite,
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        size: 18,
                        color: isFav ? Colors.red : Colors.grey,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6),

                Row(
                  children: [
                    Icon(Icons.location_on,
                        size: 14, color: Colors.grey[700]),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        widget.pet.origin,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6),

                Row(
                  children: [
                    Icon(Icons.pets, size: 14, color: Colors.grey[700]),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        widget.pet.lifeSpan,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
