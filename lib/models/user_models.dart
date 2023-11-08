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
