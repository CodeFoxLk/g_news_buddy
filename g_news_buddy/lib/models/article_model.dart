
import 'package:intl/intl.dart';

class ArticlesData {
  ArticlesData({
    required this.contentId,
    required this.contentType,
    required this.thumbnails,
    required this.metadata,
    required this.tags,
    required this.assets,
    required this.authors
  });
  late final String? contentId;
  late final String? contentType;
  late final List<Thumbnails> thumbnails;
  late final Metadata? metadata;
  late final List<String> tags;
  late final List<Assets> assets;
  late final List<Authors> authors;
  
  ArticlesData.fromJson(Map<String, dynamic> json){
    contentId = json['contentId'];
    contentType = json['contentType'];
    thumbnails = json['thumbnails'] == null ? [] : List.from(json['thumbnails']).map((e)=>Thumbnails.fromJson(e)).toList();
    metadata = Metadata.fromJson(json['metadata']);
    tags = json['tags'] == null ? [] : List.castFrom<dynamic, String>(json['tags']);
    assets = json['assets'] == null ? [] : List.from(json['assets']).map((e)=>Assets.fromJson(e)).toList();
    authors = json['authors'] == null ? [] : List.from(json['authors']).map((e)=>Authors.fromJson(e)).toList();
  }

  
}

class Thumbnails {
  Thumbnails({
    required this.url,
    required this.size,
    required this.width,
    required this.height,
  });
  late final String? url;
  late final String? size;
  late final int? width;
  late final int? height;
  
  Thumbnails.fromJson(Map<String, dynamic> json){
    url = json['url'];
    size = json['size'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['size'] = size;
    _data['width'] = width;
    _data['height'] = height;
    return _data;
  }
}

class Metadata {
  Metadata({
    required this.title,
    required this.description,
    required this.publishDate,
    required this.slug,
    required this.networks,
    //required this.state,
    required this.duration,
    required this.videoSeries,
  });
  late final String? title;
  late final String? description;
  late final String publishDate;
  late final String? slug;
  late final List<String> networks;
  //late final String? state;
  late final int? duration;
  late final String? videoSeries;
  
  Metadata.fromJson(Map<String, dynamic> json){
    title = json['title'] ?? json['headline'];
    description = json['description'];
    publishDate = json['publishDate'] == null ? DateTime.now().toString() : DateFormat("yyyy-MM-dd").format(DateTime.parse(json['publishDate'])) ;
    slug = json['slug'];
    networks = json['networks'] == null ? [] : List.castFrom<dynamic, String>(json['networks']);
    //state = json['state'];
    duration = json['duration'];
    videoSeries = json['videoSeries'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['description'] = description;
    _data['publishDate'] = publishDate;
    _data['slug'] = slug;
    _data['networks'] = networks;
    //_data['state'] = state;
    _data['duration'] = duration;
    _data['videoSeries'] = videoSeries;
    return _data;
  }
}

class Assets {
  Assets({
    required this.url,
    required this.height,
    required this.width,
  });
  late final String? url;
  late final int? height;
  late final int? width;
  
  Assets.fromJson(Map<String, dynamic> json){
    url = json['url'];
    height = json['height'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['height'] = height;
    _data['width'] = width;
    return _data;
  }
}

class Authors {
  Authors({
    required this.name,
    required this.thumbnail,
  });
  late final String? name;
  late final String? thumbnail;
  
  Authors.fromJson(Map<String, dynamic> json){
    name = json['name'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['thumbnail'] = thumbnail;
    return _data;
  }
}