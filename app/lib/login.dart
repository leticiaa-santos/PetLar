import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  bool _loading = false;
  bool _obscure = true;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: senhaController.text.trim(),
      );

      Navigator.pushReplacementNamed(context, "/home");
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao fazer login: $e")),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeef5ff),
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
                    )
                    
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Faça seu login!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            
            // ABA ENTRAR / CADASTRAR
            
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xff3E5674),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Entrar",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, "/register"),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: Text(
                          "Cadastrar",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // FORMULÁRIO
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // EMAIL
                    Text("Email", style: TextStyle(fontSize: 16)),
                    SizedBox(height: 6),
                    TextFormField(
                      controller: emailController,
                      decoration: _inputStyle("seu@email.com"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Digite seu e-mail";
                        }
                        if (!value.contains("@")) {
                          return "Digite um e-mail válido";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20),

                    // SENHA
                    Text("Senha", style: TextStyle(fontSize: 16)),

                    SizedBox(height: 6),

                    TextFormField(
                      controller: senhaController,
                      obscureText: _obscure,
                      decoration: _inputStyle("••••••").copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() => _obscure = !_obscure);
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Digite sua senha";
                        }
                        if (value.length < 6) {
                          return "A senha precisa ter pelo menos 6 caracteres";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 35),

                    // BOTÃO ENTRAR
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff3E5674),
                          elevation: 6,
                          shadowColor:
                              Color(0xff3E5674).withOpacity(0.35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: _loading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Entrar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // LINK PARA CADASTRO
                    Center(
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, "/register"),
                        child: Text(
                          "Não tem conta? Cadastre-se",
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
            ),
          ],
        ),
      ),
    );
  }


  // Decoração do input
  InputDecoration _inputStyle(String placeholder) {
    return InputDecoration(
      hintText: placeholder,
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Color(0xff435585)),
      ),
    );
  }
}
