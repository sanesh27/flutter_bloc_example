
import 'package:timer/album_app/service/album_model.dart';
import 'package:http/http.dart' as http;

abstract class AlbumsRepo {
  Future<List<Album>> getAlbumList();
}

class AlbumServices implements AlbumsRepo {
  static const _baseUrl = 'jsonplaceholder.typicode.com';
  static const String _getAlbums = '/albums';

  @override
  Future<List<Album>> getAlbumList() async {
    Uri uri = Uri.https(_baseUrl, _getAlbums);
    http.Response response = await http.get(uri);
    List<Album> albums = albumFromJson(response.body);
    return albums;
  }
}

class NoInternetException {
  var message;
  NoInternetException(this.message);
}

class NoServiceFoundException {
  var message;
  NoServiceFoundException(this.message);
}

class InvalidFormatException {
  var message;
  InvalidFormatException(this.message);
}

class UnKnownException {
  var message;
  UnKnownException(this.message);
}