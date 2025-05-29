import 'package:flutter/material.dart';
import 'package:interview_task/controller/book_details_screen_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailsScreen extends StatefulWidget {
  final int bookId;
  const BookDetailsScreen({super.key, required this.bookId});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<BookDetailsScreenController>().fetchBookDetails(
        bookId: widget.bookId.toString(),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenState = context.watch<BookDetailsScreenController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Details',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child:
            screenState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.network(
                          screenState.bookDetails?.formats?['image/jpeg'] ?? '',
                          fit: BoxFit.cover,
                          height: 200,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        screenState.bookDetails?.title ?? 'No Title',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        screenState.bookDetails?.authors?.isNotEmpty == true
                            ? screenState.bookDetails!.authors![0].name ??
                                'Unknown Author'
                            : 'Unknown Author',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        (screenState.bookDetails?.summaries != null &&
                                screenState.bookDetails!.summaries!.isNotEmpty)
                            ? screenState.bookDetails!.summaries!.first
                            : 'No Description',
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Subjects",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children:
                            (screenState.bookDetails?.subjects ?? [])
                                .map((subject) => Chip(label: Text(subject)))
                                .toList(),
                      ),

                      const SizedBox(height: 16),
                      Text(
                        "Languages",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children:
                            (screenState.bookDetails?.languages ?? [])
                                .map((lang) => Chip(label: Text(lang)))
                                .toList(),
                      ),

                      const SizedBox(height: 16),
                      Text(
                        "Available Formats",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            (screenState.bookDetails?.formats?.entries
                                        .toList() ??
                                    [])
                                .where(
                                  (entry) =>
                                      entry.value.toString().startsWith('http'),
                                )
                                .map(
                                  (entry) => Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: InkWell(
                                      onTap: () async {
                                        final url = entry.value.toString();
                                        if (await canLaunchUrl(
                                          Uri.parse(url),
                                        )) {
                                          await launchUrl(Uri.parse(url));
                                        }
                                      },
                                      child: Text(
                                        '${entry.key.split(";").first}',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
