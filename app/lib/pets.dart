import 'package:app/card.dart';
import 'package:app/modeloCard.dart';
import 'package:app/service_api.dart';
import 'package:flutter/material.dart';

class PetsPage extends StatefulWidget {
  const PetsPage({super.key});

  @override
  State<PetsPage> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {

  List<CardModelo> allPets = [];
  List<CardModelo> filtroPets = [];

  String filtroAtual = "todos";

  bool carregando = true;

  @override
  void initState() {
    super.initState();
    loadPets();
  }

  Future<void> loadPets() async {
    setState(() {
      carregando = true;
    });

    final pets = await Pets.getAllPets();

    setState(() {
      allPets = pets;
      filtroPets = pets;
      carregando = false;
    });
  }


  void aplicarFiltro(String filtro) {
    setState(() {
      filtroAtual = filtro;

      if (filtro == "todos") {
        filtroPets = allPets;
      } else if (filtro == "gatos") {
        filtroPets = allPets.where((p) => p.type == "Gato").toList();
      } else if (filtro == "caes") {
        filtroPets = allPets.where((p) => p.type == "Cachorro").toList();
      }
    });
  }





  
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
                ElevatedButton(onPressed: (){
                  aplicarFiltro("todos");
                },

                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Raio desejado
                    side: BorderSide(
                      color: Color(0xff3E5674),   // Cor da borda
                      width: 0.5,          // Espessura da borda
                    ),
                  ),
                  backgroundColor: filtroAtual == "todos" ? Color(0xff3E5674) : Color(0xfffefefe),
                  foregroundColor: filtroAtual == "todos" ? Colors.white : Color(0xff3E5674),
                  shadowColor: Colors.transparent,
                  
                ),
                child: Text("Todos")),

                ElevatedButton(onPressed: (){
                  aplicarFiltro("gatos");
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Raio desejado
                    side: BorderSide(
                      color: Color(0xff3E5674),   // Cor da borda
                      width: 0.5,          // Espessura da borda
                    ),
                  ),
                  backgroundColor: filtroAtual == "gatos" ? Color(0xff3E5674) : Color(0xfffefefe),
                  foregroundColor: filtroAtual == "gatos" ? Colors.white : Color(0xff3E5674),
                  shadowColor: Colors.transparent,
                ),
                child: Text("Gatos")),

                ElevatedButton(onPressed: (){
                  aplicarFiltro("caes");
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Raio desejado
                    side: BorderSide(
                      color: Color(0xff3E5674),   // Cor da borda
                      width: 0.5,          // Espessura da borda
                    ),
                  ),
                  backgroundColor: filtroAtual == "caes" ? Color(0xff3E5674) : Color(0xfffefefe),
                  foregroundColor: filtroAtual == "caes" ? Colors.white : Color(0xff3E5674),
                  shadowColor: Colors.transparent,
                ),
                child: Text("Cães")),
                
                
              ],
            ),

          SizedBox(height: 30),

          if (carregando)
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: CircularProgressIndicator(
                  color: Color(0xff3E5674),
                ),
              ),
            )
          else

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;

                int crossAxisCount = width > 650 ? 3 : 2;
                double aspectRatio = (width / crossAxisCount) / 260;

                return GridView.builder(
                  itemCount: filtroPets.length, // usa pets filtrados
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: aspectRatio,
                  ),
                  itemBuilder: (context, index) {
                    return CardPet(pet: filtroPets[index]);
                  },
                );
              },
            ),
          ),

          ]
        )
      )
    );
  }
}