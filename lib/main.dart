import 'package:cryptoviewer/constants/themes.dart';
import 'package:cryptoviewer/providers/marketdata.dart';
import 'package:cryptoviewer/providers/theme_provider.dart';
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
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            title: 'Crypto Viewer',
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
