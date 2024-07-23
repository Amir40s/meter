import 'package:flutter/material.dart';
import 'package:meter/constant/res/app_color/app_color.dart';
import 'package:meter/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import '../../model/paymentpayment/payment_model.dart';
import '../../provider/payment/payment_provider.dart';

class PaymentScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _cvcController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _currencyController = TextEditingController();
  final _callbackUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text('Moyasar Credit Card Payment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Card Holder Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the card holder name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _numberController,
                  decoration: InputDecoration(labelText: 'Card Number'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the card number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cvcController,
                  decoration: InputDecoration(labelText: 'CVC'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the CVC';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _monthController,
                  decoration: InputDecoration(labelText: 'Expiry Month'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the expiry month';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _yearController,
                  decoration: InputDecoration(labelText: 'Expiry Year'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the expiry year';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Amount (in cents)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    return null;
                  },
                ),
                // TextFormField(
                //   controller: _currencyController,
                //   decoration: InputDecoration(labelText: 'Currency'),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter a currency';
                //     }
                //     return null;
                //   },
                // ),
                // TextFormField(
                //   controller: _callbackUrlController,
                //   decoration: InputDecoration(labelText: 'Callback URL'),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter a callback URL';
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(height: 20),
                if (paymentProvider.isLoading)
                  CircularProgressIndicator()
                else
                  CustomButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        PaymentModel paymentModel = PaymentModel(
                          type: 'creditcard',
                          sourceType: 'creditcard',
                          sourceName: _nameController.text,
                          sourceNumber: _numberController.text,
                          sourceCvc: _cvcController.text,
                          sourceMonth: int.parse(_monthController.text),
                          sourceYear: int.parse(_yearController.text),
                          description: _descriptionController.text,
                          amount: int.parse(_amountController.text),
                          currency: "SAR",
                          callbackUrl: "https://meter.com.sa/",
                        );
                        paymentProvider.makePayment(paymentModel);
                      }
                    },
                    title: "Make Payment",
                  ),
                SizedBox(height: 20),
                if (paymentProvider.paymentResponse != null)
                  Text('Payment ID: ${paymentProvider.paymentResponse!.id}\n'
                      'Invoice ID: ${paymentProvider.paymentResponse!.invoiceId}\n'
                      'Amount: ${paymentProvider.paymentResponse!.amount}\n'
                      'Currency: ${paymentProvider.paymentResponse!.currency}\n'
                      'Status: ${paymentProvider.paymentResponse!.status}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
