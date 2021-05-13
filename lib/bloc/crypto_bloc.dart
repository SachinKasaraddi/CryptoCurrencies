import 'dart:async';

import 'package:cryptoapp/models/crypto_base_response.dart';
import 'package:cryptoapp/services/api_manager.dart';

class CryptoBloc {
  late int counter;
  final _stateStreamController = StreamController<List<Datum?>>();
  StreamSink<List<Datum?>> get _latestCurrenciesSink =>
      _stateStreamController.sink;
  Stream<List<Datum?>> get latestCurrenciesStream =>
      _stateStreamController.stream;

  final _eventStreamController = StreamController<CryptoAction>();
  StreamSink<CryptoAction> get eventSink => _eventStreamController.sink;
  Stream<CryptoAction> get _eventStream => _eventStreamController.stream;

  CryptoBloc() {
    counter = 0;
    var currenciesList = List<Datum?>.empty(growable: true);

    _eventStream.listen((event) async {
      switch (event) {
        case CryptoAction.FETCH:
          currenciesList = await _fetchCurrencies(currenciesList);
          break;
        case CryptoAction.LOADMORE:
          await _loadMoreCurrencies(currenciesList);
          break;
      }
    });
  }

  Future _loadMoreCurrencies(List<Datum?> currenciesList) async {
    try {
      counter = counter + 1;
      var latestCurrencies =
          await ApiManager().getCryptoCurrencies(counter);
      if (latestCurrencies.data != null) {
        currenciesList.addAll(latestCurrencies.data!);
        _latestCurrenciesSink.add(currenciesList);
      }
    } catch (e) {}
  }

  Future<List<Datum?>> _fetchCurrencies(List<Datum?> currenciesList) async {
    try {
      counter = 1;
      var latestCurrencies = await ApiManager().getCryptoCurrencies(1);
      if (latestCurrencies.data != null) {
        currenciesList = latestCurrencies.data!;
        _latestCurrenciesSink.add(currenciesList);
      } else {
        _latestCurrenciesSink.addError('Something went wrong');
      }
    } catch (e) {
      _latestCurrenciesSink.addError('Something went wrong');
    }
    return currenciesList;
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}

enum CryptoAction { FETCH, LOADMORE }
