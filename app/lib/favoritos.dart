import 'package:flutter/material.dart';

class Favoritos extends StatelessWidget {
  const Favoritos({super.key});

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite,
                      color: Color(0xFFFFFFFF),),

                      SizedBox(width: 10),

                      Text(
                        "Meus favoritos",
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
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0XFFeef5ff),  
                    ),
                  ),
                ]
              ),
            ),

            const SizedBox(height: 40),

            

          ]
        )
      )
    );
  }
}