import 'dart:convert';

class SyaratdanKetentuanModel {
  final String? syaratketentuan;

  SyaratdanKetentuanModel({
    this.syaratketentuan,
  });

  factory SyaratdanKetentuanModel.fromJson(Map<String, dynamic> json) {
    return SyaratdanKetentuanModel(
      syaratketentuan: json["syaratketentuan"],
    );
  }
}

class User {
  final int id;
  final String user;
  final String name;
  final String password;
  final String cabangId;
  final String karyawanId;
  final dynamic dashboard;
  final int statusaktif;
  final String statususer;
  final String statusvalidasi;
  final String email;
  final String otp;
  final String telp;
  final String modifiedby;
  final String createdAt;
  final String updatedAt;
  final dynamic gambar;
  final String accessToken;
  final String keteranganverifikasi;
  final dynamic fcmToken;
  final String nik;
  final String alamatdetail;
  final DateTime tglLahir;
  final String fotoKtp;
  final String noNpwp;
  final String fotoNpwp;
  final String statusverifikasi;
  final dynamic fotoDatadiri;
  final dynamic jamdisetujui;
  final String tgldisetujui;
  final dynamic approvaluser;
  final dynamic tglapprovaluser;

  User({
    required this.id,
    required this.user,
    required this.name,
    required this.password,
    required this.cabangId,
    required this.karyawanId,
    required this.dashboard,
    required this.statusaktif,
    required this.statususer,
    required this.statusvalidasi,
    required this.email,
    required this.otp,
    required this.telp,
    required this.modifiedby,
    required this.createdAt,
    required this.updatedAt,
    required this.gambar,
    required this.accessToken,
    required this.keteranganverifikasi,
    required this.fcmToken,
    required this.nik,
    required this.alamatdetail,
    required this.tglLahir,
    required this.fotoKtp,
    required this.noNpwp,
    required this.fotoNpwp,
    required this.statusverifikasi,
    required this.fotoDatadiri,
    required this.jamdisetujui,
    required this.tgldisetujui,
    required this.approvaluser,
    required this.tglapprovaluser,
  });

  factory User.fromRawJson(String str) => User.fromJson(jsonDecode(str));

  String toRawJson() => jsonEncode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        user: json["user"],
        name: json["name"],
        password: json["password"],
        cabangId: json["cabang_id"],
        karyawanId: json["karyawan_id"],
        dashboard: json["dashboard"],
        statusaktif: json["statusaktif"],
        statususer: json["statususer"],
        statusvalidasi: json["statusvalidasi"],
        email: json["email"],
        otp: json["otp"],
        telp: json["telp"],
        modifiedby: json["modifiedby"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        gambar: json["gambar"],
        accessToken: json["accessToken"],
        keteranganverifikasi: json["keteranganverifikasi"],
        fcmToken: json["fcm_token"],
        nik: json["nik"],
        alamatdetail: json["alamatdetail"],
        tglLahir: DateTime.parse(json["tgl_lahir"]),
        fotoKtp: json["foto_ktp"],
        noNpwp: json["no_npwp"],
        fotoNpwp: json["foto_npwp"],
        statusverifikasi: json["statusverifikasi"],
        fotoDatadiri: json["foto_datadiri"],
        jamdisetujui: json["jamdisetujui"],
        tgldisetujui: json["tgldisetujui"],
        approvaluser: json["approvaluser"],
        tglapprovaluser: json["tglapprovaluser"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "name": name,
        "password": password,
        "cabang_id": cabangId,
        "karyawan_id": karyawanId,
        "dashboard": dashboard,
        "statusaktif": statusaktif,
        "statususer": statususer,
        "statusvalidasi": statusvalidasi,
        "email": email,
        "otp": otp,
        "telp": telp,
        "modifiedby": modifiedby,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "gambar": gambar,
        "accessToken": accessToken,
        "keteranganverifikasi": keteranganverifikasi,
        "fcm_token": fcmToken,
        "nik": nik,
        "alamatdetail": alamatdetail,
        "tgl_lahir": tglLahir,
        "foto_ktp": fotoKtp,
        "no_npwp": noNpwp,
        "foto_npwp": fotoNpwp,
        "statusverifikasi": statusverifikasi,
        "foto_datadiri": fotoDatadiri,
        "jamdisetujui": jamdisetujui,
        "tgldisetujui": tgldisetujui,
        "approvaluser": approvaluser,
        "tglapprovaluser": tglapprovaluser,
      };
}
