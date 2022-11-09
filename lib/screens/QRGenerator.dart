import 'package:code_scanner/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGenerator extends StatefulWidget {
  const QRGenerator({Key? key}) : super(key: key);

  @override
  State<QRGenerator> createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {

  String data = "";

  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);
    const double padding = 25;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: sidePadding,
            child: Text(
              'QR-Code Generator',
              style: themeData.textTheme.headline1,
            ),
          ),
          const Padding(
            padding: sidePadding,
            child: Divider(
              height: 25,
              color: COLOR_GREY,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          Center(
            child: Container(
              width: 280,
              decoration: BoxDecoration(
                  border: Border.all(color: COLOR_BLACK, width: 2),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    data = value;
                  });
                },
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    hintText: "QR-Code Inhalt",
                    border: InputBorder.none
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          Center(
            child: QrImage(
              data: data,
              backgroundColor: COLOR_WHITE,
              version: QrVersions.auto,
              size: 300,
            ),
          )
        ],
      ),
    );
  }
}
