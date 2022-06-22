import 'package:cryptoviewer/models/cryptocurrency.dart';
import 'package:cryptoviewer/providers/marketdata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
              const Text(
                "Crypto Today",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Consumer<MarketData>(
                  builder: (context, marketData, child) {
                    if (marketData.isLoading == true) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (marketData.market.isNotEmpty) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: marketData.market.length,
                          itemBuilder: (context, index) {
                            CryptoCurrency currentCrypto =
                                marketData.market[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                  currentCrypto.image!,
                                ),
                              ),
                              title: Text(currentCrypto.name!),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "रू ${currentCrypto.currentPrice!.toStringAsFixed(4)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.blue),
                                  ),
                                  Builder(builder: (context) {
                                    double priceChange =
                                        currentCrypto.priceChange24!;
                                    double priceChangePercentage =
                                        currentCrypto.priceChangePercentage24!;

                                    if (priceChange < 0) {
                                      // negative
                                      return Text(
                                        "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                                        style: TextStyle(color: Colors.red),
                                      );
                                    } else {
                                      // positive
                                      return Text(
                                        "+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
                                        style: TextStyle(color: Colors.green),
                                      );
                                    }
                                  })
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text(
                            "Data Not Found",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
