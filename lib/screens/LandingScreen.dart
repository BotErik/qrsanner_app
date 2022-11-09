import 'package:code_scanner/custom/BorderBox.dart';
import 'package:code_scanner/screens/QRGenerator.dart';
import 'package:code_scanner/screens/QRScanner.dart';
import 'package:code_scanner/utils/constants.dart';
import 'package:code_scanner/utils/widget_functions.dart';
import 'package:flutter/material.dart';

bool light = false;

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    final screen = [
      const QRScanner(),
      const QRGenerator()
    ];

    final Size size = MediaQuery.of(context).size;
    const double padding = 25;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return SafeArea(
      child: Scaffold(
        appBar: null,
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(padding),
            SizedBox(
              height: size.height * 0.1,
              width: size.width,
              child: Padding(
                padding: sidePadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => _onButtonPressed(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(75, 75),
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                      ),
                      child: const BorderBox(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          width: 75,
                          height: 75,
                          child: Icon(Icons.menu, color: COLOR_BLACK)
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _onMenuButtonPressed(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(75, 75),
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                      ),
                      child: const BorderBox(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          width: 75,
                          height: 75,
                          child: Icon(Icons.settings, color: COLOR_BLACK)
                      ),
                    ),
                  ],
                ),
              ),
            ),
            addVerticalSpace(padding),
            SizedBox(
              height: size.height * 0.7,
              width: size.width,
              child: screen[selectedIndex]
            ),
          ],
        ),
      ),
    );
  }

  void _onButtonPressed() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: const Color(0xFF737373),
          height: 170,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
            ),
            child: _BuildBottomNavigationMenu(),
          ),
        );
      }
    );
  }

  void _onMenuButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
            return Container(
                color: const Color(0xFF737373),
                height: 170,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)
                    )
                  ),
                  child: const SettingsMenu(),
                ),
            );
        }
    );
  }

  Column _BuildBottomNavigationMenu() {
    return Column(
        children: <Widget> [
          ListTile(
            leading: const Icon(Icons.camera_alt, size: 40, color: COLOR_BLACK),
            title: const Text('QR-Code Scanner',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500
              ),
            ),
            contentPadding: const EdgeInsets.only(left: 25, top: 20, right: 25, bottom: 10),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                selectedIndex = 0;
              });
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Divider(
              height: 0,
              color: COLOR_GREY,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.qr_code_2, size: 40, color: COLOR_BLACK),
            title: const Text('QR-Code Generator',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
              ),
            ),
            contentPadding: const EdgeInsets.only(left: 25, top: 10, right: 25, bottom: 0),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                selectedIndex = 1;
              });
            },
          )
        ],
      );
  }
}

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({super.key});

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {

  void _onSwitchChanged(bool value) {
    light = value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  <Widget> [
        SwitchListTile(
          value: light,
          title: const Text('Links automatisch öffnen?',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
            ),
          ),
          contentPadding: const EdgeInsets.only(left: 25, top: 20, right: 25, bottom: 10),
          onChanged: (bool value) {
            setState(() {
              _onSwitchChanged(value);
            });
          },
          secondary: const Icon(Icons.link, size: 40, color: COLOR_BLACK),
          activeColor: COLOR_DARK_BLUE,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Divider(
            height: 0,
            color: COLOR_GREY,
          ),
        ),
        const ListTile(
          title: Text('App im Rahmen des Moduls WEBPROG',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400
            ),
          ),
          contentPadding: EdgeInsets.only(left: 25, top: 10, right: 25, bottom: 0),
        )
      ],
    );
  }
}
