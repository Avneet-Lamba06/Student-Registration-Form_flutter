u   `0# Student Registration App

This project showcases a simple Flutter mobile application with a PHP & MySQL backend.

## Structure

```
student_registration_app/
├── php_backend/
│   ├── connect.php
│   ├── register.php
│   ├── fetch.php
│   └── schema.sql
└── flutter_app/
    ├── pubspec.yaml
    └── lib/
        └── main.dart\              /
```

## Setup Instructions

### PHP Backend
1. Install **XAMPP** (Apache + MySQL).
2. Copy the `php_backend` folder to `C:/xampp/htdocs/student_app`.
3. Start **Apache** and **MySQL** from the XAMPP control panel.
4. Open **phpMyAdmin** and execute `schema.sql` to create the database/table.

### Flutter App
1. Ensure Flutter SDK is installed.
2. Navigate to `flutter_app` and run `flutter pub get`.
3. To generate platform folders, run `flutter create .`.
4. Run `flutter run` on an emulator or connected device.

**Note**: 
- `10.0.2.2` is the default host IP for Android emulators to access localhost.
- For physical devices, replace the IP in `main.dart` with your PC's local IP.
[Download Project Zip](../student_registration_project.zip)
