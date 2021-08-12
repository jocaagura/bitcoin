import 'package:flutter/material.dart';

import '../blocs/bloc_bitcoin.dart';
import '../helpers.dart';
import 'detail_today_bitcoin_page.dart';
import 'widgets/appbar_widget.dart';

class DetailBitcoinPage extends StatelessWidget {
  const DetailBitcoinPage({required this.dayInfoDate, this.dayInfoValue = 0.0});

  final String dayInfoDate;
  final double dayInfoValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BitcoinApbarWidget(title: 'Reporte del día $dayInfoDate'),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          SizedBox(
            height: 20.0,
          ),
          Text(
            'El valor del bitcon para este día fue de:',
            style: Theme.of(context).textTheme.headline4,
          ),
          ListTile(
            title: Text(
                'USD ${Helpers.returnMoneyFormat(dayInfoValue.toString())}'),
            subtitle: Text('En dolares'),
          ),
          Divider(),
          ListTile(
            title: Text(
                'EUR ${Helpers.returnMoneyFormat(blocBitcoin.returnUSDtoEURValue(dayInfoValue).toString())}'),
            subtitle: Text('En euros'),
          ),
          Divider(),
          ListTile(
            title: Text(
                'COP ${Helpers.returnMoneyFormat(blocBitcoin.returnUSDtoCopValue(dayInfoValue).toString())}'),
            subtitle: Text('En pesos colombianos'),
          ),
          Divider(),
          ListTile(
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).backgroundColor,
            ),
            tileColor: Theme.of(context).accentColor,
            title: Text(
              'Ver el día de hoy',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Theme.of(context).backgroundColor),
            ),
            onTap: () {
              blocBitcoin.getTodayBitcoinInfo();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailTodayBitcoinPage(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
