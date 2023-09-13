part of 'ongkir_bloc.dart';

@immutable
sealed class OngkirEvent {}

@immutable
class CekOngkirEvent extends OngkirEvent {
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

  CekOngkirEvent({
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
  });
}
