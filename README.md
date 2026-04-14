
# 📱 Flutter Task Manager App

A scalable Flutter application built using **Clean Architecture + BLoC + Firebase**, implementing **User Authentication** and **Task Management (CRUD)**.

---

## 🚀 Features

### 🔐 Authentication

* Email & Password Sign Up
* Login / Logout
* Persistent Session (Auto-login)
* Error handling & loading states

### 📋 Task Management

* Create Task
* Read Tasks (Real-time updates)
* Update Task (toggle complete)
* Delete Task
* User-specific tasks

---

## 🏗️ Architecture

This project follows **Clean Architecture** with feature-based structure:

```
lib/
├── core/
│   ├── di/               # Dependency Injection (GetIt)
│         
│
├── features/
│   ├── auth/
│   │   ├── data/         # Firebase implementation
│   │   ├── domain/       # Business logic
│   │   ├── presentation/ # UI + BLoC
│   │
│   ├── tasks/
│       ├── data/
│       ├── domain/
│       ├── presentation/
│
├── shared/
```

---

## 🧠 Architecture Explanation

### 1. Presentation Layer

* Uses **BLoC** for state management
* Handles UI & user interactions
* No direct backend calls

### 2. Domain Layer

* Contains:

  * Entities
  * Repository interfaces
  * Use cases
* Pure business logic (independent of framework)

### 3. Data Layer

* Implements repositories
* Handles Firebase API calls
* Converts models ↔ entities

---

## 🔥 State Management

* Implemented using **flutter_bloc**
* Event-driven architecture
* Predictable state transitions

---

## ☁️ Backend Choice: Firebase

### Why Firebase?

* ✅ Fast setup & easy integration
* ✅ Built-in Authentication
* ✅ Real-time database (Firestore)
* ✅ Scalable & production-ready
* ✅ No server management required

---

## 🗄️ Database Structure

### Collection: `tasks`

| Field        | Type      |
| ------------ | --------- |
| title        | String    |
| description  | String    |
| is_completed | Boolean   |
| created_at   | Timestamp |
| user_id      | String    |

---

## ⚙️ Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/flutter-task-app.git
cd flutter-task-app
```

---

### 2. Install Dependencies

```bash
flutter pub get
```

---

### 3. Firebase Setup

1. Go to Firebase Console
2. Create a new project
3. Enable:

   * Authentication → Email/Password
   * Firestore Database

---

### 4. Add App to Firebase

#### Android:

* Add package name
* Download `google-services.json`
* Place inside:

```
android/app/
```

#### iOS (optional):

* Add `GoogleService-Info.plist`

---

### 5. Run App

```bash
flutter run
```

---

## 🔐 Firestore Rules (IMPORTANT)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /tasks/{taskId} {
      allow read, write: if request.auth != null 
        && request.auth.uid == resource.data.user_id;
    }
  }
}
```

---

## 👨‍💻 Author

**Arvind Kumar Gupta**
Flutter Developer

---

## ⭐ Notes

* Clean Architecture followed strictly
* No direct backend calls in UI
* Scalable & maintainable code
* Ready for production expansion

---

