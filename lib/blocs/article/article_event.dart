part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class ArticleGet extends ArticleEvent {
  final String keyword;

  const ArticleGet(this.keyword);

  @override
  List<Object> get props => [keyword];
}
