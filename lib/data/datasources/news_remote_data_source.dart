import '../models/news_item.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsItem>> fetchNews();
}
