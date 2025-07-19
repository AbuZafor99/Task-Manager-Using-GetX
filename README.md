Absolutely! Here's your **complete and corrected `README.md`** with the fixed `Project Structure` section. Just copy and paste this into your `README.md` file:

---

```markdown
# 📝 Task Manager (Flutter)

A cross-platform task management app built using Flutter that allows users to create, manage, and organize personal tasks with secure authentication, categorized task views, and profile management.

> 🚀 [Live Repository](https://github.com/AbuZafor99/Task-Manager-Flutter)

---

## ✨ Features

### 🔐 Authentication
- User Sign Up, Sign In
- Password reset via email & PIN
- Secure session storage with token-based auth

### 📋 Task Management
- Add new tasks with title & description
- View tasks by status:
  - 🆕 New
  - ⏳ In Progress
  - ✅ Completed
  - ❌ Cancelled
- UI support for editing & deleting (backend integration pending)

### 👤 Profile Management
- View and update user profile info
- Upload profile picture (UI-ready)

### 🎨 Modern UI/UX
- Material Design, responsive layout
- Bottom navigation bar for easy task category browsing

---

## 🧱 Project Structure

```

lib/  
├── app.dart                   
├── main.dart                    
├── data/  
│   ├── models/                  
│   ├── service/                 
│   └── urls.dart                
├── ui/  
│    ├── controllers/             
│    ├── screens/                 
│    ├── widgets/                 
│    └── utils/                   
assets/  
└──  images/                      

````

---

## 🔧 Getting Started

### ✅ Prerequisites
- Flutter SDK >= 3.8.1
- Android Studio / Xcode
- Internet connection (uses remote API)

### ▶️ Installation

```bash
git clone https://github.com/AbuZafor99/Task-Manager-Flutter.git
cd Task-Manager-Flutter
flutter pub get
flutter run
````

---

## 🔗 API Integration

**Base URL:** `http://35.73.30.144:2005/api/v1`

| Endpoint        | Description        |
| --------------- | ------------------ |
| `/Registration` | Register new users |
| `/Login`        | Login users        |
| `/createTask`   | Add new task       |

To use your own backend, update the URL in:
`lib/data/urls.dart`

---

## 📦 Dependencies

| Package              | Purpose                  |
| -------------------- | ------------------------ |
| `flutter_svg`        | SVG support              |
| `http`               | API calls                |
| `shared_preferences` | Local storage for tokens |
| `pin_code_fields`    | OTP input UI             |
| `email_validator`    | Form validation          |
| `image_picker`       | Profile image upload     |

---

## 📸 Screenshots

> *Add screenshots here of: Login, Dashboard, Task Cards, Profile Edit.*

---

## 🚧 Work in Progress

* [ ] Edit/Delete Task backend integration
* [ ] Profile picture upload support
* [ ] Push notifications (reminders)
* [ ] Offline support (Hive/SQLite)
* [ ] Advanced task filters (priority, due date)

---

## 🤝 Contributing

Contributions are welcome!

1. Fork the repo
2. Create a new branch (`feature/my-feature`)
3. Commit your changes
4. Open a Pull Request

---


## 🙋 Author

**Abu Zafor**
GitHub: [@AbuZafor99](https://github.com/AbuZafor99)

---

> *This app demonstrates best practices in Flutter development, with modular architecture, clean code, and scalable features.*

```

---

Let me know if you want:
- A downloadable `.md` file  
- A version with **badges** (like Flutter version, MIT license, GitHub stars, etc.)  
- GitHub Actions integration  
- Auto-generated screenshots/mockups  

Happy coding! 🚀
```
