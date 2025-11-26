import 'package:app/modeloCard.dart';
import 'package:flutter/material.dart';


class CardPet extends StatelessWidget {
  final CardModelo pet;

  const CardPet({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              pet.image,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pet.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xff3E5674),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  pet.breed,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff3E5674),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
