class MasterContainer {
  final int? id;
  final String? kodecontainer;

  MasterContainer({this.id, this.kodecontainer});

  factory MasterContainer.fromJson(Map<String, dynamic> json) {
    return MasterContainer(
      id: json["id"],
      kodecontainer: json["kodecontainer"],
    );
  }

  static List<MasterContainer> fromJsonList(List list) {
    return list.map((item) => MasterContainer.fromJson(item)).toList();
  }

  @override
  String toString() => kodecontainer!;
}

class Pembayaran {
  final String? pg_code;
  final String? pg_name;

  Pembayaran({this.pg_code, this.pg_name});

  factory Pembayaran.fromJson(Map<String, dynamic> json) {
    return Pembayaran(
      pg_code: json["pg_code"],
      pg_name: json["pg_name"],
    );
  }

  static List<Pembayaran> fromJsonList(List list) {
    return list.map((item) => Pembayaran.fromJson(item)).toList();
  }

  @override
  String toString() => pg_name!;
}

class Favorites {
  String? id;
  String? userid;
  String? placeid;
  String? pelabuhanid;
  String? alamat;
  String? customer;
  String? notelpcustomer;
  String? latitudeplace;
  String? longitudeplace;
  String? namapelabuhan;
  String? note;
  String? labelName;
  String? latitudepelabuhan;
  String? longitudepelabuhan;
  String? merchantId;
  String? merchantPassword;
  String? distance;
  String? duration;

  Favorites(
    this.id,
    this.userid,
    this.placeid,
    this.pelabuhanid,
    this.alamat,
    this.customer,
    this.notelpcustomer,
    this.latitudeplace,
    this.longitudeplace,
    this.namapelabuhan,
    this.note,
    this.labelName,
    this.latitudepelabuhan,
    this.longitudepelabuhan,
    this.merchantId,
    this.merchantPassword,
    this.distance,
    this.duration,
  );

  Favorites.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userid = json["userId"];
    placeid = json["placeid"];
    pelabuhanid = json["pelabuhanid"];
    alamat = json["alamat"];
    customer = json["customer"];
    notelpcustomer = json["notelpcustomer"];
    latitudeplace = json["latitudeplace"];
    longitudeplace = json["longitudeplace"];
    namapelabuhan = json["namapelabuhan"];
    note = json["note"];
    labelName = json["labelName"];
    latitudepelabuhan = json["latitude"];
    longitudepelabuhan = json["longitude"];
    merchantId = json["merchant_id"];
    merchantPassword = json["merchant_password"];
    distance = json["distance"];
    duration = json["duration"];
  }
}

class ListOrderModels {
  String? placeidasal;
  String? pelabuhanidasal;
  String? trx_id;
  String? bill_no;
  String? payment_code;
  String? prov_asal;
  String? prov_tujuan;
  String? payment_status;
  String? harga;
  String? order_date;
  String? payment_date;
  String? alamat_asal;
  String? alamat_tujuan;
  String? latitude_pelabuhan_asal;
  String? longitude_pelabuhan_asal;
  String? latitude_pelabuhan_tujuan;
  String? longitude_pelabuhan_tujuan;
  String? latitude_muat;
  String? longitude_muat;
  String? latitude_bongkar;
  String? longitude_bongkar;
  String? pengirim;
  String? penerima;
  String? placeidtujuan;
  String? pelabuhanidtujuan;
  String? jarak_asal;
  String? waktu_asal;
  String? jarak_tujuan;
  String? waktu_tujuan;
  String? kodecontainer;
  String? qty;
  String? notelppengirim;
  String? notelppenerima;
  String? container_id;
  String? nilaibarang;
  String? jenisbarang;
  String? namabarang;
  String? keterangantambahan;
  String? nobukti;
  String? nominalrefund;
  String? notepengirim;
  String? notepenerima;
  String? namapelabuhanmuat;
  String? namapelabuhanbongkar;
  String? contactperson;
  String? buktipdf;
  String? buktipdfrefund;
  String? merchant_id;
  String? merchant_password;
  String? lampiraninvoice;
  List<dynamic>? invoiceTambahan;
  int? totalNominal;
  String? namabankrefund;
  String? norekening;
  String? namarekening;
  String? cabangbankrefund;
  String? keteranganrefund;
  String? tglrefund;

  ListOrderModels({
    this.placeidasal,
    this.pelabuhanidasal,
    this.trx_id,
    this.bill_no,
    this.payment_code,
    this.prov_asal,
    this.prov_tujuan,
    this.payment_status,
    this.harga,
    this.order_date,
    this.payment_date,
    this.alamat_asal,
    this.alamat_tujuan,
    this.latitude_pelabuhan_asal,
    this.longitude_pelabuhan_asal,
    this.latitude_pelabuhan_tujuan,
    this.longitude_pelabuhan_tujuan,
    this.latitude_muat,
    this.longitude_muat,
    this.latitude_bongkar,
    this.longitude_bongkar,
    this.pengirim,
    this.penerima,
    this.placeidtujuan,
    this.pelabuhanidtujuan,
    this.jarak_asal,
    this.waktu_asal,
    this.jarak_tujuan,
    this.waktu_tujuan,
    this.kodecontainer,
    this.qty,
    this.notelppengirim,
    this.notelppenerima,
    this.container_id,
    this.nilaibarang,
    this.jenisbarang,
    this.namabarang,
    this.keterangantambahan,
    this.nobukti,
    this.nominalrefund,
    this.notepengirim,
    this.notepenerima,
    this.namapelabuhanmuat,
    this.namapelabuhanbongkar,
    this.contactperson,
    this.buktipdf,
    this.buktipdfrefund,
    this.merchant_id,
    this.merchant_password,
    this.lampiraninvoice,
    this.invoiceTambahan,
    this.totalNominal,
    this.namabankrefund,
    this.norekening,
    this.namarekening,
    this.cabangbankrefund,
    this.keteranganrefund,
    this.tglrefund,
  });

  // FORMAT TO JSON
  factory ListOrderModels.fromJson(Map<String, dynamic> json) =>
      ListOrderModels(
        placeidasal: json["placeidasal"],
        pelabuhanidasal: json["pelabuhanidasal"],
        jarak_asal: json["jarak_asal"],
        waktu_asal: json["waktu_asal"],
        placeidtujuan: json["placeidtujuan"],
        pelabuhanidtujuan: json["pelabuhanidtujuan"],
        jarak_tujuan: json["jarak_tujuan"],
        waktu_tujuan: json["waktu_tujuan"],
        trx_id: json["trx_id"],
        bill_no: json["bill_no"],
        payment_code: json["payment_code"],
        prov_asal: json["provinsi_asal"],
        prov_tujuan: json["provinsi_tujuan"],
        payment_status: json["payment_status"],
        harga: json["harga"],
        order_date: json["order_date"],
        payment_date: json["payment_date"],
        alamat_asal: json["alamatdetailpengirim"],
        alamat_tujuan: json["alamatdetailpenerima"],
        latitude_pelabuhan_asal: json["latitude_pelabuhan_asal"],
        longitude_pelabuhan_asal: json["longitude_pelabuhan_asal"],
        latitude_pelabuhan_tujuan: json["latitude_pelabuhan_tujuan"],
        longitude_pelabuhan_tujuan: json["longitude_pelabuhan_tujuan"],
        latitude_muat: json["latitude_muat"],
        longitude_muat: json["longitude_muat"],
        latitude_bongkar: json["latitude_bongkar"],
        longitude_bongkar: json["longitude_bongkar"],
        pengirim: json["namapengirim"],
        penerima: json["namapenerima"],
        kodecontainer: json["kodecontainer"],
        qty: json["qty"],
        notelppengirim: json["notelppengirim"],
        notelppenerima: json["notelppenerima"],
        nilaibarang: json["nilaibarang_asuransi"],
        jenisbarang: json["jenisbarang"],
        namabarang: json["namabarang"],
        keterangantambahan: json["keterangantambahan"],
        container_id: json["container_id"],
        nobukti: json["nobukti"],
        nominalrefund: json["nominalrefund"],
        notepengirim: json["note_pengirim"],
        notepenerima: json["note_penerima"],
        namapelabuhanmuat: json["namapelabuhanmuat"],
        namapelabuhanbongkar: json["namapelabuhanbongkar"],
        contactperson: json["contactperson"],
        buktipdf: json["buktipdf"],
        buktipdfrefund: json["buktipdfrefund"],
        merchant_id: json["merchantid"],
        merchant_password: json["merchantpassword"],
        lampiraninvoice: json["lampiraninvoice"],
        invoiceTambahan: json["invoice_tambahan"],
        totalNominal: json["totalNominal"],
        namabankrefund: json["namabankrefund"],
        norekening: json["norekening"],
        namarekening: json["namarekening"],
        cabangbankrefund: json["cabangrekening"],
        keteranganrefund: json["keteranganrefund"],
        tglrefund: json["tglrefund"],
      );
}

class ListOrderBayar {
  final String? lokasiMuat;
  final String? lokasiBongkar;
  final String? harga;
  final String? noVA;
  final String? bill_no;
  final String? payment_name;
  final String? waktu_bayar;
  final String? endDate;
  final String? nobukti;

  ListOrderBayar({
    this.lokasiMuat,
    this.lokasiBongkar,
    this.harga,
    this.noVA,
    this.bill_no,
    this.payment_name,
    this.waktu_bayar,
    this.endDate,
    this.nobukti,
  });

  factory ListOrderBayar.fromJson(Map<String, dynamic> json) {
    return ListOrderBayar(
      lokasiMuat: json["alamatdetailpengirim"],
      lokasiBongkar: json["alamatdetailpenerima"],
      harga: json["harga"],
      noVA: json["trx_id"],
      bill_no: json["bill_no"],
      payment_name: json["payment_code"],
      waktu_bayar: json["bill_expired"],
      endDate: json["date"],
      nobukti: json["nobukti"],
    );
  }
}

class StatusBarang {
  String? tgl_status;
  int? status_id;
  String? kode_status;
  String? keterangan;
  String? gambar;

  StatusBarang({
    this.tgl_status,
    this.status_id,
    this.kode_status,
    this.keterangan,
    this.gambar,
  });

  // FORMAT TO JSON
  factory StatusBarang.fromJson(Map<String, dynamic> json) => StatusBarang(
        tgl_status: json["tglstatus"],
        status_id: json["pelabuhanidasal"],
        kode_status: json["status"]["kodestatus"],
        keterangan: json["status"]["keterangan"],
        gambar: json["status"]["gambar"],
      );
}
