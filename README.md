📱 Student Registration App
A simple mobile app built with Flutter and powered by a PHP + MySQL backend for registering and fetching student data.

📁 Project Structure
graphql
Copy
Edit
student_registration_app/
├── php_backend/
│   ├── connect.php         # Database connection file
│   ├── register.php        # Handles student registration
│   ├── fetch.php           # Retrieves student data
│   └── schema.sql          # MySQL database schema
└── flutter_app/
    ├── pubspec.yaml        # Flutter dependencies and metadata
    └── lib/
        └── main.dart       # Flutter app entry point
⚙️ Setup Instructions
🖥️ PHP Backend (XAMPP)
Install XAMPP (includes Apache & MySQL).

Copy the php_backend/ folder to:
C:/xampp/htdocs/student_app/

Open the XAMPP Control Panel and start both:

Apache

MySQL



📲 Flutter App
Make sure the Flutter SDK is installed and in your system PATH.

Open a terminal and navigate to the flutter_app/ directory.

Run:

bash
Copy
Edit
flutter pub get
flutter create .   # Generates platform-specific folders
flutter run        # Launch the app on your emulator/device
