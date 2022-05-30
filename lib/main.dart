import 'package:flutter/material.dart';
import 'package:flutter_martgage/screens/calculate_martgage_screen.dart';
import 'package:flutter_martgage/screens/monthly_payment_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 4, 71, 6),
      ),
      routes: {
        '/': (context) => const CalculateMortgageScreen(),
        '/payment': (context) => const MonthlyPaymentScrenn(),
      },
      initialRoute: '/',
      // home: const CalculateMortgageScreen(),
    );
  }
}
