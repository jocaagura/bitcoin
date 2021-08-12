import 'package:flutter/material.dart';

import '../../blocs/bloc_bitcoin.dart';

class BitcoinApbarWidget extends StatelessWidget with PreferredSizeWidget {
  const BitcoinApbarWidget({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        IconButton(
            onPressed: () {
              blocBitcoin.getBitcoinWeekInfo();
              blocBitcoin.getTodayBitcoinInfo();
            },
            icon: Icon(Icons.refresh))
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}
