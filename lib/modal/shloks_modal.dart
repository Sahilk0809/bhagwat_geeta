class GitaModal {
  late int chapter;
  late List<Verse> verses;
  late ChapterName chapterName;

  GitaModal(
      {required this.chapter, required this.verses, required this.chapterName});

  factory GitaModal.fromJson(Map m1) {
    return GitaModal(
      chapter: m1['Chapter'],
      verses: (m1['Verses'] as List)
          .map(
            (e) => Verse.fromJson(e),
          )
          .toList(),
      chapterName: ChapterName.fromJson(m1['ChapterName']),
    );
  }
}

class ChapterName {
  late String sanskrit, hindi, english, gujarati;

  ChapterName(
      {required this.sanskrit,
      required this.hindi,
      required this.english,
      required this.gujarati});

  factory ChapterName.fromJson(Map m1) {
    return ChapterName(
        sanskrit: m1['Sanskrit'],
        hindi: m1['Hindi'],
        english: m1['English'],
        gujarati: m1['Gujarati']);
  }
}

class Verse {
  late int verseNumber;
  late Language language;

  Verse({required this.verseNumber, required this.language});

  factory Verse.fromJson(Map m1) {
    return Verse(
        verseNumber: m1['VerseNumber'],
        language: Language.fromJson(m1['Text']));
  }
}

class Language {
  late String sanskrit, hindi, english, gujarati;

  Language(
      {required this.sanskrit,
      required this.hindi,
      required this.english,
      required this.gujarati});

  factory Language.fromJson(Map m1) {
    return Language(
        sanskrit: m1['Sanskrit'],
        hindi: m1['Hindi'],
        english: m1['English'],
        gujarati: m1['Gujarati']);
  }
}
