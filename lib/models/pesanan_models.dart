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
