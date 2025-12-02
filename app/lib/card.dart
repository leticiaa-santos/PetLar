import 'package:flutter/material.dart';
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

  /// Quando o Flutter troca o widget reaproveitando o card,
  /// garantimos que o favorito seja recarregado corretamente
  @override
  void didUpdateWidget(CardPet oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.pet.id != widget.pet.id) {
      _loadFavorite(); // recarrega favorito do item correto
    }
  }

  /// Verifica no Firestore se o pet está favoritado
  void _loadFavorite() async {
    bool fav = await Favorite.isFavorited(widget.pet.id);
    if (mounted) {
      setState(() => isFav = fav);
    }
  }

  /// Alterna o favorito e confirma o estado real no banco
  void _toggleFavorite() async {
    await Favorite.toggleFavorite(widget.pet.id, widget.pet.toMap());

    // recarrega do banco para não haver erro de estado reciclado
    bool fav = await Favorite.isFavorited(widget.pet.id);

    if (mounted) {
      setState(() => isFav = fav);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;

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
              // ---------------- IMAGEM (responsiva) ----------------
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Image.network(
                    widget.pet.image,
                    fit: BoxFit.fill, // ← evita distorção
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
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Nome + coração
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.pet.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width < 330 ? 14 : 16,
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
                            size: width < 330 ? 22 : 24,
                            color: isFav ? Colors.red : Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 6),

                    _buildInfoRow(Icons.location_on, widget.pet.origin, width),
                    SizedBox(height: 6),
                    _buildInfoRow(Icons.pets, widget.pet.lifeSpan, width),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Reaproveita o mesmo layout para origem e lifespan
  Widget _buildInfoRow(IconData icon, String text, double width) {
    return Row(
      children: [
        Icon(icon, size: width < 330 ? 12 : 14, color: Colors.grey[700]),
        SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: width < 330 ? 11 : 13,
              color: Colors.grey[700],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}