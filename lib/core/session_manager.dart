import 'package:hive/hive.dart';

class SessionManager {
  final Box box = Hive.box('session');

  void setSession(
    String name,
    String user,
    String telp,
    int id,
    String verification,
    String email,
    String password,
    String token,
  ) {
    box.put(AppKey.nameKey, name);
    box.put(AppKey.userKey, user);
    box.put(AppKey.telpKey, telp);
    box.put(AppKey.idKey, id);
    box.put(AppKey.verificationidKey, verification);
    box.put(AppKey.emailKey, email);
    box.put(AppKey.passwordKey, password);
    box.put(AppKey.tokenKey, token);
  }

  String? getActiveName() => box.get(AppKey.nameKey);
  String? getActiveUser() => box.get(AppKey.userKey);
  String? getActiveTelp() => box.get(AppKey.telpKey);
  int? getActiveId() => box.get(AppKey.idKey);
  String? getActiveVerification() => box.get(AppKey.verificationidKey);
  String? getActiveEmail() => box.get(AppKey.emailKey);
  String? getActivePassword() => box.get(AppKey.passwordKey);
  String? getActiveToken() => box.get(AppKey.tokenKey);

  bool anyActiveSession() {
    String? activeName = getActiveName();
    String? activeUser = getActiveUser();
    String? activeTelp = getActiveTelp();
    int? activeId = getActiveId();
    String? activeVerification = getActiveVerification();
    String? activeEmail = getActiveEmail();
    String? activePasword = getActivePassword();
    String? activeToken = getActiveToken();
    return activeName != null &&
        activeUser != null &&
        activeTelp != null &&
        activeId != null &&
        activeVerification != null &&
        activeEmail != null &&
        activePasword != null &&
        activeToken != null;
  }

  void signout() {
    box.delete(AppKey.nameKey);
    box.delete(AppKey.userKey);
    box.delete(AppKey.telpKey);
    box.delete(AppKey.idKey);
    // box.delete(AppKey.merchantidKey);
    // box.delete(AppKey.merchantpasswordKey);
    // box.delete(AppKey.merchantidinvoiceKey);
    // box.delete(AppKey.merchantpasswordinvoiceKey);
    box.delete(AppKey.verificationidKey);
    box.delete(AppKey.emailKey);
    box.delete(AppKey.passwordKey);
    box.delete(AppKey.tokenKey);
  }
}

class AppKey {
  static const String nameKey = 'NAME_KEY';
  static const String userKey = 'USER_KEY';
  static const String telpKey = 'TELP_KEY';
  static const int idKey = 0;
  // static const String merchantidKey = 'MERCHANT_ID_KEY';
  // static const String merchantpasswordKey = 'MERCHANT_PASSWORD_KEY';
  // static const String merchantidinvoiceKey = 'MERCHANT_ID_INVOICE_KEY';
  // static const String merchantpasswordinvoiceKey =
  //     'MERCHANT_PASSWORD_INVOICE_KEY';
  static const String verificationidKey = 'VERIFICATION_ID_KEY';
  static const String emailKey = 'EMAIL_KEY';
  static const String passwordKey = 'PASSWORD_KEY';
  static const String tokenKey = 'TOKEN_KEY';
}
