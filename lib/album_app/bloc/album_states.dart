import 'package:equatable/equatable.dart';
import 'package:timer/album_app/service/album_model.dart';

abstract class AlbumState extends Equatable {
  @override
  List<Object> get props => [];
}

class AlbumsInitState extends AlbumState {}

class AlbumsLoading extends AlbumState {}

class AlbumsLoaded extends AlbumState {
  final List<Album> albums;
  AlbumsLoaded({required this.albums});
}

class AlbumsListError extends AlbumState {
  final error;
  AlbumsListError({this.error});
}