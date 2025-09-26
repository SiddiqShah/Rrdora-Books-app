import 'package:flutter/material.dart';
import 'package:redora/view/book_reader_screen.dart';
import '../model/book_model.dart';

class BookCard extends StatelessWidget {
  final BookModel book;
  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (book.previewLink != null && book.previewLink!.isNotEmpty) {
          // Navigate to reader when tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookReaderScreen(
                pdfUrl: book.previewLink!,        // use actual PDF url
                bookId: book.id,                  // ✅ id is guaranteed non-null
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("This book has no preview available"),
            ),
          );
        }
      },
      child: Card(
        color: Colors.white10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  book.thumbnail ?? "https://via.placeholder.com/150",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network("https://via.placeholder.com/150");
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                book.title ?? "No Title",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                book.authors ?? "Unknown",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
