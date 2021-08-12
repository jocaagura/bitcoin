import 'package:flutter/material.dart';

import '../blocs/bloc_bitcoin.dart';
import '../helpers.dart';
import '../models/model_bitcoin_resume.dart';
import 'detail_bitcoin_page.dart';
import 'detail_today_bitcoin_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    void _goToTodayBitcoinInfo() {
      blocBitcoin.getTodayBitcoinInfo();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailTodayBitcoinPage(),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              onPressed: () {
                blocBitcoin.getBitcoinWeekInfo();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: StreamBuilder(
        stream: blocBitcoin.bitcoinInfoStream,
        builder: (BuildContext context, AsyncSnapshot<ModelBitcoin?> snapshot) {
          String message = 'Recuperando la informacion de la semana';
          if (snapshot.hasError) {
            message = 'Error: ${snapshot.error}';
          }

          if (snapshot.hasData) {
            final ModelBitcoin? bitcoin = blocBitcoin.bitcoinInfo;

            if (bitcoin != null) {
              final Map<String, double> infoWeek = bitcoin
                  .returnAfterDate(DateTime.now().subtract(Duration(days: 15)));

              return ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: infoWeek.length,
                itemBuilder: (context, index) {
                  final String dayDate = infoWeek.keys.toList()[index];
                  final double dayInfoValue = infoWeek.values.toList()[index];
                  final String dayInfoValueLabel =
                      Helpers.returnMoneyFormat(dayInfoValue.toString());

                  return ListTile(
                    onTap: () {
                      index == (infoWeek.length - 1)
                          ? _goToTodayBitcoinInfo()
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailBitcoinPage(
                                    dayInfoDate: dayDate,
                                    dayInfoValue: dayInfoValue,
                                  )));
                    },
                    trailing: Icon(Icons.arrow_forward_ios),
                    leading: Icon(Icons.money),
                    title: Text('USD $dayInfoValueLabel'),
                    subtitle: Text('$dayDate'),
                    horizontalTitleGap: 20.0,
                    tileColor: (index == (infoWeek.length - 1))
                        ? Colors.orangeAccent
                        : Theme.of(context).canvasColor,
                  );
                },
              );
            }
          }

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
              CircularProgressIndicator(),
              SizedBox(
                height: 10.0,
                width: double.maxFinite,
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToTodayBitcoinInfo,
        child: Icon(Icons.calendar_today),
      ),
    );
  }
}
