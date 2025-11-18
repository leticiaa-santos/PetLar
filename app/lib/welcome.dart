import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0XFF3E5674),
        body: SafeArea( //para evitar que o conteudo fique em baixo da barra de status
          child:
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //imagem da logo
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
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
                    )
                    
                  ),

                  SizedBox(height: 30),

                  //titulo
                  Text(
                    "Bem-vindo ao PetLar",
                    textAlign: TextAlign.center,
                    
                    style: TextStyle(
                      color: Color(0xFFeef5ff),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  //subtitulo
                  Text(
                    "Encontre cães e gatos disponíveis para adoção perto de você.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0XFFeef5ff),
                    ),
                  ),

                  SizedBox(height: 40),

                  //botão login
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, "/login");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFeef5ff),
                        foregroundColor: Color(0xFF3E5674),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 8,
                        shadowColor: Colors.black.withValues(alpha: 0.4),
                      ),
                      child: Text(
                        "Entrar",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 15),

                  //botão registro
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/register");
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Color(0XFFeef5ff),
                        foregroundColor: Color(0XFF3E5674),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 8,
                        shadowColor: Colors.black.withValues(alpha: 0.4),
                      ),
                      child: 
                        Text(
                          "Criar Conta",
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                    ),
                  ),
                  
                ],
              ),

              ), 
          ),
      ),
    );
  }
}