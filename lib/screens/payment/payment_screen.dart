import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meter/constant/res/app_color/app_color.dart';
import 'package:meter/provider/payment/card_provider.dart';
import 'package:meter/widgets/app_text_field.dart';
import 'package:meter/widgets/custom_button.dart';
import 'package:meter/widgets/custom_textfield.dart';
import 'package:meter/widgets/master_card_widget.dart';
import 'package:meter/widgets/text_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context);

    final Map<String, dynamic> arguments = Get.arguments;
    final String price = arguments['price'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text('Moyasar Credit Card Payment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Consumer<CardProvider>(
                    builder: (context,provider,child){
                      return MasterCard(
                          cardHolderName: provider.cardHolderName,
                        cardNumber: provider.cardNumber,
                        cvv: provider.cvv,
                        expiryMonth: provider.expiryMonth,
                        expiryYear: provider.expiryYear,
                      );
                    }
                ),

               const SizedBox(height: 50.0,),
               const TextWidget(
                  title: "Card Holder Name",
                  fontWeight: FontWeight.bold,
                  textColor: Colors.black,
                ),
               const SizedBox(height: 10.0,),
                AppTextField(hintText: "Card Holder Name",
                  onFieldChanged: (value) {
                    Provider.of<CardProvider>(context, listen: false).updateCardHolderName(value);
                  },
                ),

                const SizedBox(height: 20.0,),
                const TextWidget(
                  title: "Card Number",
                  fontWeight: FontWeight.bold,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 10.0,),
                AppTextField(
                  hintText: "Card Number",
                  onFieldChanged: (value) {
                    Provider.of<CardProvider>(context, listen: false).updateCardNumber(value);
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CardNumberInputFormatter(),
                  ],
                ),

                const SizedBox(height: 20.0,),
                const TextWidget(
                  title: "CVV",
                  fontWeight: FontWeight.bold,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 10.0,),
                AppTextField(
                  hintText: "CVV",
                  onFieldChanged: (value) {
                    Provider.of<CardProvider>(context, listen: false).updateCVV(value);
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),

                const SizedBox(height: 20.0,),
                Row(
                  children: [
                    Expanded(
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextWidget(
                              title: "Expiry Month",
                              fontWeight: FontWeight.bold,
                              textColor: Colors.black,
                            ),
                            const SizedBox(height: 10.0,),
                            AppTextField(
                              hintText: "Expiry Month",
                              onFieldChanged: (value) {
                                Provider.of<CardProvider>(context, listen: false).updateExpiryMonth(value);
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ],
                        )),
                    SizedBox(width: 5.0,),
                    Expanded(
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextWidget(
                              title: "Expiry Year",
                              fontWeight: FontWeight.bold,
                              textColor: Colors.black,
                            ),
                            const SizedBox(height: 10.0,),
                            AppTextField(
                              hintText: "Expiry Year",
                              onFieldChanged: (value) {
                                Provider.of<CardProvider>(context, listen: false).updateExpiryYear(value);
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ],
                        )),
                  ],
                ),

                const SizedBox(height: 20.0,),
                const TextWidget(
                  title: "Description",
                  fontWeight: FontWeight.bold,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 10.0,),
                AppTextField(
                  hintText: "Description",
                ),


               const SizedBox(height: 20),
                if (paymentProvider.isLoading)
                 const CircularProgressIndicator()
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
                          amount: int.parse(price),
                          currency: "SAR",
                          callbackUrl: "https://meter.com.sa/",
                        );
                        paymentProvider.makePayment(paymentModel);
                      }
                    },
                    title: "Make Payment (SAR $price)",
                  ),
               const SizedBox(height: 20),
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


class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String newText = newValue.text.replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters

    if (newText.length > 16) {
      newText = newText.substring(0, 16);
    }

    String formattedText = '';

    for (int i = 0; i < newText.length; i++) {
      if (i % 4 == 0 && i != 0) formattedText += ' ';
      formattedText += newText[i];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

