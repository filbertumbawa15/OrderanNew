import 'package:intl/intl.dart';

class BayarParams {
  String? trxid;
  String? paymentStatus;
  DateFormat? paymentDate;

  BayarParams(
    this.trxid,
    this.paymentStatus,
    this.paymentDate,
  );

  Map<String, dynamic> toJson() {
    return {
      "trx_id": trxid,
      "payment_status": paymentStatus,
      'payment_date': paymentDate,
    };
  }
}
