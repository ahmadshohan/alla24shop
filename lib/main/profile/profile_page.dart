import 'package:alla24/colors.dart';
import 'package:alla24/shared/localization/app_localization.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        child: SafeArea(
          top: true,
          bottom: true,
          left: false,
          right: false,
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            _buildProfilePictureName(),
          ])),
        ));
  }

  _buildProfilePictureName() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        color: Alla24Colors.button,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                IconButton(
                    icon:
                        Icon(EvaIcons.arrowForward, color: Alla24Colors.white),
                    onPressed: () => Navigator.pop(context)),
                Text('الحساب',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Alla24Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20)),
                SizedBox()
              ]),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.black12,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset('assets/png/avatar.png',
                            width: 150, height: 150, fit: BoxFit.cover),
                      )),
                  Text(
                    AppLocalization.yourName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Alla24Colors.white),
                  ),
                ],
              )
            ]));
  }
}
