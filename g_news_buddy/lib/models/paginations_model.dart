import 'article_model.dart';

class Pagination {
  Pagination({
    required this.count,
    required this.startIndex,
    required this.data,
  });
  late final int count;
  late final int startIndex;
  late final List<ArticlesData> data;

  Pagination.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    startIndex = json['startIndex'];
    data =
        List.from(json['data']).map((e) => ArticlesData.fromJson(e)).toList();
  }
}
