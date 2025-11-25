import 'package:flutter/material.dart';

class Pets extends StatefulWidget {
  const Pets({super.key});

  @override
  State<Pets> createState() => _PetsState();
}

class _PetsState extends State<Pets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffefefe),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text(
                    "Pets para adoção",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Encontre seu novo melhor amigo",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0XFFeef5ff),  
                    ),
                  ),
                ]
              ),
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){},

                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Raio desejado
                    side: BorderSide(
                      color: Color(0xff3E5674),   // Cor da borda
                      width: 0.5,          // Espessura da borda
                    ),
                  ),
                  backgroundColor: Color(0xfffefefe),
                  foregroundColor: Color(0xff3E5674),
                  shadowColor: Colors.transparent,
                  
                ),
                child: Text("Todos")),

                ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Raio desejado
                    side: BorderSide(
                      color: Color(0xff3E5674),   // Cor da borda
                      width: 0.5,          // Espessura da borda
                    ),
                  ),
                  backgroundColor: Color(0xfffefefe),
                  foregroundColor: Color(0xff3E5674),
                  shadowColor: Colors.transparent,
                ),
                child: Text("Gatos")),

                ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Raio desejado
                    side: BorderSide(
                      color: Color(0xff3E5674),   // Cor da borda
                      width: 0.5,          // Espessura da borda
                    ),
                  ),
                  backgroundColor: Color(0xfffefefe),
                  foregroundColor: Color(0xff3E5674),
                  shadowColor: Colors.transparent,
                ),
                child: Text("Cães")),
                
                
          
                
              ],
            ),

          ]
        )
      )
    );
  }
}