# Flutter Firebase Post App

A modern Flutter application featuring user authentication, post creation, and profile management using Firebase Authentication and Cloud Firestore. The app leverages real-time updates with Streams for dynamic content rendering
## 📦 Features

* 🔐 **Authentication**

  * Sign Up (with email verification)
  * Login (email verification required)
  * Forgot Password
  * Logout

* 🏠 **Home Feed**

  * Display all user posts
  * Realtime updates from Firestore
  * Empty state handling

* 👤 **Profile**

  * View your posts only
  * Update profile picture and name
  * Realtime profile updates

* 📝 **Post**

  * Create post with content
  * Edit or delete your own posts
  * View others' posts in feed

## 📂 Folder Structure

```
lib/
├── core/
│   ├── extensions/
│   │   └── extensions.dart
│   ├── services/
│   │   └── toast_helper.dart
│   └── theme/
│       ├── light.dart
│       └── light_colors.dart
├── feature/
│   ├── auth/
│   │   ├── auth_controller.dart
│   │   ├── forgot_password_screen.dart
│   │   ├── login_screen.dart
│   │   └── signup_screen.dart
│   ├── home/
│   │   ├── components/
│   │   │   └── post_card.dart
│   │   ├── home_screen.dart
│   │   ├── post_model.dart
│   │   └── posts_controller.dart
│   └── profile/
│       ├── components/
│       │   ├── alert_dialog_change_user_data.dart
│       │   └── create_post.dart
│       ├── profile_screen.dart
│       ├── user_controller.dart
│       └── user_model.dart
├── firebase_options.dart
└── main.dart
```

## 🔧 Firebase Integration

* **Authentication:** Email & Password
* **Firestore:** Realtime database for `users` and `posts` collections

Here’s the updated `README.md` with all your screenshots organized into sections for better clarity and presentation:

---


## 📸 Screenshots

### 🔐 Authentication

| Sign Up                                                                                     | Error State                                                                                       | Sign In                                                                                     | Forgot Password                                                                                     |
| ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| ![Sign Up](https://github.com/user-attachments/assets/2dfd6222-2c17-4a40-a545-1c6eaecd0213) | ![Sign Up Error](https://github.com/user-attachments/assets/a6b841b0-2d75-4e37-9c24-1a9180e52ccf) | ![Sign In](https://github.com/user-attachments/assets/061f1399-9fc9-4aeb-a70c-fa6be0d21c2e) | ![Forgot Password](https://github.com/user-attachments/assets/f7550f10-411e-48a3-bccb-2c89aff604c5) |

---

### 🏠 Home Feed

| Empty State                                                                                    | With Posts                                                                                    |
| ---------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| ![Empty Home](https://github.com/user-attachments/assets/976e4369-e0ef-48fd-be90-f13cf8d544cf) | ![Home Feed](https://github.com/user-attachments/assets/dee01525-238b-4a3f-88de-73b80eb99cad) |

---

### 👤 Profile

| Empty Profile                                                                                     | Active Profile                                                                              |
| ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| ![Empty Profile](https://github.com/user-attachments/assets/1e79b801-82ef-42de-bd13-56807cc0f8bb) | ![Profile](https://github.com/user-attachments/assets/854cd5bb-fa73-40b0-94af-6536d81d98ba) |

---

### ➕ Create Post

| Add Post                                                                                     |
| -------------------------------------------------------------------------------------------- |
| ![Add Post](https://github.com/user-attachments/assets/2fc1d3e3-69e0-447e-8c5c-f706fa1e1580) |

---

## 