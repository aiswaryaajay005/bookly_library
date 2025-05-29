Bookly – A Simple Book Library App
Bookly is a Flutter application that allows users to browse a collection of books, manage their favorites, and securely authenticate using Supabase. The app employs the Provider package for efficient state management, ensuring a responsive and scalable user experience.

Features
 -User Authentication
Secure sign-up and login functionality using Supabase Auth.

 -Book Listing
Display a list of books with details such as title, author, and publication year.
Search functionality to filter books by title or author.

 -Favorites Management
Users can add or remove books from their favorites list.
View a personalized list of favorite books.


 -TechStack
Frontend : Flutter (Dart)
State Management : Provider
Backend/Auth : Supabase
Database : Supabase (PostgreSQL)
REST API Integration :Gutenberg Books API(https://gutendex.com/)

 -project structure
 lib/
├── app_config/     
├── controller/     
├── helpers/        
├── model/          
├── view/ 
├── utils/  
├── service/        
└── main.dart    

 -Prerequisites

- Flutter SDK installed
- Dart SDK (included with Flutter)
- Supabase account
- Android Studio / VS Code
- Emulator or real device

 -Set up Instructions 
   1.Clone the Repository
   git clone https://github.com/aiswaryaajay005/bookly_library.git
   cd bookly_library
   2.Install Dependencies and Run
   flutter pub get
   flutter run

 -Notes
 The application uses the Provider package for state management, ensuring a clean separation of concerns and reactive UI updates.
 Supabase provides a scalable backend solution with integrated authentication and real-time database capabilities.
 The codebase is modular and organized, facilitating easy maintenance and future feature additions.

 -Author & Contact
Developer: Aiswarya Ajayakumar
Email: [aiswaryaajayakumar176@gmail.com]
GitHub: [https://github.com/aiswaryaajay005] 
