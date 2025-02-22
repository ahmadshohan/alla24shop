import 'package:alla24/account/register/register_controller.dart';
import 'package:alla24/app_route.dart';
import 'package:alla24/colors.dart';
import 'package:alla24/shared/constant/data_list.dart';
import 'package:alla24/shared/widgets/closable.dart';
import 'package:alla24/shared/widgets/j_raised_button.dart';
import 'package:alla24/shared/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shimmer/shimmer.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _logo = 'assets/png/app_logo.png';
  RegisterController _registerController = RegisterController();
  FocusNode _nameFN = FocusNode();
  FocusNode _telefonNumberFN = FocusNode();
  FocusNode _emailFN = FocusNode();
  FocusNode _passwordFN = FocusNode();
  FocusNode _passwordConfirmFN = FocusNode();
  FocusNode _birthFN = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _passwordConfirmFN.dispose();
    _birthFN.dispose();
    _emailFN.dispose();
    _nameFN.dispose();
    _passwordFN.dispose();
    _telefonNumberFN.dispose();
  }

  void initState() {
    super.initState();
    Future<void>.delayed(Duration(milliseconds: 1000), () async {
      await _registerController.init();
    });
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
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 10),
                                      Form(
                                        key: _formKey,
                                        autovalidate:
                                            _registerController.autoValidate,
                                        child: _buildInputs(),
                                      ),
                                      SizedBox(height: 20),
                                      _buildRegisterButton(),
                                      SizedBox(height: 10),
                                      _buildHaveAccount()
                                    ])),
                          ]))),
                  Visibility(
                      visible: _registerController.loading,
                      child: Center(child: Loader()))
                ])));
  }

  _buildLogo() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 60),
        child: Image.asset(
          _logo,
          fit: BoxFit.cover,
        ));
  }

  _buildInputs() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('الاسم',
                        style: TextStyle(color: Colors.black, fontSize: 17)),
                    TextFormField(
                        style: TextStyle(color: Alla24Colors.black),
                        focusNode: _nameFN,
                        onChanged: (value) =>
                            _registerController.model.fullName = value,
                        validator: (_) => _registerController.checkFullName(),
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(_telefonNumberFN),
                        decoration: InputDecoration(
                            suffixIcon:
                                Icon(EvaIcons.person, color: Colors.grey),
                            fillColor: Alla24Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Alla24Colors.black),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10),
                            ))),
                    Text('الأيميل',
                        style: TextStyle(color: Colors.black, fontSize: 17)),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) =>
                            _registerController.model.email = value,
                        validator: (_) => _registerController.checkEmail(),
                        focusNode: _emailFN,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_passwordFN),
                        style: TextStyle(color: Alla24Colors.black),
                        decoration: InputDecoration(
                            fillColor: Colors.white10,
                            filled: true,
                            suffixIcon:
                                Icon(EvaIcons.email, color: Colors.grey),
                            labelStyle: TextStyle(color: Alla24Colors.black),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10),
                            ))),
                    Text('رقم الهاتف',
                        style: TextStyle(color: Colors.black, fontSize: 17)),
                    TextFormField(
                        keyboardType: TextInputType.numberWithOptions(),
                        textInputAction: TextInputAction.next,
                        focusNode: _telefonNumberFN,
                        onChanged: (value) =>
                            _registerController.model.phoneNumber = value,
                        validator: (_) =>
                            _registerController.checkPhoneNumber(),
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_emailFN),
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            suffixIcon:
                                Icon(EvaIcons.phone, color: Colors.grey),
                            fillColor: Colors.white10,
                            filled: true,
                            labelStyle: TextStyle(color: Alla24Colors.black),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10),
                            ))),
                    Text('أختر محافظة',
                        style: TextStyle(color: Colors.black, fontSize: 17)),
                    _buildCityDropDownButton(),
                    Text('كلمة السر',
                        style: TextStyle(color: Colors.black, fontSize: 17)),
                    Observer(
                        builder: (_) => TextFormField(
                            style: TextStyle(color: Colors.white),
                            textInputAction: TextInputAction.next,
                            focusNode: _passwordFN,
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(_passwordConfirmFN),
                            onChanged: (value) =>
                                _registerController.model.password = value,
                            validator: (_) =>
                                _registerController.checkPassword(),
                            obscureText: !_registerController.showPassword,
                            decoration: InputDecoration(
                                fillColor: Colors.white10,
                                filled: true,
                                labelStyle: TextStyle(
                                  color: Alla24Colors.black,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                suffixIcon: GestureDetector(
                                    onTap: () => _registerController
                                        .changeViewPassword(),
                                    child: Icon(_registerController.showPassword
                                        ? EvaIcons.eye
                                        : EvaIcons.eyeOff)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))))),
                    Text('تأكيد كلمة السر',
                        style: TextStyle(color: Colors.black, fontSize: 17)),
                    Observer(
                      builder: (_) => TextFormField(
                          style: TextStyle(color: Colors.white),
                          textInputAction: TextInputAction.next,
                          focusNode: _passwordConfirmFN,
                          onChanged: (value) =>
                              _registerController.model.passwordConfirm = value,
                          validator: (_) =>
                              _registerController.checkMatchPassword(),
                          obscureText: !_registerController.showPassword,
                          decoration: InputDecoration(
                              fillColor: Colors.white10,
                              filled: true,
                              labelStyle: TextStyle(color: Alla24Colors.black),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              suffixIcon: GestureDetector(
                                onTap: () =>
                                    _registerController.changeViewPassword(),
                                child: Icon(_registerController.showPassword
                                    ? EvaIcons.eye
                                    : EvaIcons.eyeOff),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                    ),
                  ])),
        ]);
  }

  _buildRegisterButton() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      width: double.infinity,
      child: JRaisedButton(
          onPressed: () async {
            KeyBoard.close(context);
            if (_formKey.currentState.validate()) {
              Navigator.of(context).pushReplacementNamed(AppRoute.mainRoute);
              // await _registerController.register(context);
            } else
              _registerController.autoValidate = true;
          },
          text: "أنشئ حساب"),
    );
  }

  _buildHaveAccount() {
    return Center(
        child: GestureDetector(
            onTap: () =>
                Navigator.pushReplacementNamed(context, AppRoute.loginRoute),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: ' هل لديك حساب بالفعل؟',
                  style: TextStyle(
                      color: Alla24Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 17)),
              TextSpan(
                  text: 'تسجيل الدخول',
                  style: TextStyle(
                      color: Alla24Colors.button,
                      fontWeight: FontWeight.w500,
                      fontSize: 17))
            ]))));
  }

  _buildCityDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String city in cityList) {
      var newItem = DropdownMenuItem(
          child: Text(city, overflow: TextOverflow.ellipsis), value: city);
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
        isExpanded: true,
        elevation: 7,
        onChanged: (selectedCity) {
          _registerController.selectedCity(selectedCity);
        },
        value: _registerController.city,
        items: dropDownItems);
  }
}
