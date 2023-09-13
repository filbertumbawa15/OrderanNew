class DatapengirimParam {
  String? place_id;
  String? key;

  DatapengirimParam(this.place_id, this.key);
  Map<String, dynamic> toJson() {
    return {
      "place_id": place_id,
      "key": key,
    };
  }
}

class CekHargaParam {
  String? placeidasal;
  String? pelabuhanidasal;
  String? latitude_pelabuhan_asal;
  String? longitude_pelabuhan_asal;
  String? jarak_asal;
  String? waktu_asal;
  String? placeidtujuan;
  String? pelabuhanidtujuan;
  String? latitude_pelabuhan_tujuan;
  String? longitude_pelabuhan_tujuan;
  String? jarak_tujuan;
  String? waktu_tujuan;
  int? container_id;
  String? nilaibarang_asuransi;
  String? qty;
  String? key;

  CekHargaParam(
    this.placeidasal,
    this.pelabuhanidasal,
    this.latitude_pelabuhan_asal,
    this.longitude_pelabuhan_asal,
    this.jarak_asal,
    this.waktu_asal,
    this.placeidtujuan,
    this.pelabuhanidtujuan,
    this.latitude_pelabuhan_tujuan,
    this.longitude_pelabuhan_tujuan,
    this.jarak_tujuan,
    this.waktu_tujuan,
    this.container_id,
    this.nilaibarang_asuransi,
    this.qty,
    this.key,
  );

  Map<String, dynamic> toJson() {
    return {
      "placeidasal": placeidasal,
      "pelabuhanidasal": pelabuhanidasal,
      "latitude_pelabuhan_asal": latitude_pelabuhan_asal,
      "longitude_pelabuhan_asal": longitude_pelabuhan_asal,
      "jarak_asal": jarak_asal,
      "waktu_asal": waktu_asal,
      "placeidtujuan": placeidtujuan,
      "pelabuhanidtujuan": pelabuhanidtujuan,
      "latitude_pelabuhan_tujuan": latitude_pelabuhan_tujuan,
      "longitude_pelabuhan_tujuan": longitude_pelabuhan_tujuan,
      "jarak_tujuan": jarak_tujuan,
      "waktu_tujuan": waktu_tujuan,
      "container_id": container_id,
      "nilaibarang_asuransi": nilaibarang_asuransi,
      "qty": qty,
      "key": key,
    };
  }
}
