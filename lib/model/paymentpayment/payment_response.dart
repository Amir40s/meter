class PaymentResponse {
  final String status;
  final String id;
  final String invoiceId;
  final String amount;
  final String currency;

  PaymentResponse({
    required this.status,
    required this.id,
    required this.invoiceId,
    required this.amount,
    required this.currency,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      status: json['status'] ?? '',
      id: json['id'] ?? '',
      invoiceId: json['invoice_id'] ?? '',
      amount: json['amount']?.toString() ?? '',
      currency: json['currency'] ?? '',
    );
  }
}
