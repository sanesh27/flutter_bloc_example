import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/album_app/bloc/album_bloc.dart';
import 'package:timer/album_app/bloc/album_states.dart';
import 'package:timer/album_app/bloc/album_events.dart';
import 'package:timer/album_app/service/album_model.dart';
import 'package:timer/album_app/service/album_services.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlbumBloc(albumsRepo: AlbumServices()),
      child: const AlbumsScreen(),
    );
  }
}


class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({Key? key}) : super(key: key);

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {

  @override
  void initState() {
    _loadAlbums();
    super.initState();
  }

  _loadAlbums() async {
    context.read<AlbumBloc>().add(const AlbumFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
      ),
      body: Container(
        child: _body(),
      ),
    );
  }

  _body() {
    return Column(
      children: [
        BlocBuilder<AlbumBloc, AlbumState>(
            builder: (BuildContext context, AlbumState state) {
              if (state is AlbumsListError) {
                final error = state.error;
                String message = '${error.message}\nTap to Retry.';
                return ErrorTxt(
                  message: message,
                  onTap: _loadAlbums,
                );
              }
              if (state is AlbumsLoaded) {
                List<Album> albums = state.albums;
                return _list(albums);
              }
              return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
              );
            }
        ),
      ],
    );
  }

  Widget _list(List<Album> albums) {
    return Expanded(
        child: ListView.builder(
          itemCount: albums.length,
            itemBuilder: (_, index) {
            return ListRow(album: albums[index]);
            }
        ),
    );
  }
}

class ListRow extends StatelessWidget {
  //
  final Album album;
  const ListRow({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            album.title ?? "",
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}


class ErrorTxt extends StatelessWidget {
  //
  final String message;
  final Function onTap;
  const ErrorTxt({super.key, required this.message, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: InkWell(
          onTap: () {
            onTap();
          },
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}


