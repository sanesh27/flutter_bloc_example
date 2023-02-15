import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:timer/album_app/bloc/album_events.dart';
import 'package:timer/album_app/bloc/album_states.dart';
import 'package:timer/album_app/service/album_model.dart';
import 'package:timer/album_app/service/album_services.dart';

class AlbumBloc extends Bloc<AlbumEvents, AlbumState> {
  final AlbumsRepo albumsRepo;
  List<Album> albums = [];

  AlbumBloc({required this.albumsRepo}) : super(AlbumsInitState()) {
    on<AlbumFetchEvent>(mapEventToState);
  }

  Future<void> mapEventToState(AlbumEvents event, Emitter<AlbumState> emit) async{
    emit(AlbumsLoading());
    try {
      albums = await albumsRepo.getAlbumList();
      emit(AlbumsLoaded(albums: albums));
    } on SocketException {
      emit (AlbumsListError(
        error: NoInternetException('No Internet'),
      ));
    } on HttpException {
      emit(AlbumsListError(
        error: NoServiceFoundException('No Service Found'),
      ));
    } on FormatException {
      emit(AlbumsListError(
        error: InvalidFormatException('Invalid Response format'),
      ));
    }
    catch (e) {
      emit(AlbumsListError(
        error: UnKnownException('Unknown Error'),
      ));
    }
  }
}