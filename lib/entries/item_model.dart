import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  Item({
    required this.name,
    required this.category,
    required this.url,
    required this.downloadUrl,
  });

  String name;
  String category;
  String url;
  String downloadUrl;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      name: json["name"],
      category: json["category"],
      url: json["url"],
      downloadUrl: json["downloadUrl"]);

  Map<String, dynamic> toJson() =>
      {"name": name, "category": category, url: "url"};
}
