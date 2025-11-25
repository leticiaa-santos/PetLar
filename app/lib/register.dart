import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  Future<void> registrarUsuario() async {
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;

    try {
      UserCredential cred = await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: senhaController.text.trim(),
      );

      final uid = cred.user!.uid;
      final userDoc = firestore.collection("usuarios").doc(uid);

      final snapshot = await userDoc.get();

      if (!snapshot.exists) {
        await userDoc.set({
          "name": nomeController.text.trim(),
          "email": emailController.text.trim(),
          "createdAt": FieldValue.serverTimestamp(),
        });

        await userDoc.collection("favoritos").doc("init").set({
          "created": true,
        });
      }

      Navigator.pushReplacementNamed(context, "/home");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao criar conta: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffefefe),
      body: SingleChildScrollView(
        child: Column(
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
                  // LOGO
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
                    )
                    
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Faça seu cadastro!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 
                 
                ],
              ),
            ),

            SizedBox(height: 25),

            //Aba Entrar / Cadastrar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Color(0xffF0F2F5),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, "/login"),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: Text(
                          "Entrar",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xff3E5674),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25),

            // FORMULÁRIO
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nome completo",
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 6),
                  TextField(
                    controller: nomeController,
                    decoration: _inputStyle("Seu nome"),
                  ),

                  SizedBox(height: 20),

                  Text("Email", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 6),
                  TextField(
                    controller: emailController,
                    decoration: _inputStyle("seu@email.com"),
                  ),

                  SizedBox(height: 20),

                  Text("Senha", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 6),
                  TextField(
                    controller: senhaController,
                    obscureText: true,
                    decoration: _inputStyle("••••••"),
                  ),

                  SizedBox(height: 35),

                  // BOTÃO DE CADASTRO
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: registrarUsuario,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff3E5674),
                        elevation: 6,
                        shadowColor:
                        Color(0xff3E5674).withOpacity(0.35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        "Criar conta",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // LINK PARA LOGIN
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, "/login"),
                      child: Text(
                        "Já tem conta? Entrar",
                        style: TextStyle(
                          color: Color(0xff3E5674),
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---- DECORAÇÃO DOS INPUTS ----
  InputDecoration _inputStyle(String placeholder) {
    return InputDecoration(
      hintText: placeholder,
      filled: true,
      fillColor: Color(0xffF0F2F5),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Color(0xffF0F2F5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Color(0xff435585)),
      ),
    );
  }
}
