abstract class BaseService {
  final String mediaBaseUrl = 'https://itunes.apple.com/search?term=';

  Future<dynamic> getResponse(String url); // probably it would be better to use fetchResponse instead of getResponse
}