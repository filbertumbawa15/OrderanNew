class Penerima {
  final String? name;
  final String? notelp;
  final String? address;

  const Penerima({
    this.name,
    this.notelp,
    this.address,
  });
}

class Pengirim {
  final String? name;
  final String? address;
  final String? notelp;
  final String? paymentInfo;

  const Pengirim({
    this.name,
    this.address,
    this.notelp,
    this.paymentInfo,
  });
}

class Invoice {
  final InvoiceInfo? info;
  final Pengirim? pengirim;
  final Penerima? penerima;
  final List<InvoiceItem>? items;

  const Invoice({
    this.info,
    this.pengirim,
    this.penerima,
    this.items,
  });
}

class InvoiceInfo {
  final String? description;
  final String? number;
  final String? date;
  final String? payDate;
  final String? payment;

  const InvoiceInfo({
    this.description,
    this.number,
    this.date,
    this.payDate,
    this.payment,
  });
}

class InvoiceItem {
  final String? pengirim;
  final String? penerima;
  final int? quantity;
  final String? uk_container;
  final String? total;

  const InvoiceItem({
    this.pengirim,
    this.penerima,
    this.quantity,
    this.uk_container,
    this.total,
  });
}

class SyaratKetentuan {
  final String? nama;
  final String? nobukti;
  final String? notelp;
  final String? tanggal;
  final String? lokmuat;
  final String? lokbongkar;
  final String? harga;
  final List<String?>? syaratketentuan;

  SyaratKetentuan(
      {this.nama,
      this.nobukti,
      this.notelp,
      this.tanggal,
      this.lokmuat,
      this.lokbongkar,
      this.harga,
      this.syaratketentuan});
}
