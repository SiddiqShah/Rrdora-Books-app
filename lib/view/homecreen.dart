import 'package:flutter/material.dart';
import 'package:redora/ViewModel/book_viewmodel.dart';
import '../model/book_model.dart';
import '../widgets/catagory_card_.dart';
import '../widgets/book_card.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/searchbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BookViewModel _viewModel = BookViewModel();
  late Future<List<BookModel>> futureBooks;
  String selectedCategory = "All";
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureBooks = _viewModel.fetchBooks(selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F1030),

      // ✅ AppBar with Notification Icon
      appBar: AppBar(
        backgroundColor: const Color(0xff0F1030),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "REDORA",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 24,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // 🔔 Notification icon press action
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      // ✅ Drawer added back
      drawer: const CustomDrawer(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              controller: _searchController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    futureBooks = _viewModel.fetchBooks(value);
                  });
                } else {
                  setState(() {
                    futureBooks = _viewModel.fetchBooks(selectedCategory); 
                  });
                }
              },
              onClear: () {
                setState(() {
                  _searchController.clear();
                  futureBooks = _viewModel.fetchBooks(selectedCategory); // reset
                });
              },
            ),

            const SizedBox(height: 20),

            // ✅ Categories
            CategoryList(
              onCategorySelected: (category) {
                setState(() {
                  selectedCategory = category;
                  futureBooks = _viewModel.fetchBooks(category);
                });
              },
            ),

            const SizedBox(height: 20),

            // ✅ Books Grid
            FutureBuilder<List<BookModel>>(
              future: futureBooks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.white));
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text("Error: ${snapshot.error}",
                          style: const TextStyle(color: Colors.red)));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text("No books found",
                          style: TextStyle(color: Colors.white)));
                }

                final books = snapshot.data!;
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: books.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 per row
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return BookCard(book: book);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
