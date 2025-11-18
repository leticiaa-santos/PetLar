import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      backgroundColor: const Color(0xffeef5ff),
      body: SingleChildScrollView(
        
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
              decoration: const BoxDecoration(
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
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          )
                        ]
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

                  //subtitulo
                  Text(
                    "Conectando corações a patinhas",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0XFFeef5ff),
                      
                    ),
                  ),
                  
               

                ]
              ),

              
            ),

            SizedBox(height: 40),

            Text(
              "Sobre nós",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0XFF3E5674),

              ),
            ),
          ]
        ),
      ),
    ),
    
    
    );
    
  }
}