import 'package:dio/dio.dart';
import 'package:real_world/interceptors/auth_interceptor.dart';
import 'package:real_world/interceptors/no_auth_interceptor.dart';
import 'package:real_world/models/article_model.dart';

class ArticleRepository {
  Future<List<String>> getTags() async {
    Dio dio = Dio();
    dio.interceptors.add(NoAuthInterceptor());

    var res = await dio.get(
      '/api/tags',
    );

    List<String> tags = [];
    for (var tag in res.data['tags']) {
      tags.add(tag.toString());
    }

    return tags;
  }

  Future<ArticlesModel> getArticles({
    String? tag,
    String? author,
    String? favorited,
    int? limit,
    int? offset,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(NoAuthInterceptor());

    Map<String, dynamic> queryParams = {};
    if (tag != null) queryParams['tag'] = tag;
    if (author != null) queryParams['author'] = author;
    if (favorited != null) queryParams['favorited'] = favorited;
    if (limit != null) queryParams['limit'] = limit;
    if (offset != null) queryParams['offset'] = offset;

    var res = await dio.get(
      '/api/articles',
      queryParameters: queryParams,
    );

    return ArticlesModel.fromJson(res.data);
  }

  Future<ArticleModel> getArticle({
    required String slug,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(NoAuthInterceptor());

    var res = await dio.get('/api/articles/$slug');

    return ArticleModel.fromJson(res.data['article']);
  }

  Future<ArticleModel> favArticle({
    required String slug,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());

    var res = await dio.post('/api/articles/$slug/favorite');

    return ArticleModel.fromJson(res.data['article']);
  }

  Future<ArticleModel> unfavArticle({
    required String slug,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());

    var res = await dio.delete('/api/articles/$slug/favorite');

    return ArticleModel.fromJson(res.data['article']);
  }

  Future<ArticleModel> createArticle({
    required String title,
    required String description,
    required String body,
    List<String>? tagList,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());

    Map<String, dynamic> bodyData = {
      'title': title,
      'description': description,
      'body': body,
    };
    if (tagList != null && tagList.isNotEmpty) {
      bodyData['tagList'] = tagList;
    }

    var res = await dio.post(
      '/api/articles',
      data: {"article": bodyData},
    );

    print(res);

    return ArticleModel.fromJson(res.data['article']);
  }
}
