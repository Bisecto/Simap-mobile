import 'package:flutter/material.dart';
import 'package:simap/view/widgets/app_custom_text.dart';

import '../../../../res/app_colors.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  final List<Map<String, String>> books = const [
    {
      'title': 'Tabansi Comprehensive',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToo0bZCpQSmi4PwVVSk4g-AFADB_jnZbewMg&s',
      // Assuming you have this image in assets folder
    },
    {
      'title': 'Ugo C Ugo',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToo0bZCpQSmi4PwVVSk4g-AFADB_jnZbewMg&s',
      // Assuming the same image
    },
    {
      'title': 'Basic Mathematics',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToo0bZCpQSmi4PwVVSk4g-AFADB_jnZbewMg&s',
      // You can add more unique images
    },
    {
      'title': 'Fundamental Physics',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToo0bZCpQSmi4PwVVSk4g-AFADB_jnZbewMg&s',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (books.length * 300) + 100,
      child:  ListView.builder(
        itemCount: books.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final book = books[index];
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Book Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        book['image']!, // Display the book image
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Book Title
                    Text(
                      book['title']!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 10),

                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            _showBookDetails(context, book['title']!);
                          },
                          child: const CustomText(text:'Details',color: AppColors.white,),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.green),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            _readBook(context, book['title']!);
                          },
                          child: const CustomText(text:'Read',color: AppColors.green,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Function to show book details
  void _showBookDetails(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Details for $title'),
          content: const Text(
              'This section can contain book details, author information, etc.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Function to handle "Read" button
  void _readBook(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reading $title...')),
    );
  }
}
