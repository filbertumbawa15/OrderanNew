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
