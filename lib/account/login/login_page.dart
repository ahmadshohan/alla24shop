import 'package:alla24/app_route.dart';
import 'package:alla24/colors.dart';
import 'package:alla24/shared/widgets/closable.dart';
import 'package:alla24/shared/widgets/j_raised_button.dart';
import 'package:alla24/shared/widgets/loader.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shimmer/shimmer.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController _loginController = LoginController();
  final _formKey = GlobalKey<FormState>();
  String _logo = 'assets/png/app_logo.png';
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1000), () async {
      await _loginController.init();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Observer(
            builder: (_) => Stack(children: <Widget>[
                  SafeArea(
                    top: true,
                    bottom: true,
                    left: false,
                    right: false,
                    child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          _buildLogo(),
                          SizedBox(height: 10),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  Form(
                                      key: _formKey,
                                      autovalidate:
                                          _loginController.autoValidate,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          ..._buildInputs(),
                                        ],
                                      )),
                                  SizedBox(height: 10),
                                  _buildActions(),
                                  SizedBox(height: 20),
                                  _buildLoginButton(),
                                  SizedBox(height: 10),
                                  _buildDontHaveAccount(),
                                ],
                              ))
                        ])),
                  ),
                  Visibility(
                      visible: _loginController.loading,
                      child: Center(child: Loader())),
                ])));
  }

  _buildLogo() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 60),
        child: Image.asset(
          _logo,
          fit: BoxFit.cover,
        ));
  }

  _buildInputs() {
    return [
      Text('الأيميل', style: TextStyle(color: Colors.black, fontSize: 17)),
      TextFormField(
          textDirection: TextDirection.rtl,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => _loginController.model.email = value,
          validator: (_) => _loginController.checkEmail(),
          style: TextStyle(color: Alla24Colors.black),
          textInputAction: TextInputAction.next,
          focusNode: _emailFocusNode,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          decoration: InputDecoration(
              suffixIcon: Icon(EvaIcons.email),
              fillColor: Colors.white10,
              filled: true,
              labelStyle: TextStyle(color: Alla24Colors.black),
              contentPadding: EdgeInsets.all(16),
              border: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10),
              ))),
      SizedBox(height: 10),
      Text('كلمة السر', style: TextStyle(color: Colors.black, fontSize: 17)),
      Observer(
        builder: (_) => TextFormField(
            textDirection: TextDirection.rtl,
            style: TextStyle(color: Alla24Colors.black),
            obscureText: !_loginController.showPassword,
            focusNode: _passwordFocusNode,
            onChanged: (value) => _loginController.model.password = value,
            validator: (_) => _loginController.checkPassword(),
            decoration: InputDecoration(
                fillColor: Colors.white10,
                filled: true,
                labelStyle: TextStyle(color: Alla24Colors.black),
                contentPadding: EdgeInsets.all(16),
                suffixIcon: GestureDetector(
                    onTap: () => _loginController.changeViewPassword(),
                    child: Icon(
                        _loginController.showPassword
                            ? EvaIcons.eye
                            : EvaIcons.eyeOff,
                        color: Alla24Colors.black)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ))),
      ),
    ];
  }

  _buildActions() {
    return Row(children: [
      Row(children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.orange),
          child: Observer(
            builder: (_) => Checkbox(
              activeColor: Colors.orange,
              checkColor: Alla24Colors.white,
              value: _loginController.rememberMe,
              onChanged: (value) => _loginController.changeRememberMe(),
            ),
          ),
        ),
        GestureDetector(
            onTap: () => _loginController.changeRememberMe(),
            child: Text("تذكر كلمة السر",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Alla24Colors.black, fontSize: 12))),
      ]),
      Spacer(),
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoute.forgotPasswordRoute);
        },
        child: Text(
          "نسيت كلمة المرور؟",
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Alla24Colors.button,
                fontSize: 12,
                decoration: TextDecoration.underline,
              ),
        ),
      ),
    ]);
  }

  _buildLoginButton() {
    return SizedBox(
        height: 50,
        width: double.infinity,
        child: JRaisedButton(
            onPressed: () => Navigator.pushNamed(context, AppRoute.mainRoute),
            // onPressed: () async {
            //   KeyBoard.close(context);
            //   if (_formKey.currentState.validate()) {
            //     // await _loginController.login(context);
            //     Navigator.of(context).pushReplacementNamed(AppRoute.mainRoute);
            //   } else
            //     _loginController.autoValidate = true;
            // },
            text: "تسجيل الدخول"));
  }

  _buildDontHaveAccount() {
    return Center(
        child: GestureDetector(
            onTap: () =>
                Navigator.pushReplacementNamed(context, AppRoute.registerRoute),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "ليس لديك حساب؟",
                  style: TextStyle(
                      color: Alla24Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 19)),
              TextSpan(
                  text: "أنشاء حساب",
                  style: TextStyle(
                    color: Alla24Colors.button,
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                  ))
            ]))));
  }
}
