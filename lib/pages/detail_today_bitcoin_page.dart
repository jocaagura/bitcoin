import 'package:flutter/material.dart';

import '../blocs/bloc_bitcoin.dart';
import '../helpers.dart';
import '../models/model_bitcoin_only_day.dart';
import 'widgets/appbar_widget.dart';

class DetailTodayBitcoinPage extends StatelessWidget {
  const DetailTodayBitcoinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BitcoinApbarWidget(
        title: 'Reporte detallado del dia ${DateTime.now().toIso8601String()}',
      ),
      body: StreamBuilder<ModelBitcoinOnlyDay?>(
          stream: blocBitcoin.modelBitcoinDayStream,
          builder: (context, snapshot) {
            String message = 'Recuperando la informacion de la semana';
            if (snapshot.hasError) {
              message = 'Error: ${snapshot.error}';
            }

            if (!snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Parece que no estas conectado a internet',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: 10.0,
                    width: double.maxFinite,
                  ),
                  Text(message,
                      style: TextStyle(color: Colors.grey.withOpacity(0.35))),
                  SizedBox(
                    height: 10.0,
                    width: double.maxFinite,
                  ),
                  SizedBox(
                    height: 10.0,
                    width: double.maxFinite,
                  ),
                  ListTile(
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).accentColor,
                    ),
                    title: Text(
                      'Reintentar',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(color: Theme.of(context).accentColor),
                    ),
                    onTap: () {
                      blocBitcoin.getTodayBitcoinInfo();
                      blocBitcoin.getBitcoinWeekInfo();
                    },
                  ),
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                    width: double.maxFinite,
                  ),
                  ListTile(
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).backgroundColor,
                    ),
                    tileColor: Theme.of(context).accentColor,
                    title: Text(
                      'Regresar',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(color: Theme.of(context).backgroundColor),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            }

            ModelBitcoinOnlyDay? _infoToday = snapshot.data;

            final List<Widget> content = [
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                title: Text(
                  'El valor del bitcon para hoy es de:',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: Colors.orangeAccent),
                ),
                subtitle: Text(
                  'Actualizado el ${DateTime.now().toLocal()}',
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
              ),
              ListTile(
                title: Text(
                    'USD ${Helpers.returnMoneyFormat('${_infoToday?.bpi['USD']?.rateFloat}')}'),
                subtitle: Text('En dolares'),
              ),
              Divider(),
              ListTile(
                title: Text(
                    'EUR ${Helpers.returnMoneyFormat('${blocBitcoin.returnUSDtoEURValue(_infoToday?.bpi['USD']?.rateFloat ?? 0.0)}')}'),
                subtitle: Text('En euros'),
              ),
              Divider(),
              ListTile(
                title: Text(
                    'COP ${Helpers.returnMoneyFormat('${_infoToday?.bpi['COP']?.rateFloat}')}'),
                subtitle: Text('En pesos colombianos'),
              ),
              Divider(),
              ListTile(
                title: Text('Disclaimer coinbase '),
                subtitle: Text(
                    '${_infoToday?.disclaimer ?? "No se ha obtenido información"}'),
              ),
              Divider(),
              ListTile(
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).backgroundColor,
                ),
                tileColor: Theme.of(context).accentColor,
                title: Text(
                  'Regresar',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: Theme.of(context).backgroundColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ];

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              children: content,
            );
          }),
    );
  }
}
