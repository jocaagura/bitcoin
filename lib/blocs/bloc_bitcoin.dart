import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../models/model_bitcoin_only_day.dart';
import '../models/model_bitcoin_resume.dart';
import '../services/service_http.dart';

class BlocBitcoin {
  BlocBitcoin() {
    /// All of initial checks will be here and
    /// will be executed once
    ///  we have to polling info each 60 seconds the info of bitcoin for today
    Future.delayed(Duration(milliseconds: 200), () {
      subscribeBitcoinTodayInfo();
    });
  }

  /// controllers
  final _bitcoinResumeController = BehaviorSubject<ModelBitcoin?>();

  final _bitcoinOnlyDayController = BehaviorSubject<ModelBitcoinOnlyDay?>();

  ModelBitcoin? get bitcoinInfo => _bitcoinResumeController.valueOrNull;

  Stream<ModelBitcoin?> get bitcoinInfoStream =>
      _bitcoinResumeController.stream;

  ModelBitcoinOnlyDay? get modelBitcoinOnlyDay =>
      _bitcoinOnlyDayController.valueOrNull;

  Stream<ModelBitcoinOnlyDay?> get modelBitcoinDayStream =>
      _bitcoinOnlyDayController.stream;

  getTodayBitcoinInfo([String moneyCode = 'COP']) async {
    final url = 'https://api.coindesk.com/v1/bpi/currentprice/$moneyCode.json';
    try {
      final json = await ServiceHttp.jsonGetRequestHttp(url: url);
      modelBitcoinOnlyDay = ModelBitcoinOnlyDay.fromJson(json);
    } catch (e) {
      _bitcoinOnlyDayController.addError(e);
    }
  }

  getBitcoinWeekInfo() async {
    final url = 'https://api.coindesk.com/v1/bpi/historical/close.json';
    try {
      final json = await ServiceHttp.jsonGetRequestHttp(url: url);
      bitcoinInfo = ModelBitcoin.fromJson(json);
    } catch (e) {
      _bitcoinResumeController.addError(e);
    }
  }

  set bitcoinInfo(ModelBitcoin? bitcoinInfo) {
    _bitcoinResumeController.sink.add(bitcoinInfo);
  }

  set modelBitcoinOnlyDay(ModelBitcoinOnlyDay? modelBitcoinOnlyDay) {
    _bitcoinOnlyDayController.sink.add(modelBitcoinOnlyDay);
  }

  double returnUSDtoCopValue(double value) {
    return value * 3917.0;
  }

  double returnUSDtoEURValue(double value) {
    return value * 0.84;
  }

  /// Subscriptions
  ///  handle evrey 60 seconds query subscription
  Timer? timerQueryBitCoinOnlyDay;

  subscribeBitcoinTodayInfo() {
    getBitcoinWeekInfo();
    getTodayBitcoinInfo();
    if (timerQueryBitCoinOnlyDay != null) {
      timerQueryBitCoinOnlyDay?.cancel();
      timerQueryBitCoinOnlyDay = null;
    }
    timerQueryBitCoinOnlyDay = Timer.periodic(Duration(seconds: 60), (timer) {
      getBitcoinWeekInfo();
      getTodayBitcoinInfo();
    });
  }

  dispose() {
    _bitcoinResumeController.close();
    _bitcoinOnlyDayController.close();
    timerQueryBitCoinOnlyDay?.cancel();
  }
}

final BlocBitcoin blocBitcoin = BlocBitcoin();
