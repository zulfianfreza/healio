part of 'article_bloc.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleFailed extends ArticleState {
  final String e;
  const ArticleFailed(this.e);

  @override
  List<Object> get props => [e];
}

class ArticleSuccess extends ArticleState {
  final List<ArticleModel> articles;
  const ArticleSuccess(this.articles);

  @override
  List<Object> get props => [articles];
}
