import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:alla24/app_route.dart';
import 'package:alla24/payment/payment_method/payment_method_controller.dart';
import 'package:alla24/shared/constant/payment_method.dart';
import 'package:alla24/shared/widgets/app_search_bar.dart';
import 'package:alla24/shared/widgets/j_raised_button.dart';
import 'package:alla24/shared/widgets/loader.dart';
import 'package:alla24/colors.dart';

class PaymentMethodPage extends StatefulWidget {
  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  PaymentMethodController _controller = PaymentMethodController();
  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar.buildFullAppBar(context),
      body: Observer(
          builder: (_) => Stack(children: [
                SafeArea(
                    top: true,
                    bottom: true,
                    left: false,
                    right: false,
                    child: SingleChildScrollView(
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  _paymentPlan(),
                                  SizedBox(height: 5),
                                  _buildAsyaCard(),
                                  _buildZeinCard(),
                                  _buildReceivePayCard()
                                ])))),
                Visibility(
                    visible: _controller.loading,
                    child: Center(child: Loader()))
              ])),
      bottomNavigationBar: _buildNextButton(),
    );
  }

  _paymentPlan() {
    return Image.asset('assets/png/payment_method.png',
            fit: BoxFit.cover, width: double.infinity)

        //   Row(children: [
        //   Expanded(
        //       child: Text('أختر طريقة الدفع',
        //           overflow: TextOverflow.ellipsis,
        //           style: TextStyle(color: Colors.black, fontSize: 17))),
        //   Expanded(
        //       child: Text('تفاصيل الدفع',
        //           overflow: TextOverflow.ellipsis,
        //           style: TextStyle(color: Colors.black, fontSize: 17))),
        //   Expanded(
        //       child: Text('بيانات المستلم ',
        //           overflow: TextOverflow.ellipsis,
        //           style: TextStyle(color: Colors.black, fontSize: 17)))
        // ])

        ;
  }

  _buildAsyaCard() {
    return Card(
        elevation: 5,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.18,
          child: Center(
            child: Theme(
                data: ThemeData(unselectedWidgetColor: Alla24Colors.black),
                child: RadioListTile(
                    value: PaymentMethod.Asya,
                    groupValue: _controller.selectedPaymentMethod,
                    title: Row(children: [
                      Icon(Icons.satellite, color: Alla24Colors.black),
                      Text('اسيا حوالة',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18))
                    ]),
                    activeColor: Alla24Colors.button,
                    onChanged: (newValue) {
                      _controller.setSelectedPaymentMethodType(newValue);
                    })),
          ),
        ));
  }

  _buildZeinCard() {
    return Card(
        elevation: 5,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.18,
          child: Center(
            child: Theme(
                data: ThemeData(unselectedWidgetColor: Alla24Colors.black),
                child: RadioListTile(
                    value: PaymentMethod.Zein,
                    groupValue: _controller.selectedPaymentMethod,
                    title: Row(children: [
                      Icon(Icons.star, color: Alla24Colors.black),
                      Text('زين كاش',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18))
                    ]),
                    activeColor: Alla24Colors.button,
                    onChanged: (newValue) {
                      _controller.setSelectedPaymentMethodType(newValue);
                    })),
          ),
        ));
  }

  _buildReceivePayCard() {
    return Card(
        elevation: 5,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.18,
          child: Center(
            child: Theme(
                data: ThemeData(unselectedWidgetColor: Alla24Colors.black),
                child: RadioListTile(
                    value: PaymentMethod.ReceivePay,
                    groupValue: _controller.selectedPaymentMethod,
                    title: Row(children: [
                      Icon(Icons.monetization_on, color: Alla24Colors.black),
                      Text('الدفع عند الأستلام',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18))
                    ]),
                    activeColor: Alla24Colors.button,
                    onChanged: (newValue) {
                      _controller.setSelectedPaymentMethodType(newValue);
                    })),
          ),
        ));
  }

  _buildNextButton() {
    return Container(
        height: 60,
        padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        width: double.infinity,
        child: JRaisedButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoute.paymentDetailRoute),
            text: 'التالي'));
  }
}
