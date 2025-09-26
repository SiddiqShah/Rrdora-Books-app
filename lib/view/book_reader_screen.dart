import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookReaderScreen extends StatefulWidget {
  final String pdfUrl; // PDF link from API
  final String bookId; // Unique ID for saving progress

  const BookReaderScreen({
    super.key,
    required this.pdfUrl,
    required this.bookId,
  });

  @override
  State<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late PdfViewerController _controller;
  int _lastPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PdfViewerController();
    _loadLastPage();
  }

  Future<void> _loadLastPage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastPage = prefs.getInt(widget.bookId) ?? 0;
    });
  }

  Future<void> _saveLastPage(int pageNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(widget.bookId, pageNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Book Reader")),
      body: SfPdfViewer.network(
        widget.pdfUrl,
        key: _pdfViewerKey,
        controller: _controller,
        onPageChanged: (details) {
          _saveLastPage(details.newPageNumber);
        },
        initialPageNumber: _lastPage,
      ),
    );
  }
}
