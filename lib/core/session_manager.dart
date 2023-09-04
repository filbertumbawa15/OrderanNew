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
    String ktpPath,
    String npwpPath,
    String nik,
    String npwp,
    String tglLahir,
  ) {
    box.put(AppKey.nameKey, name);
    box.put(AppKey.userKey, user);
    box.put(AppKey.telpKey, telp);
    box.put(AppKey.idKey, id);
    box.put(AppKey.verificationidKey, verification);
    box.put(AppKey.emailKey, email);
    box.put(AppKey.passwordKey, password);
    box.put(AppKey.tokenKey, token);
    box.put(AppKey.ktpPathKey, ktpPath);
    box.put(AppKey.npwpPathKey, npwpPath);
    box.put(AppKey.nikKey, nik);
    box.put(AppKey.npwpKey, npwp);
    box.put(AppKey.tglLahirKey, tglLahir);
  }

  String? getActiveName() => box.get(AppKey.nameKey);
  String? getActiveUser() => box.get(AppKey.userKey);
  String? getActiveTelp() => box.get(AppKey.telpKey);
  int? getActiveId() => box.get(AppKey.idKey);
  String? getActiveVerification() => box.get(AppKey.verificationidKey);
  String? getActiveEmail() => box.get(AppKey.emailKey);
  String? getActivePassword() => box.get(AppKey.passwordKey);
  String? getActiveToken() => box.get(AppKey.tokenKey);
  String? getKtpPath() => box.get(AppKey.ktpPathKey);
  String? getNpwpPath() => box.get(AppKey.npwpPathKey);
  String? getActiveNik() => box.get(AppKey.nikKey);
  String? getActiveNpwp() => box.get(AppKey.npwpKey);
  String? getActiveTglLahir() => box.get(AppKey.tglLahirKey);

  bool anyActiveSession() {
    String? activeName = getActiveName();
    String? activeUser = getActiveUser();
    String? activeTelp = getActiveTelp();
    int? activeId = getActiveId();
    String? activeVerification = getActiveVerification();
    String? activeEmail = getActiveEmail();
    String? activePasword = getActivePassword();
    String? activeToken = getActiveToken();
    String? activeKtpPath = getKtpPath();
    String? activeNpwpPath = getNpwpPath();
    String? activeNik = getActiveNik();
    String? activeNpwp = getActiveNpwp();
    String? activeTglLahir = getActiveTglLahir();
    return activeName != null &&
        activeUser != null &&
        activeTelp != null &&
        activeId != null &&
        activeVerification != null &&
        activeEmail != null &&
        activePasword != null &&
        activeToken != null &&
        // activeKtpPath != null &&
        activeNpwpPath != null &&
        activeNik != null &&
        activeNpwp != null &&
        activeTglLahir != null;
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
    // box.delete(AppKey.ktpPathKey);
    box.delete(AppKey.npwpPathKey);
    box.delete(AppKey.nikKey);
    box.delete(AppKey.npwpKey);
    box.delete(AppKey.tglLahirKey);
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
  static const String ktpPathKey = 'KTP_PATH_KEY';
  static const String npwpPathKey = 'NPWP_PATH_KEY';
  static const String nikKey = 'NIK_KEY';
  static const String npwpKey = 'NPWP_KEY';
  static const String tglLahirKey = 'TGL_LAHIR_KEY';
}
