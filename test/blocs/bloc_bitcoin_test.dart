import 'package:test/test.dart';

import '../../lib/blocs/bloc_bitcoin.dart';
import '../../lib/models/model_bitcoin_only_day.dart';
import '../../lib/models/model_bitcoin_resume.dart';

main() {
  test('Convert to USD to  COP', () {
    expect(blocBitcoin.returnUSDtoCopValue(1), 3917);
    expect(blocBitcoin.returnUSDtoCopValue(1.0), 3917);
    expect(blocBitcoin.returnUSDtoCopValue(0.0), 0);
    expect(blocBitcoin.returnUSDtoCopValue(-1.0), -3917);
    expect(blocBitcoin.returnUSDtoCopValue(-1), -3917);
  });

  test('Convert to USD to  EUR', () {
    expect(blocBitcoin.returnUSDtoEURValue(1), 0.84);
    expect(blocBitcoin.returnUSDtoEURValue(1.0), 0.84);
    expect(blocBitcoin.returnUSDtoEURValue(0.0), 0);
    expect(blocBitcoin.returnUSDtoEURValue(-1.0), -0.84);
    expect(blocBitcoin.returnUSDtoEURValue(-1), -0.84);
  });

  test('Obtain the info related with bitcoin for today', () async {
    print(DateTime.now());
    await blocBitcoin.getTodayBitcoinInfo();
    print(DateTime.now());
    final checkResponse = blocBitcoin.modelBitcoinOnlyDay;
    print(checkResponse.runtimeType);
    if (checkResponse == null) {
      expect(checkResponse == null, true);
      expect(blocBitcoin.modelBitcoinOnlyDay.runtimeType, ModelBitcoinOnlyDay);
    } else {
      expect(checkResponse is ModelBitcoin, false);
    }
  });

  test('Obtain the info related with bitcoin for two week', () async {
    print(DateTime.now());
    await blocBitcoin.getBitcoinWeekInfo();
    print(DateTime.now());
    final checkResponse = blocBitcoin.bitcoinInfo;
    print(checkResponse?.toJson());
    if (checkResponse == null) {
      expect(checkResponse == null, true);
      expect(blocBitcoin.bitcoinInfo.runtimeType, ModelBitcoin);
    } else {
      expect(checkResponse is ModelBitcoin, false);
    }
  });
}
