import 'package:alla24/app_route.dart';
import 'package:alla24/colors.dart';
import 'package:alla24/shared/localization/app_localization.dart';
import 'package:alla24/shared/widgets/j_raised_button.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Alla24Colors.button,
            title: Center(
              child: Text(AppLocalization.profile,
                  style: TextStyle(color: Colors.white)),
            )),
        body: SafeArea(
            top: true,
            bottom: true,
            left: false,
            right: false,
            child: Stack(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 10, top: 5),
                  child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                    _buildPersonalInfo(),
                  ])))
            ])));
  }

  _buildPersonalInfo() {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 13),
              _buildName(),
              SizedBox(height: 13),
              _buildEmail(),
              SizedBox(height: 13),
              _buildPhoneNumber(),
              SizedBox(height: 13),
              _buildCity(),
              SizedBox(height: 13),
              _buildPassword(),
              SizedBox(height: 13),
              _buildEditInfo(),
            ]));
  }

  _buildName() {
    return TextFormField(
        initialValue: AppLocalization.yourName,
        enabled: false,
        style: TextStyle(color: Alla24Colors.black),
        decoration: InputDecoration(
            labelText: AppLocalization.yourName,
            fillColor: Colors.white30,
            filled: true,
            labelStyle: TextStyle(color: Alla24Colors.black),
            contentPadding: EdgeInsets.all(16),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Alla24Colors.button)),
            border: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(5))));
  }

  _buildEmail() {
    return TextFormField(
        initialValue: AppLocalization.email,
        enabled: false,
        style: TextStyle(color: Alla24Colors.black),
        decoration: InputDecoration(
            labelText: AppLocalization.email,
            fillColor: Colors.white30,
            filled: true,
            labelStyle: TextStyle(color: Alla24Colors.black),
            contentPadding: EdgeInsets.all(16),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Alla24Colors.button)),
            border: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(5),
            )));
  }

  _buildPhoneNumber() {
    return TextFormField(
        initialValue: AppLocalization.phoneNumber,
        enabled: false,
        style: TextStyle(color: Alla24Colors.black),
        decoration: InputDecoration(
            labelText: AppLocalization.phoneNumber,
            filled: true,
            fillColor: Colors.white30,
            labelStyle: TextStyle(color: Alla24Colors.black),
            contentPadding: EdgeInsets.all(16),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Alla24Colors.button)),
            border: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(5),
            )));
  }

  _buildCity() {
    return TextFormField(
        initialValue: 'كركوك',
        enabled: false,
        style: TextStyle(color: Alla24Colors.black),
        decoration: InputDecoration(
            labelText: 'المحافظة',
            suffixIcon: Icon(Icons.arrow_drop_down, color: Alla24Colors.black),
            filled: true,
            fillColor: Colors.white30,
            labelStyle: TextStyle(color: Alla24Colors.black),
            contentPadding: EdgeInsets.all(16),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Alla24Colors.button)),
            border: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(5),
            )));
  }

  _buildPassword() {
    return TextFormField(
        initialValue: AppLocalization.password,
        enabled: false,
        style: TextStyle(color: Alla24Colors.black),
        decoration: InputDecoration(
            labelText: AppLocalization.password,
            fillColor: Colors.white30,
            filled: true,
            labelStyle: TextStyle(color: Alla24Colors.black),
            contentPadding: EdgeInsets.all(16),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Alla24Colors.button)),
            border: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(5),
            )));
  }

  _buildEditInfo() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: JRaisedButton(
          onPressed: () =>
              Navigator.pushNamed(context, AppRoute.editProfileRoute),
          text: AppLocalization.editInformations),
    );
  }
}
