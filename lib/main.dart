import 'package:cryptoviewer/providers/marketdata.dart';
import 'package:cryptoviewer/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketData>(
          create: (context) => MarketData(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crypto Viewer',
        home: HomeScreen(),
      ),
    );
  }
}
