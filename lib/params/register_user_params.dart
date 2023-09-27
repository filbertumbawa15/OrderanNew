import 'dart:io';

class RegisterUserParam {
  String? name;
  String? phone;
  String? email;
  String? password;
  String? sendOTPVia;

  RegisterUserParam(
    this.name,
    this.phone,
    this.email,
    this.password,
    this.sendOTPVia,
  );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'telp': phone,
      'email': email,
      'password': password,
      'send_otp_via': sendOTPVia,
    };
  }
}

class OtpResendParam {
  String? email;

  OtpResendParam(this.email);

  Map<String, dynamic> toJson() {
    return {"email": email};
  }
}

class CheckOtpParam {
  String? otp;
  String? identifier;

  CheckOtpParam(this.otp, this.identifier);

  Map<String, dynamic> toJson() {
    return {
      "otp": otp,
      "identifier": identifier,
    };
  }
}

class LoginParam {
  String? email;
  String? password;

  LoginParam(this.email, this.password);
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}

class VerifikasiUserParam {
  File? ktp;
  File? npwp;
  String? nik;
  String? name;
  String? alamatdetail;
  DateTime? tgl_lahir;
  String? no_npwp;
  int? user_id;

  VerifikasiUserParam(
    this.ktp,
    this.npwp,
    this.nik,
    this.name,
    this.alamatdetail,
    this.tgl_lahir,
    this.no_npwp,
    this.user_id,
  );

  Map<String, dynamic> toJson() {
    return {
      "ktp": ktp,
      "npwp": npwp,
      "nik": nik,
      "name": name,
      "alamatdetail": alamatdetail,
      "tgl_lahir": tgl_lahir,
      "no_npwp": no_npwp,
      "user_id": user_id,
    };
  }
}
