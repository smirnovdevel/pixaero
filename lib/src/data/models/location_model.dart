import 'package:pixaero/src/domain/entities/character_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required name,
    required url,
  }) : super(name: name, url: url);

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        name: json["name"] as String,
        url: json["url"] as String,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
