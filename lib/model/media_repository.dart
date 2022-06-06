import 'package:mvvm_provider/model/media.dart';
import 'package:mvvm_provider/model/services/base_service.dart';
import 'package:mvvm_provider/model/services/media_service.dart';

class MediaRepository {
  BaseService _mediaSrvice = MediaService();

  Future<List<Media>> fetchMediaList(String value) async {
    dynamic response = await _mediaSrvice.getResponse(value);
    final jsonData = response['results'] as List;
    List<Media> mediaList =
        jsonData.map((tagJson) => Media.fromJson(tagJson)).toList();

    return mediaList;
  }
}
