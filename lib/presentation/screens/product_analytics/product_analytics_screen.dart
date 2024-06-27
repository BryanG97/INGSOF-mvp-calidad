import 'package:flutter/material.dart';

class ProductAnalyticsScreen extends StatelessWidget {
  static const name = 'product-analytics-screen';
  const ProductAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/pagina_en_construccion.png', height: 300, width: 300),
            const Text(
                    'Disponible próximamente.',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 49, 110, 190),),
            ),
          ],

        ),
      ),
    );
  }
}