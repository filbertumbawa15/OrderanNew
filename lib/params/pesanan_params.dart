import 'package:intl/intl.dart';

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

class AddFavoritParam {
  String? labelName;
  String? placeid;
  int? userId;
  String? pelabuhanid;
  String? alamat;
  String? customer;
  String? notelpcustomer;
  String? latitudeplace;
  String? longitudeplace;
  String? namapelabuhan;
  String? note;

  AddFavoritParam(
    this.labelName,
    this.placeid,
    this.userId,
    this.pelabuhanid,
    this.alamat,
    this.customer,
    this.notelpcustomer,
    this.latitudeplace,
    this.longitudeplace,
    this.namapelabuhan,
    this.note,
  );

  Map<String, dynamic> toJson() {
    return {
      "labelName": labelName,
      "placeid": placeid,
      "userId": userId,
      "pelabuhanid": pelabuhanid,
      "alamat": alamat,
      "customer": customer,
      "notelpcustomer": notelpcustomer,
      "latitudeplace": latitudeplace,
      "longitudeplace": longitudeplace,
      "namapelabuhan": namapelabuhan,
      "note": note,
    };
  }
}

class ListOrderParam {
  int? userId;
  int? kondisi;
  int? utcTime;

  ListOrderParam(this.userId, this.kondisi, this.utcTime);

  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'kondisi': kondisi,
      'utctime': utcTime,
    };
  }
}

class ListOrderDetailParam {
  String? nobukti;
  int? utcTime;

  ListOrderDetailParam(this.nobukti, this.utcTime);

  Map<String, dynamic> toJson() {
    return {
      'nobukti': nobukti,
      'utctime': utcTime,
    };
  }
}

class ListOrderStatusParam {
  String? nobukti;
  int? qty;
  String? jobemkl;

  ListOrderStatusParam(this.nobukti, this.qty, this.jobemkl);

  Map<String, dynamic> toJson() {
    return {
      'nobukti': nobukti,
      'qty': qty,
      'jobemkl': jobemkl,
    };
  }
}

class ProceedOrderParam {
  String? origincontroller;
  String? placeidasal;
  String? pelabuhanidasal;
  String? latitude_pelabuhan_asal;
  String? longitude_pelabuhan_asal;
  String? jarakasal;
  String? waktuasal;
  String? namapengirim;
  String? notelppengirim;
  String? alamatdetailpengirim;
  String? notepengirim;
  String? namapelabuhanpengirim;
  String? destinationcontroller;
  String? placeidtujuan;
  String? pelabuhanidtujuan;
  String? latitude_pelabuhan_tujuan;
  String? longitude_pelabuhan_tujuan;
  String? jaraktujuan;
  String? waktutujuan;
  String? namapenerima;
  String? notelppenerima;
  String? alamatdetailpenerima;
  String? notepenerima;
  String? namapelabuhanpenerima;
  int? container_id;
  String? nilaibarang;
  int? nilaibarang_asuransi;
  String? harga;
  String? qty;
  String? jenisbarang;
  String? namabarang;
  String? hargasatuan;
  String? keterangantambahan;
  String? merchantId;
  String? merchantPassword;
  String? selectedpembayaran;
  int? isSyarat;
  int? userId;
  String? key;
  String? fcmToken;
  String? accessToken;
  String? time;
  int? utc;

  ProceedOrderParam(
    this.placeidasal,
    this.pelabuhanidasal,
    this.latitude_pelabuhan_asal,
    this.longitude_pelabuhan_asal,
    this.jarakasal,
    this.waktuasal,
    this.namapengirim,
    this.notelppengirim,
    this.alamatdetailpengirim,
    this.placeidtujuan,
    this.pelabuhanidtujuan,
    this.latitude_pelabuhan_tujuan,
    this.longitude_pelabuhan_tujuan,
    this.waktutujuan,
    this.namapenerima,
    this.notelppenerima,
    this.alamatdetailpenerima,
    this.container_id,
    this.nilaibarang_asuransi,
    this.harga,
    this.qty,
    this.jenisbarang,
    this.namabarang,
    this.keterangantambahan,
    this.selectedpembayaran,
    this.userId,
    this.key,
    this.notepengirim,
    this.notepenerima,
    this.fcmToken,
    this.isSyarat,
    this.accessToken,
    this.merchantId,
    this.merchantPassword,
    this.time,
    this.utc,
  );

  Map<String, dynamic> toJson() {
    return {
      "placeidasal": placeidasal,
      "pelabuhanidasal": pelabuhanidasal,
      "latitude_pelabuhan_asal": latitude_pelabuhan_asal,
      "longitude_pelabuhan_asal": longitude_pelabuhan_asal,
      "jarakasal": jarakasal,
      "waktuasal": waktuasal,
      "namapengirim": namapengirim,
      "notelppengirim": notelppengirim,
      "alamatdetailpengirim": alamatdetailpengirim,
      "placeidtujuan": placeidtujuan,
      "pelabuhanidtujuan": pelabuhanidtujuan,
      "latitude_pelabuhan_tujuan": latitude_pelabuhan_tujuan,
      "longitude_pelabuhan_tujuan": longitude_pelabuhan_tujuan,
      "jaraktujuan": jarakasal,
      "waktutujuan": waktutujuan,
      "namapenerima": namapenerima,
      "notelppenerima": notelppenerima,
      "alamatdetailpenerima": alamatdetailpenerima,
      "container_id": container_id,
      "nilaibarang_asuransi": nilaibarang_asuransi,
      "harga": harga,
      "qty": qty,
      "jenisbarang": jenisbarang,
      "namabarang": namabarang,
      "keterangantambahan": keterangantambahan,
      "payment_code": selectedpembayaran,
      "user_id": userId,
      "key": key,
      "note_pengirim": notepengirim,
      "note_penerima": notepenerima,
      "fcmToken": fcmToken,
      "ischeck": isSyarat,
      "accessToken": accessToken,
      "merchantid": merchantId,
      "merchantpassword": merchantPassword,
      "time": time,
      "utc": utc,
    };
  }
}

class CreatePdfSyaratParam {
  String? lokasiMuat;
  String? lokasiBongkar;
  String? harga;

  CreatePdfSyaratParam(this.lokasiMuat, this.lokasiBongkar, this.harga);

  Map<String, dynamic> toJson() {
    return {
      "lokasiMuat": lokasiMuat,
      "lokasiBongkar": lokasiBongkar,
      "harga": harga,
    };
  }
}

class ListQtyOrderParam {
  String? nobukti;

  ListQtyOrderParam(this.nobukti);

  Map<String, dynamic> toJson() {
    return {
      'nobukti': nobukti,
    };
  }
}
