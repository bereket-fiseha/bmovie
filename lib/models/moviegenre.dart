class MovieGenre {
  final int _id;
  final String _name;

  MovieGenre({required int id, required String name})
      : _id = id,
        _name = name;

  int getId() => _id;

  String getName() => _name;
}
