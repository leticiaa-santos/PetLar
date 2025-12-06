import 'package:flutter/material.dart';
import 'package:app/detalhesPet.dart';
import 'package:app/modeloCard.dart';
import 'package:app/service_favorite.dart';

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

  Future<void> _loadFavorite() async {
    bool fav = await Favorite.isFavorited(widget.pet.id);
    if (mounted) setState(() => isFav = fav);
  }

  Future<void> _toggleFavorite() async {
    await Favorite.toggleFavorite(widget.pet.id, widget.pet.toMap());
    _loadFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double w = constraints.maxWidth;

      // --------- AJUSTES RESPONSIVOS ---------
      double fontNormal = w < 170 ? 11 : 13;
      double fontTitle = w < 170 ? 13 : 16;
      double iconSize = w < 170 ? 18 : 22;
      double padding = w < 170 ? 8 : 12;

      return GestureDetector(
        onTap: () async {
          final updated = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetalhesPetPage(pet: widget.pet),
            ),
          );

          if (updated == true) {
            _loadFavorite();
          }
        },

        // ---------- CARD ----------
        child: Container(
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

              // ---------- IMAGEM ----------
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: AspectRatio(
                  aspectRatio: 1.25, // <<< AQUI, perfeito para Grid 2 colunas
                  child: Image.network(
                    widget.pet.image,
                    fit: BoxFit.fill,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: Icon(Icons.image_not_supported,
                          size: 40, color: Colors.grey),
                    ),
                  ),
                ),
              ),

              // ---------- CONTEÚDO ----------
              Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ------ Nome + Coração ------
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.pet.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fontTitle,
                              color: Color(0xff3E5674),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        GestureDetector(
                          onTap: _toggleFavorite,
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.grey,
                            size: iconSize,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 6),

                    // ------ Raça ------
                    _info(Icons.badge, "Raça: ${widget.pet.breed}", fontNormal),
                    SizedBox(height: 4),

                    // ------ Origem ------
                    _info(Icons.location_on, "Origem: ${widget.pet.origin}", fontNormal),
                    SizedBox(height: 4),

                    // ------ Vida ------
                    _info(Icons.pets, "Vida: ${widget.pet.lifeSpan}", fontNormal),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _info(IconData icon, String text, double size) {
    return Row(
      children: [
        Icon(icon, size: size + 1, color: Colors.grey[700]),
        SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: size, color: Colors.grey[700]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
