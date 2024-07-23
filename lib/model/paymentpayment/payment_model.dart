class PaymentModel {
  final String type;
  final String sourceType;
  final String sourceName;
  final String sourceNumber;
  final String sourceCvc;
  final int sourceMonth;
  final int sourceYear;
  final String description;
  final int amount;
  final String currency;
  final String callbackUrl;

  PaymentModel({
    required this.type,
    required this.sourceType,
    required this.sourceName,
    required this.sourceNumber,
    required this.sourceCvc,
    required this.sourceMonth,
    required this.sourceYear,
    required this.description,
    required this.amount,
    required this.currency,
    required this.callbackUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'source': {
        'type': sourceType,
        'name': sourceName,
        'number': sourceNumber,
        'cvc': sourceCvc,
        'month': sourceMonth,
        'year': sourceYear,
      },
      'description': description,
      'amount': amount,
      'currency': currency,
      'callback_url': callbackUrl,
    };
  }
}
