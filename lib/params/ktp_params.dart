import 'package:intl/intl.dart';

class KtpParams {
  String? nik;
  String? nama;
  String? alamat;
  DateFormat? tglLahir;

  KtpParams(
    this.nik,
    this.nama,
    this.alamat,
    this.tglLahir,
  );

  Map<String, dynamic> toJson() {
    return {
      "nik": nik,
      "nama": nama,
      "alamat": alamat,
      "tglLahir": tglLahir,
    };
  }
}
