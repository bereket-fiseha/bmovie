abstract class IJsonBase<T> {
  void toJson();
  T fromJson(Map<String, dynamic> jsonObj);
}
