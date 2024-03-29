import 'package:equatable/equatable.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/models/article_model.dart';

class ArticleState extends Equatable {
  final ECommonStatus status;
  final ArticleModel? article;
  final String? message;

  const ArticleState({
    this.status = ECommonStatus.init,
    this.article,
    this.message,
  });

  ArticleState copyWith({
    ECommonStatus? status,
    ECommonStatus? commentStatus,
    ArticleModel? article,
    String? message,
  }) =>
      ArticleState(
        status: status ?? this.status,
        article: article ?? this.article,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        status,
        article,
        message,
      ];
}
