import 'dart:convert';

BooksResModel booksResModelFromJson(String str) =>
    BooksResModel.fromJson(json.decode(str));

String booksResModelToJson(BooksResModel data) => json.encode(data.toJson());

class BooksResModel {
  int? count;
  String? next;
  String? previous;
  List<Book>? results;

  BooksResModel({this.count, this.next, this.previous, this.results});

  factory BooksResModel.fromJson(Map<String, dynamic> json) => BooksResModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results:
        json["results"] == null
            ? []
            : List<Book>.from(json["results"].map((x) => Book.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results":
        results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Book {
  int? id;
  String? title;
  List<Author>? authors;
  List<String>? summaries;
  List<dynamic>? translators;
  List<String>? subjects;
  List<String>? bookshelves;
  List<String>? languages;
  bool? copyright;
  String? mediaType;
  Map<String, String>? formats;
  int? downloadCount;

  Book({
    this.id,
    this.title,
    this.authors,
    this.summaries,
    this.translators,
    this.subjects,
    this.bookshelves,
    this.languages,
    this.copyright,
    this.mediaType,
    this.formats,
    this.downloadCount,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["id"],
    title: json["title"],
    authors:
        json["authors"] == null
            ? []
            : List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
    summaries:
        json["summaries"] == null ? [] : List<String>.from(json["summaries"]),
    translators:
        json["translators"] == null
            ? []
            : List<dynamic>.from(json["translators"]),
    subjects:
        json["subjects"] == null ? [] : List<String>.from(json["subjects"]),
    bookshelves:
        json["bookshelves"] == null
            ? []
            : List<String>.from(json["bookshelves"]),
    languages:
        json["languages"] == null ? [] : List<String>.from(json["languages"]),
    copyright: json["copyright"],
    mediaType: json["media_type"],
    formats:
        json["formats"] == null
            ? {}
            : Map<String, String>.from(json["formats"]),
    downloadCount: json["download_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "authors":
        authors == null
            ? []
            : List<dynamic>.from(authors!.map((x) => x.toJson())),
    "summaries": summaries == null ? [] : List<dynamic>.from(summaries!),
    "translators": translators == null ? [] : List<dynamic>.from(translators!),
    "subjects": subjects == null ? [] : List<dynamic>.from(subjects!),
    "bookshelves": bookshelves == null ? [] : List<dynamic>.from(bookshelves!),
    "languages": languages == null ? [] : List<dynamic>.from(languages!),
    "copyright": copyright,
    "media_type": mediaType,
    "formats": formats,
    "download_count": downloadCount,
  };
}

class Author {
  String? name;
  int? birthYear;
  int? deathYear;

  Author({this.name, this.birthYear, this.deathYear});

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    name: json["name"],
    birthYear: json["birth_year"],
    deathYear: json["death_year"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "birth_year": birthYear,
    "death_year": deathYear,
  };
}
