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
    return {"otp": otp, "identifier": identifier};
  }
}
