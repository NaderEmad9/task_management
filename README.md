# Task Management App

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"/>
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase"/>
  <img src="https://img.shields.io/badge/Provider-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Provider"/>
</p>

<p align="center">
  A modern, feature-rich task management application built with Flutter, featuring real-time synchronization, dark mode support, and an intuitive user interface.
</p>

---

## 📱 Features

- ✅ **Add Tasks**: Create new tasks with titles, descriptions, and due dates
- ✏️ **Edit Tasks**: Modify existing tasks for corrections or updates
- ✔️ **Task Completion**: Mark tasks as completed with a simple swipe action
- 🗑️ **Delete Tasks**: Remove tasks from the list by swiping
- 📱 **Responsive UI**: Ensures that the layout adapts to different screen sizes and orientations
- 🌓 **Dark Mode**: Support for both light and dark themes based on user preferences
- 🔥 **Firebase Integration**: Sync tasks in real-time across devices using Firebase
- 🔐 **Authentication**: Secure user authentication with Firebase Auth

---

## 🏗️ Architecture

This project follows a **Provider-based State Management** pattern with a clean separation of concerns:

```
lib/
├── auth/                    # Authentication screens
│   ├── login/              # Login screen & logic
│   └── register/           # Registration screen & logic
├── home/                    # Main home screen
├── model/                   # Data models
│   ├── my_user.dart        # User model
│   └── task.dart           # Task model
├── provider/                # State management
│   ├── app_theme_provider.dart
│   ├── auth_user_provider.dart
│   └── list_provider.dart
├── task/                    # Task-related features
│   ├── add_task.dart
│   ├── edit_task.dart
│   ├── task_list_item.dart
│   └── task_tab.dart
├── settings/                # Settings & preferences
├── ui/                      # UI theme & styling
│   ├── app_colors.dart
│   ├── app_theme_data.dart
│   └── dialog_utils.dart
├── reuseable/               # Reusable widgets
└── main.dart                # App entry point
```

### Architecture Flow

```
┌─────────────┐
│   UI Layer  │  (Screens & Widgets)
└──────┬──────┘
       │
┌──────▼──────┐
│  Provider   │  (State Management)
└──────┬──────┘
       │
┌──────▼──────┐
│   Models    │  (Data Models)
└──────┬──────┘
       │
┌──────▼──────┐
│  Firebase   │  (Backend & Auth)
└─────────────┘
```

---

## 🛠️ Tech Stack

| Category | Technology |
|----------|-----------|
| **Framework** | Flutter 3.0+ |
| **Language** | Dart |
| **Backend** | Firebase (Firestore, Auth) |
| **State Management** | Provider |
| **UI Components** | Material Design |
| **Fonts** | Google Fonts |
| **Platform** | Android, iOS |

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- [Flutter](https://flutter.dev/docs/get-started/install) (version 3.0 or later)
- [Dart](https://dart.dev/get-dart)
- Firebase project set up (for backend and data syncing)

### Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/NaderEmad9/task_management.git
   ```

2. **Navigate to the Project Directory**

   ```bash
   cd task_management
   ```

3. **Install Dependencies**

   Run the following command to fetch the required packages:

   ```bash
   flutter pub get
   ```

4. **Firebase Setup**

   - Set up Firebase for your project:
     - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/).
     - Follow the instructions to add both Android and iOS Firebase configurations,(or simply choose flutter configuration).
     - Replace `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) in the respective directories, or just use flutter integration provided by Firebase.

5. **Run the Application**

   To run the application on your preferred device, use:

   ```bash
   flutter run
   ```


## Screenshots

### Light Mode

<p align="center">
  <img src="https://github.com/NaderEmad9/task_management/raw/main/assets/screenshots/light/splash.png" alt="Splash" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/task_management/raw/main/assets/screenshots/light/signup.png" alt="Sign Up" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/task_management/raw/main/assets/screenshots/light/signin.png" alt="Sign In" width="220" style="margin: 10px;"/>

</p>
<p align="center">
  <img src="https://github.com/NaderEmad9/task_management/raw/main/assets/screenshots/light/task.png" alt="Task" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/task_management/raw/main/assets/screenshots/light/task_add.png" alt="Task Add" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/task_management/raw/main/assets/screenshots/light/task_control.png" alt="Task Control" width="220" style="margin: 10px;"/>
</p>
<p align="center">
  <img src="https://github.com/NaderEmad9/task_management/raw/main/assets/screenshots/light/task_list_view.png" alt="Task List View" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/task_management/raw/main/assets/screenshots/light/settings.png" alt="Settings" width="220" style="margin: 10px;"/>
  
</p>

### Dark Mode

<p align="center">
  <img src="https://github.com/NaderEmad9/task_management/raw/main/assets/screenshots/dark/splash_dark.png" alt="Splash Dark" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/task_management/raw/main/assets/screenshots/dark/signup_dark.png" alt="Sign Up Dark" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/task_management/raw/main/assets/screenshots/dark/signin_dark.png" alt="Sign In Dark" width="220" style="margin: 10px;"/>
</p>
<p align="center">
  <img src="https://github.com/NaderEmad9/task_management/raw/main/assets/screenshots/dark/task_dark.png" alt="Task Dark" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/task_management/raw/main/assets/screenshots/dark/task_add_dark.png" alt="Task Add Dark" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/task_management/raw/main/assets/screenshots/dark/task_control_dark.png" alt="Task Control Dark" width="220" style="margin: 10px;"/>
</p>
<p align="center">
  <img src="https://github.com/NaderEmad9/task_management/raw/main/assets/screenshots/dark/task_list_view_dark.png" alt="Task List View Dark" width="220" style="margin: 10px;"/>
  <img src="https://github.com/NaderEmad9/task_management/raw/main/assets/screenshots/dark/settings_dark.png" alt="Settings Dark" width="220" style="margin: 10px;"/>


</p>

---

## 🧪 Testing

Testing is an essential part of maintaining code quality and reliability.

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/unit/models/
```

### Test Structure

```
test/
├── unit/                   # Unit tests
│   ├── models/            # Model tests
│   └── providers/         # Provider tests
├── widget/                # Widget tests
│   └── screens/          # Screen widget tests
└── integration/           # Integration tests (coming soon)
```

| Type | Status |
|------|--------|
| Unit Tests | 🔜 Coming Soon |
| Widget Tests | 🔜 Coming Soon |
| Integration Tests | 🔜 Coming Soon |

---

## 🤝 Contributions

Feel free to fork this repository, open issues, and submit pull requests. Contributions are highly appreciated!

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## 👨‍💻 Author

**Nader Emad**
- GitHub: [@NaderEmad9](https://github.com/NaderEmad9)
- LinkedIn: [Nader Emad](https://linkedin.com/in/nader-emad)

---

<p align="center">Made with ❤️ using Flutter</p>
