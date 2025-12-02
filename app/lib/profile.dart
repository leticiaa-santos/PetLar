import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  bool editando = false;

  final nomeController = TextEditingController();
  final emailController = TextEditingController();

  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregarDadosUsuario();
  }

  Future<void> carregarDadosUsuario() async {
    final uid = user.uid;

    final doc = await FirebaseFirestore.instance
        .collection("usuarios")
        .doc(uid)
        .get();

    nomeController.text = doc.data()?["name"] ?? "";
    emailController.text = user.email ?? "";

    setState(() => carregando = false);
  }

  // SALVAR APENAS O NOME
  Future<void> salvarAlteracoes() async {
    final uid = user.uid;
    final novoNome = nomeController.text.trim();

    try {
      // Atualiza nome no Firebase Auth
      await user.updateDisplayName(novoNome);

      // Atualiza no Firestore
      await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(uid)
          .update({"name": novoNome});

      setState(() => editando = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Nome atualizado com sucesso!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao salvar: $e")),
      );
    }
  }

  // EXCLUIR CONTA
  Future<void> excluirConta() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final uid = user.uid;

        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(uid)
            .delete();

        await user.delete();

        await FirebaseAuth.instance.signOut();

        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (route) => false,
          );
        }
      }
    } catch (e) {
      print('Erro ao excluir conta: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
                    nomeController.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    emailController.text,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0XFFeef5ff),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // ======== CARD DO PERFIL ========
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  
                  Row(
                    
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Informações do Perfil",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (editando) {
                            salvarAlteracoes();
                          } else {
                            setState(() => editando = true);
                          }
                        },
                        child: Text(
                          editando ? "Salvar" : "Editar",
                          style: TextStyle(color: Color(0xff3E5674)),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // ------------ CAMPO NOME ------------
                  Text("Nome completo",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black87)),
                  SizedBox(height: 5),
                  TextField(
                    controller: nomeController,
                    enabled: editando,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      filled: true,
                      fillColor: Color(0xfff8f8f8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // ------------ EMAIL (somente exibição) ------------
                  Text("Email",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black87)),
                  SizedBox(height: 5),
                  TextField(
                    controller: emailController,
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      filled: true,
                      fillColor: Color(0xfff8f8f8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // ======== BOTÃO SAIR ========
            GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Color(0xff3E5674)),
                    SizedBox(width: 10),
                    Text(
                      "Sair da conta",
                      style: TextStyle(
                        color: Color(0xff3E5674),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // ======== EXCLUIR CONTA ========
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "Confirmar exclusão",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      content: Text(
                        "Tem certeza de que deseja excluir sua conta? Esta ação não pode ser desfeita.",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context); // fecha o pop-up
                            await excluirConta();    // chama sua função original
                          },
                          child: Text(
                            "Excluir",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete_forever, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Excluir conta",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
