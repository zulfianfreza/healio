import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healio/models/article_model.dart';

import '../../services/article_service.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(ArticleInitial()) {
    on<ArticleEvent>((event, emit) async {
      if (event is ArticleGet) {
        try {
          emit(ArticleLoading());

          final articles =
              await ArticleService().getArticle(keyword: event.keyword);

          emit(ArticleSuccess(articles));
        } catch (e) {
          emit(ArticleFailed(e.toString()));
        }
      }
    });
  }
}
