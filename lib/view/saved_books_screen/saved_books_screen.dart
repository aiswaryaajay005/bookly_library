import 'package:flutter/material.dart';
import 'package:interview_task/controller/saved_books_screen_controller.dart';
import 'package:interview_task/helpers/db_helper.dart';
import 'package:interview_task/view/book_details_screen/book_details_screen.dart';
import 'package:provider/provider.dart';

class SavedBooksScreen extends StatefulWidget {
  const SavedBooksScreen({super.key});

  @override
  State<SavedBooksScreen> createState() => _SavedBooksScreenState();
}

class _SavedBooksScreenState extends State<SavedBooksScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SavedBooksScreenController>().fetchSavedBooks();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenState = context.watch<SavedBooksScreenController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Favourite Books', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body:
          screenState.isLoading
              ? Center(child: CircularProgressIndicator())
              : screenState.savedBooks.isEmpty
              ? Center(child: Text('No saved books found.'))
              : ListView.builder(
                itemCount: screenState.savedBooks.length,
                itemBuilder: (context, index) {
                  final book = screenState.savedBooks[index];
                  final imageUrl = book.formats?['image/jpeg'] ?? '';

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => BookDetailsScreen(
                                bookId: screenState.savedBooks[index].id!,
                              ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Image.network(
                        imageUrl,
                        width: 50,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                Icon(Icons.broken_image),
                      ),
                      title: Text(book.title ?? 'No Title'),
                      subtitle: Text(
                        book.authors?.isNotEmpty == true
                            ? book.authors!.first.name ?? ''
                            : 'Unknown Author',
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          context
                              .read<SavedBooksScreenController>()
                              .deleteFavourite(
                                bookId: screenState.savedBooks[index].id!,
                                context: context,
                              );
                        },
                        icon: Icon(Icons.delete_forever),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
