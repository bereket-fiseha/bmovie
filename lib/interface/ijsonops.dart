import 'dart:convert';

import 'package:bmovie/interface/ijsonbase.dart';
import 'package:bmovie/models/movie.dart';

abstract class IJsonOps<T extends IJsonBase> {
  List<T> deserilizeMovie(String jsonString);
   List<T> deserilizeString(String jsonString);
}
