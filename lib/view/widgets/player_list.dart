import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvvm_provider/model/media.dart';
import 'package:mvvm_provider/view_model/media_view_model.dart';

class PlayerListWidget extends StatefulWidget {
  final List<Media> _mediaList;
  final Function _function;

  PlayerListWidget(this._mediaList, this._function);

  @override
  State<PlayerListWidget> createState() => _PlayerListWidgetState();
}

class _PlayerListWidgetState extends State<PlayerListWidget> {

  Widget _buildSongItem(Media media) {
    Media? _selectedMedia = Provider
        .of<MediaViewModel>(context)
        .media;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              width: 50,
              height: 50,
              child: Image.network(media.artworkUrl ?? ''),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  media.trackName ?? '',
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  media.artistName ?? '',
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Text(
                  media.collectionName ?? '',
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (_selectedMedia != null &&
              _selectedMedia.trackName == media.trackName)
            Icon(
              Icons.play_circle_fill_outlined,
              color: Theme
                  .of(context)
                  .primaryColor,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: widget._mediaList.length,
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              Media data = widget._mediaList[index];
              return InkWell(
                onTap: () {
                  if (null != data.artistName) {
                    widget._function(data);
                  }
                },
                child: _buildSongItem(data),
              );
            },
          )
        ],
      ),
    );
  }
}
