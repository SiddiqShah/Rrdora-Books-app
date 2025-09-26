import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff1255F1)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class CategoryList extends StatefulWidget {
  final Function(String) onCategorySelected;

  const CategoryList({super.key, required this.onCategorySelected});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  bool isExpanded = false;

  final List<String> categories = [
  "All",
  "Tech",
  "IT",
  "Motivational",
  "Career",
  "Horror",
  "Fantasy",
  "Science",
  "History",
  "Comics",
];


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isExpanded)
          Row(
            children: [
              for (int i = 0; i < 3; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CategoryCard(
                    title: categories[i],
                    onTap: () => widget.onCategorySelected(categories[i]),
                  ),
                ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = true;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff1255F1)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Show more..",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        if (isExpanded) ...[
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: categories
                .map((cat) => CategoryCard(
                      title: cat,
                      onTap: () => widget.onCategorySelected(cat),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = false;
              });
            },
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff1255F1)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Show Less",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
