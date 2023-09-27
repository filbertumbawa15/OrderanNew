// class DatapengirimResponse {
//   final String? longitude;
//   final String? latitude;
//   final String? namapelabuhan;
//   final String? merchant_id;
//   final String? merchant_password;
//   final String? pelabuhan_id;

//   DatapengirimResponse(
//       {this.longitude,
//       this.latitude,
//       this.namapelabuhan,
//       this.merchant_id,
//       this.merchant_password,
//       this.pelabuhan_id});

//   factory DatapengirimResponse.fromJson(Map<String, dynamic> json) {
//     return DatapengirimResponse(
//       longitude: json["data"],
//       message: "Berhasil menambahkan Data User",
//     );
//   }
// }

import 'package:tasorderan/models/pesanan_models.dart';

class FavoriteResponse {
  List<Favorites> listFavorites = [];

  FavoriteResponse.fromJson(json) {
    for (int i = 0; i < json.length; i++) {
      Favorites favorites = Favorites.fromJson(json[i]);
      listFavorites.add(favorites);
    }
  }
}

class ListOrderResponse {
  List<ListOrderModels> listOrder = [];

  ListOrderResponse.fromJson(json) {
    for (int i = 0; i < json.length; i++) {
      ListOrderModels order = ListOrderModels.fromJson(json[i]);
      listOrder.add(order);
    }
  }
}

class ListPesananBayarResponse {
  final ListOrderBayar? listOrderBayar;
  final String? message;

  ListPesananBayarResponse({this.listOrderBayar, this.message});

  factory ListPesananBayarResponse.fromJson(Map<String, dynamic> json) {
    return ListPesananBayarResponse(
      listOrderBayar: ListOrderBayar.fromJson(json),
    );
  }
}
