import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/book_model.dart';

class BookViewModel {
  final Map<String, String> categories = {
  "All": "flutter OR dart OR programming OR software engineering OR technology OR fantasy OR horror OR history OR science OR IT",
  
  // Broader Technology
  "Tech": "AI OR robotics OR emerging technology OR computer hardware OR electronics OR innovation",
  
  // Specific IT
  "IT": "programming OR cpp OR c++ OR python OR java OR javascript OR dart OR databases OR mysql OR sql OR mongodb OR networking OR computer networks OR operating systems OR information technology OR cybersecurity",
  
  "Motivational": "self help OR success OR personal growth OR motivational books",
  "Career": "career development OR job search OR professional skills",
  "Horror": "horror stories OR thriller OR ghost",
  "Fantasy": "fantasy novels OR magic OR adventure",
  "Science": "physics OR chemistry OR biology OR science",
  "History": "world history OR historical events",
  "Comics": "comics OR graphic novels OR manga",
};




  Future<List<BookModel>> fetchBooks(String category) async {
  try {
    final query = categories[category] ?? "programming";
    final url =
        "https://www.googleapis.com/books/v1/volumes?q=$query&maxResults=40";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List items = data['items'] ?? [];
      return items.map((item) => BookModel.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load books");
    }
  } catch (e) {
    throw Exception("Error fetching books: $e");
  }
}

}