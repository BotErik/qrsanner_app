import 'package:code_scanner/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:code_scanner/custom/QROverlay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import './LandingScreen.dart' as main;

class QRScanner extends StatefulWidget {

  const QRScanner({
    Key? key,
  }) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {

  final MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);
    const double padding = 25;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: sidePadding,
            child: Text(
              'QR-Code Scanner',
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
          Padding(
            padding: sidePadding,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  height: size.height * 0.5,
                  child: Stack (
                    children: [
                      MobileScanner(
                        allowDuplicates: false,
                        controller: cameraController,
                        onDetect: (barcode, args) async {
                          final String? code = barcode.rawValue;
                          final Uri url = Uri.parse(code!);

                          final urlRegExp = RegExp(r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
                          final urlMatches = urlRegExp.allMatches(code);

                          if (urlMatches.isNotEmpty) {
                            if (main.light) {
                              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                throw 'Link konnte nicht geöffnet werden!';
                              }
                            } else {
                              showLinkDialog(code, url);
                            }
                          } else {
                            showAlertDialog(code);
                          }
                        },
                      ),
                      QRScannerOverlay(
                        overlayColour: COLOR_BLACK.withOpacity(0.5),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: sidePadding,
            child: Divider(
              height: 25,
              color: COLOR_GREY,
            ),
          ),
          Padding(
            padding: sidePadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  color: COLOR_BLACK,
                  icon: ValueListenableBuilder(
                    valueListenable: cameraController.cameraFacingState,
                    builder: (context, state, child) {
                      switch (state) {
                        case CameraFacing.front:
                          return const Icon(Icons.camera_front);
                        case CameraFacing.back:
                          return const Icon(Icons.camera_rear);
                      }
                    },
                  ),
                  iconSize: 40,
                  onPressed: () => cameraController.switchCamera(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void showAlertDialog(String code) {
    Widget onPositiveButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("Ok"),
    );

    AlertDialog dialog = AlertDialog(
      actions: [onPositiveButton],
      title: const Text("QR-Code Inhalt"),
      content: Text(code),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      }
    );
  }

  void showLinkDialog(String code, Uri url) {
    Widget onPositiveButton = TextButton(
      onPressed: () async {
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          throw 'Link konnte nicht geöffnet werden!';
        }
        Navigator.of(context).pop();
      },
      child: const Text("Öffnen"),
    );
    Widget onNegativeButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("Abbrechen"),
    );

    AlertDialog dialog = AlertDialog(
      actions: [onNegativeButton, onPositiveButton],
      title: const Text("Link öffnen?"),
      content: Text(code),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        }
    );
  }
}
