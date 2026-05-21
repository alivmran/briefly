import '../datasources/news_remote_data_source.dart';
import '../models/news_item.dart';

class NewsRepository {
  final List<NewsRemoteDataSource> dataSources;

  NewsRepository({required this.dataSources});

  Future<List<NewsItem>> getTechNews() async {
    final futures = dataSources.map((ds) => ds.fetchNews().catchError((e) {
          print('Error fetching from a data source: $e');
          return <NewsItem>[
            NewsItem(
              headline: 'Service Unavailable',
              body: 'A news source failed to load: $e',
            )
          ];
        }));
    final results = await Future.wait(futures);
    return results.expand((newsList) => newsList).toList();
  }
}
