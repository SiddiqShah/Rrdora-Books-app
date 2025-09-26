// lib/model/book_model.dart

class BookModel {
  final String id; // unique id from the API (volume id)
  final String? title;
  final String? authors;
  final String? thumbnail;
  final String? previewLink; // often the Google Books preview/web reader link
  final bool pdfAvailable;
  final bool epubAvailable;

  BookModel({
    required this.id,
    this.title,
    this.authors,
    this.thumbnail,
    this.previewLink,
    this.pdfAvailable = false,
    this.epubAvailable = false,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final volumeInfo = (json['volumeInfo'] ?? {}) as Map<String, dynamic>;
    final accessInfo = (json['accessInfo'] ?? {}) as Map<String, dynamic>;

    // build authors string
    String? authors;
    if (volumeInfo['authors'] != null && volumeInfo['authors'] is List) {
      authors = (volumeInfo['authors'] as List).cast<String>().join(', ');
    }

    // thumbnail (try thumbnail then smallThumbnail)
    String? thumbnail;
    if (volumeInfo['imageLinks'] != null && volumeInfo['imageLinks'] is Map) {
      final img = volumeInfo['imageLinks'] as Map<String, dynamic>;
      thumbnail = img['thumbnail'] ?? img['smallThumbnail'];
    }

    // preview link: prefer volumeInfo.previewLink, then accessInfo.webReaderLink, then fallback to null
    String? previewLink = volumeInfo['previewLink'] as String?;
    previewLink ??= accessInfo['webReaderLink'] as String?;
    // Sometimes accessInfo contains pdf/epub acsTokenLink — keep it if present (may require auth)
    previewLink ??= (accessInfo['pdf'] is Map) ? (accessInfo['pdf']['acsTokenLink'] as String?) : null;
    previewLink ??= (accessInfo['epub'] is Map) ? (accessInfo['epub']['acsTokenLink'] as String?) : null;

    // pdf/epub availability flags
    final bool pdfAvailable = (accessInfo['pdf']?['isAvailable'] == true);
    final bool epubAvailable = (accessInfo['epub']?['isAvailable'] == true);

    // id from top-level json['id'] (volume id)
    final String id = (json['id'] ?? volumeInfo['title'] ?? DateTime.now().millisecondsSinceEpoch.toString()).toString();

    return BookModel(
      id: id,
      title: volumeInfo['title'] as String?,
      authors: authors ?? 'Unknown',
      thumbnail: thumbnail,
      previewLink: previewLink,
      pdfAvailable: pdfAvailable,
      epubAvailable: epubAvailable,
    );
  }
}
