import 'package:app/card.dart';
import 'package:app/modeloCard.dart';
import 'package:app/navbar.dart';
import 'package:app/service_api.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CardModelo> homePets = [];

  bool carregando = true;

  @override
  void initState() {
    super.initState();
    loadHomePets();
  }

  Future<void> loadHomePets() async {
    setState(() {
      carregando = true;
    });

    final all = await Pets.getAllPets();
    
    setState(() {
      homePets = all.take(10).toList();
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
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
                  //logo
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Image.asset("assets/image/logo.png", fit: BoxFit.contain),
                    ),
                  ),

                  SizedBox(height: 30),

                  Text(
                    "Bem-vindo ao PetLar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Conectando corações a patinhas",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0XFFeef5ff),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sobre nós",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF3E5674),
                    ),
                  ),

                  SizedBox(height: 20),

                  Text(
                    "O PetLar é mais do que um app de adoção – é uma missão de amor! Ajudamos cães e gatos a encontrarem lares cheios de carinho e famílias a ganharem companheiros fiéis. Cada adoção é uma história de esperança!",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0XFF3E5674),
                    ),
                  ),

                  SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          color: Color(0xffE7EAED),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.favorite, color: Color(0xff3E5674), size: 40),
                            Text(
                              "500+",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff3E5674),
                                fontSize: 18,
                              ),
                            ),
                            Text("Adoções", style: TextStyle(color: Color(0xff3E5674))),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          color: Color(0xffD6DFEB),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.groups_2, color: Color(0xff3E5674), size: 40),
                            Text(
                              "1000+",
                              style: TextStyle(
                                color: Color(0xff3E5674),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text("Famílias", style: TextStyle(color: Color(0xff3E5674))),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          color: Color(0xffE2E8F0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.home_filled, color: Color(0xff3E5674), size: 40),
                            Text(
                              "50+",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xff3E5674),
                              ),
                            ),
                            Text("Parceiros", style: TextStyle(color: Color(0xff3E5674))),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pets Disponíveis",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF3E5674),
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NavBar(initialIndex: 1),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xfffefefe),
                          foregroundColor: Color(0xff3E5674),
                          shadowColor: Colors.transparent,
                        ),
                        child: Text("Ver todos"),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Card de pets
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
                  
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;

                      int crossAxisCount = width > 650 ? 3 : 2;
                      double aspectRatio = (width / crossAxisCount) / 260;

                      return GridView.builder(
                        itemCount: homePets.length,
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
                          return CardPet(pet: homePets[index]);
                        },
                      );
                    },
                  ),

                  Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color: Color(0xff3E5674),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Pronto para adotar?",
                          style: TextStyle(
                            color: Color(0xfffafafa),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),

                        SizedBox(height: 20),

                        Text(
                          "Navegue por nossos pets disponíveis e encontre seu novo melhor amigo!",
                          style: TextStyle(color: Color(0xfffafafa)),
                        ),

                        SizedBox(height: 20),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NavBar(initialIndex: 1),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xfffefefe),
                            foregroundColor: Color(0xff3E5674),
                            minimumSize: Size(600, 40),
                          ),
                          child: Text("Explorar pets"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
