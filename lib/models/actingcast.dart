import '../const/apiroute.dart';
import '../const/appconfig.dart';

class ActingCast {
  final int _id;
  final String _name;
  final String _characterName;

  final String _profilePath;

  ActingCast(
      {required int id,
      required String name,
      required String characterName,
      required String profilePath})
      : _id = id,
        _name = name,
        _characterName = characterName,
        _profilePath = profilePath;

  int getId() => _id;

  String getName() => _name;

  String getCharacterName() => _characterName;

  String getProfilePath() => AppConfig.local == true
      ? _profilePath
      : "${APIROUTE.imageBaseUrl}$_profilePath";

  factory ActingCast.fromJson(Map<String, dynamic> json) {
    return ActingCast(
        id: json["id"],
        name: json["name"],
        characterName: json["character"],
        profilePath: json["profile_path"] ?? "");
  }
}
