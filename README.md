# 📱 Student Registration App

A lightweight student registration system built with **Flutter** for the frontend and **PHP + MySQL** for the backend. This app allows users to register student details and fetch them from a remote server.

---

## 🗂️ Project Structure

```
student_registration_app/
├── php_backend/
│   ├── connect.php        # Database connection
│   ├── register.php       # Handles student registration
│   ├── fetch.php          # Retrieves student data
│   └── schema.sql         # SQL script to set up the database
└── flutter_app/
    ├── pubspec.yaml       # Flutter project configuration
    └── lib/
        └── main.dart      # Main Flutter application
```

---

## ⚙️ Getting Started

### 🔧 PHP Backend Setup (XAMPP)

1. Install **XAMPP**, which includes **Apache** and **MySQL**.
2. Copy the `php_backend/` directory into the following path:
   `C:/xampp/htdocs/student_app/`
3. Open the **XAMPP Control Panel** and start:

   * Apache
   * MySQL
4. Visit `localhost/phpmyadmin` in your browser.
5. Create a new database (e.g., `student_db`) and import `schema.sql` to create the necessary table.

---

### 📲 Flutter App Setup

1. Ensure that the **Flutter SDK** is installed and properly configured.
2. Open a terminal and navigate to the `flutter_app/` directory.
3. Run the following commands:

   ```bash
   flutter pub get         # Fetch dependencies
   flutter create .        # Generate platform-specific folders
   flutter run             # Launch app on connected device/emulator
   ```

---

## 🧠 Usage Notes

* The default host IP for **Android emulators** to access localhost is:
  `http://10.0.2.2`
* For **physical devices**, you must update the base URL in `main.dart` with your computer’s local IP address (e.g., `http://192.168.x.x`).
* Ensure your device and PC are connected to the **same Wi-Fi network** for local communication.

---

## ✅ Features

* Register student details with name and email.
* Fetch and display the list of all registered students.
* Clean and minimal UI using Flutter widgets.
* Simple backend with secure MySQL-PHP communication.

---

## 📌 Tips

* Always restart Apache and MySQL before testing.
* If facing CORS or network issues, ensure firewall or antivirus is not blocking local connections.
* You can modify the backend PHP files to add more functionality (like delete or update features).


