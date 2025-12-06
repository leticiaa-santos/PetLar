import 'package:flutter/material.dart';
import 'package:app/modeloCard.dart';
import 'package:app/service_favorite.dart';

class DetalhesPetPage extends StatefulWidget {
  final CardModelo pet;

  const DetalhesPetPage({super.key, required this.pet});

  @override
  State<DetalhesPetPage> createState() => _DetalhesPetPageState();
}

class _DetalhesPetPageState extends State<DetalhesPetPage> {
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

    // Retorna TRUE para atualizar o card ao voltar
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // FOTO GRANDE ----------------------------------------------------
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Image.network(
                    widget.pet.image,
                    fit: BoxFit.fill,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: Icon(Icons.image_not_supported,
                          size: 50, color: Colors.grey),
                    ),
                  ),
                ),

                // BOTÃO VOLTAR
                Positioned(
                  top: 40,
                  left: 16,
                  child: _circleIcon(
                    Icons.arrow_back,
                    onTap: () => Navigator.pop(context),
                  ),
                ),

                // FAVORITO
                Positioned(
                  top: 40,
                  right: 16,
                  child: _circleIcon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : Colors.white,
                    onTap: _toggleFavorite,
                  ),
                ),
              ],
            ),

            // NOME + RAÇA -----------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pet.name,
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3E5674),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.pet.breed,
                    style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // CARDS DE INFORMAÇÃO --------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                spacing: 14,
                runSpacing: 14,
                children: [
                  _infoBox(Icons.category, "Tipo", widget.pet.type),
                  _infoBox(Icons.pets, "Temperamento", widget.pet.temperament),
                  _infoBox(Icons.height, "Altura", widget.pet.height),
                  _infoBox(Icons.monitor_weight, "Peso", widget.pet.weight),
                  _infoBox(Icons.timelapse, "Idade", widget.pet.lifeSpan),
                  _infoBox(Icons.location_on, "Origem", widget.pet.origin),
                ],
              ),
            ),

            SizedBox(height: 25),

            

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _circleIcon(IconData icon,
      {Color color = Colors.white, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black54,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 22),
      ),
    );
  }

  Widget _infoBox(IconData icon, String title, String value) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Color(0xffF4F6F9),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Color(0xff3E5674)),
          SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xff3E5674),
            ),
          ),
        ],
      ),
    );
  }
}
