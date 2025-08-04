
```markdown
# 📝 Task Manager (Flutter)

A cross-platform task management app built using Flutter that allows users to create, manage, and organize personal tasks with secure authentication, categorized task views, and profile management.

> 🚀 [Live Repository](https://github.com/AbuZafor99/Task-Manager-Using-GetX)

---

## ✨ Features

### 🔐 Authentication
- User Sign Up, Sign In
- **Forgot Password with Email Recovery**
  - Send recovery email to registered email address
  - Verify 6-digit OTP sent to email
  - Reset password with new secure password
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
| `/RecoverVerifyEmail/{email}` | Send recovery email |
| `/RecoverVerifyOtp/{email}/{otp}` | Verify OTP for password reset |
| `/RecoverResetPassword` | Reset password with new password |

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

