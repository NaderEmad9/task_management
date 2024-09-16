# Task Management App

This **Task Management App** is a Flutter application designed to help users efficiently manage their tasks. The app allows users to add, edit, delete, and complete tasks with a clean and user-friendly interface.

## Features

- **Add Tasks**: Create new tasks with titles, descriptions, and due dates.
- **Edit Tasks**: Modify existing tasks for corrections or updates.
- **Task Completion**: Mark tasks as completed with a simple swipe action.
- **Delete Tasks**: Remove tasks from the list by swiping.
- **Responsive UI**: Ensures that the layout adapts to different screen sizes and orientations.
- **Dark Mode**: Support for both light and dark themes based on user preferences.
- **Firebase Integration**: Sync tasks in real-time across devices using Firebase.

## Technologies Used

- **Flutter**: A cross-platform framework to build the app for both Android and iOS.
- **Firebase**: For real-time data syncing and authentication.
- **Provider**: State management for handling app-wide changes efficiently.
- **Google Fonts**: To enhance the visual styling of text elements.
- **Dart**: The programming language used in Flutter for app development.

## Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- [Flutter](https://flutter.dev/docs/get-started/install) (version 3.0 or later)
- [Dart](https://dart.dev/get-dart)
- Firebase project set up (for backend and data syncing)

### Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/task-management-app.git
   ```

2. **Navigate to the Project Directory**

   ```bash
   cd task-management-app
   ```

3. **Install Dependencies**

   Run the following command to fetch the required packages:

   ```bash
   flutter pub get
   ```

4. **Firebase Setup**

   - Set up Firebase for your project:
     - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/).
     - Follow the instructions to add both Android and iOS Firebase configurations.
     - Replace `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) in the respective directories, or just use flutter   integration provided by Firebase.

5. **Run the Application**

   To run the application on your preferred device, use:

   ```bash
   flutter run
   ```


## Screenshots

### Light Mode

<div style="display: flex; justify-content: space-around;">
  <img src="https://github.com/user-attachments/assets/screenshots/light/signup.png" alt="Task List" width="300"/>
  <img src="https://github.com/user-attachments/assets/screenshots/light/signin.png" alt="Task List" width="300"/>
  <img src="https://github.com/user-attachments/assets/screenshots/light/task.png" alt="Task List" width="300"/>
  <img src="https://github.com/user-attachments/assets/screenshots/light/task_add.png" alt="Task List" width="300"/>
  <img src="https://github.com/user-attachments/assets/screenshots/light/task_list_view.png" alt="Task List" width="300"/>
  <img src="https://github.com/user-attachments/assets/screenshots/light/task_control.png" alt="Task List" width="300"/>
  <img src="https://github.com/user-attachments/assets/screenshots/light/settings.png" alt="Task List" width="300"/>
</div>

### Dark Mode

<div style="display: flex; justify-content: space-around;">
  <img src="https://github.com/user-attachments/assets/screenshots/dark/signup_dark.png" alt="Task List" width="300"/>
  <img src="https://github.com/user-attachments/assets/screenshots/dark/signin_dark.png" alt="Task List" width="300"/>
  <img src="https://github.com/user-attachments/assets/screenshots/dark/task_dark.png" alt="Task List" width="300"/>
  <img src="https://github.com/user-attachments/assets/screenshots/dark/task_add_dark.png" alt="Task List" width="300"/>
  <img src="https://github.com/user-attachments/assets/screenshots/dark/task_list_view_dark.png" alt="Task List" width="300"/>
  <img src="https://github.com/user-attachments/assets/screenshots/dark/task_control_dark.png" alt="Task List" width="300"/>
  <img src="https://github.com/user-attachments/assets/screenshots/dark/settings_dark.png" alt="Task List" width="300"/>
</div>

## Contributions

Feel free to fork this repository, open issues, and submit pull requests. Contributions are highly appreciated!
