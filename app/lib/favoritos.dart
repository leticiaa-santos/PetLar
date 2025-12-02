import 'package:app/modeloCard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/card.dart'; 

class Favoritos extends StatelessWidget {
  const Favoritos({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: Color(0xfffefefe),
      body: Column(
        children: [

          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(24, 60, 24, 40),
            decoration: BoxDecoration(
              color: Color(0xff3E5674),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite, color: Colors.white, size: 40),
                    SizedBox(width: 10),
                    Text(
                      "Meus Favoritos",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Seus pets favoritos",
                  style: TextStyle(fontSize: 16, color: Color(0XFFeef5ff)),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("usuarios")
                  .doc(uid)
                  .collection("favoritos")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs;

                if (docs.isEmpty) {
                  return Center(
                    child: Text(
                      "Nenhum pet favoritado ainda",
                      style: TextStyle(
                        color: Color(0xff3E5674),
                        fontSize: 18,
                      ),
                    ),
                  );
                }

                return GridView.builder(
                  padding: EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.70,
                  ),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    final pet = CardModelo.fromMap(data);
                    return CardPet(pet: pet);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
