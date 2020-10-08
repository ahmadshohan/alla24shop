import 'package:alla24/colors.dart';
import 'package:alla24/shared/widgets/closable.dart';
import 'package:alla24/shared/widgets/j_raised_button.dart';
import 'package:alla24/shared/widgets/loader.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'forgot_password_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String _logo = 'assets/png/welcome_logo.png';
  final ForgotPasswordController _forgotPasswordController =
      ForgotPasswordController();

  void initState() {
    super.initState();
    Future<void>.delayed(Duration(milliseconds: 1000), () async {
      await _forgotPasswordController.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) => Stack(
          children: [
            SafeArea(
                top: true,
                bottom: true,
                left: false,
                right: false,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildTitleAndLogo(),
                      SizedBox(height: 50),
                      ..._buildTitles(),
                      SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        autovalidate: _forgotPasswordController.autoValidate,
                        child: _buildInputs(),
                      ),
                      Observer(
                        builder: (_) => Visibility(
                          visible: _forgotPasswordController.showTimer,
                          child: Text('${_forgotPasswordController.timer}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Alla24Colors.black)),
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildSendButton(),
                      SizedBox(height: 20),
                      _buildResend()
                    ],
                  ),
                ))),
            Visibility(
                visible: _forgotPasswordController.loading,
                child: Center(child: Loader()))
          ],
        ),
      ),
    );
  }

  _buildTitleAndLogo() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Image.asset(
                    _logo,
                    height: 80,
                    width: 80,
                  ),
                  Text('alla24',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Alla24Colors.black,
                      ))
                ]))
          ])
        ]));
  }

  _buildTitles() {
    return [
      Text("نسيت كلمة السر ؟",
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Alla24Colors.button)),
    ];
  }

  _buildInputs() {
    return TextFormField(
        textAlign: TextAlign.end,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onChanged: (value) => _forgotPasswordController.model.email = value,
        validator: (_) => _forgotPasswordController.checkEmail(),
        onFieldSubmitted: (_) {
          KeyBoard.close(context);
        },
        style: TextStyle(color: Alla24Colors.black),
        decoration: InputDecoration(
            labelText: "الأيميل",
            prefixIcon: Icon(EvaIcons.email, color: Colors.grey),
            fillColor: Colors.white10,
            filled: true,
            labelStyle: TextStyle(
              color: Alla24Colors.black,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(10),
            )));
  }

  _buildSendButton() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: JRaisedButton(
          onPressed: () async {
            KeyBoard.close(context);
            if (_formKey.currentState.validate()) {
              await _forgotPasswordController.forgotPassword(context);
            } else
              _forgotPasswordController.autoValidate = true;
          },
          text: 'أرسل'),
    );
  }

  _buildResend() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      GestureDetector(
        onTap: () async {
          KeyBoard.close(context);
          if (_formKey.currentState.validate()) {
            _forgotPasswordController.resend();
            await _forgotPasswordController.forgotPassword(context);
          } else
            _forgotPasswordController.autoValidate = true;
        },
        child: Text("إعادة الأرسال",
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Alla24Colors.button,
                fontSize: 19,
                decoration: TextDecoration.underline)),
      ),
      SizedBox(width: 10),
      Text("لم يصلك ايميل ؟",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Alla24Colors.black, fontSize: 19)),
    ]);
  }
}
