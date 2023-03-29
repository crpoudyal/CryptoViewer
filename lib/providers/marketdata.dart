import 'dart:async';

import 'package:cryptoviewer/models/api_call.dart';
import 'package:cryptoviewer/models/cryptocurrency.dart';
import 'package:flutter/material.dart';

class MarketData with ChangeNotifier {
  bool isLoading = true;
  List<CryptoCurrency> market = [];

  MarketData() {
    getData();
  }

  void getData() async {
    List<dynamic> _market = await APICall.getMarketsData();

    List<CryptoCurrency> temp = [];

    for (var market in _market) {
      CryptoCurrency newCrypto = CryptoCurrency.fromJSON(market);
      temp.add(newCrypto);
    }
    market = temp;
    isLoading = false;
    notifyListeners();
    Timer(const Duration(seconds: 3), () {
      getData();
    });
  }
}
