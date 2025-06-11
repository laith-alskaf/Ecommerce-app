# E-Commerce Application - Thawbuk

A comprehensive e-commerce application built with Flutter, implementing strict **Clean Architecture** principles to ensure maintainability and scalability. The app provides separate interfaces for customers and administrators with rich feature sets for each role.

<p align="center">
  <img src="assets/app_logo.png" width="200" alt="App Logo">
</p>

---

## 📸 App Screenshots
<p align="center">
  <img src="screenshots/login.png" width="200" alt="Login Screen">
  <img src="screenshots/home.png" width="200" alt="Home Screen">
  <img src="screenshots/product_details.png" width="200" alt="Product Details">
  <img src="screenshots/admin_dashboard.png" width="200" alt="Admin Dashboard">
</p>

---

## ✨ Key Features
### 👤 For Users (Customers)
- **Authentication System**: Register new account, login, logout
- **Password Recovery**: Reset password via email
- **Product Browsing**: View all products with pagination support
- **Category Filtering**: Filter products by category
- **Product Search**: Find specific products by name
- **Product Details**: Dedicated page with images, description, price, and ratings
- **Wishlist Management**: Add/remove products from wishlist (requires login)
- **Profile Management**: View and edit profile information
- **Password Change**: Change password from profile
- **Guest Experience**: Browse products and categories without login

### 🛠️ For Administrators
- **Dashboard**: Store overview with statistics (e.g., total products)
- **Product Management**:
  - View all products
  - Add new products with images and details (name, price, quantity, category)
  - Delete products
- **Role System**: Custom interfaces and privileges for "Admin" role

### 🚀 General & Technical Features
- **Push Notifications**: Firebase Cloud Messaging for new product alerts
- **Multi-language Support**: Arabic and English localization
- **Network Handling**: Detects internet connection status and shows appropriate messages
- **Responsive Design**: Adapts to different screen sizes using flutter_screenutil

---

## 🏛️ Architecture Overview
The project follows Clean Architecture principles to ensure separation of concerns and make the code testable and scalable.

<p align="center">
  <img src="assets/architecture_diagram.png" width="500" alt="Clean Architecture Diagram">
</p>

### Three Main Layers:
1. **Domain Layer** (Core Business Logic):
   - Entities (ProductEntity, UserEntity)
   - Use Cases (GetAllProductsUseCase, LoginUseCase)
   - Repository Abstracts

2. **Data Layer** (Data Sources):
   - Repository Implementations
   - Data Sources (API using http/dio, Local using shared_preferences)
   - Models (ProductModel)

3. **Presentation Layer** (UI):
   - Views/Pages
   - State Management (BLoC/Cubit with flutter_bloc)
   - Dependency Injection (get_it)
  


## 🛠️ Technologies & Libraries
---
| Category               | Libraries/Packages                          |
|------------------------|---------------------------------------------|
| State Management       | flutter_bloc, get                           |
| Dependency Injection   | get_it                                      |
| Routing                | get                                         |
| Networking             | http                                        |
| Asynchronous Operations| dartz                                       |
| Local Storage          | shared_preferences                          |
| UI Components          | flutter_screenutil, awesome_bottom_bar, cached_network_image |
| Notifications          | firebase_messaging, awesome_notifications   |
| Utilities              | equatable, permission_handler, image_picker |
---

## 🏗️ Project Structure

```text
lib/
├── 📂 app/               # Main application configuration
│   ├── dependency_injection.dart
│   └── app_widget.dart
│
├── 📂 core/              # Shared framework components
│   ├── 📁 data/          # Core data models
│   ├── 📁 enums/         # Application enums
│   ├── 📁 error/         # Error handling
│   ├── 📁 network/       # Network layer
│   ├── 📁 params/        # Request/response params
│   ├── 📁 services/      # Utility services
│   └── 📁 utils/         # Helper functions
│
├── 📂 data/              # Data layer implementation
│   ├── 📁 datasources/   # Data providers
│   │   ├── local/        # Local storage
│   │   └── remote/       # API clients
│   ├── 📁 models/        # DTOs and adapters
│   └── 📁 repositories/  # Concrete repositories
│
├── 📂 domain/            # Business logic
│   ├── 📁 entities/      # Business objects
│   ├── 📁 repositories/  # Abstract contracts
│   └── 📁 usecases/      # Application logic
│
├── 📂 presentation/      # UI layer
│   ├── 📁 controllers/   # Business logic (BLoC/Cubit)
│   ├── 📁 views/        # Screen widgets
│   ├── 📁 widgets/      # Reusable components
│   └── 📁 theme/        # App styling
│
└── 📄 main.dart          # Application entry point
```
## 📧 Contact

**Laith Alskaf** - laithalskaf@gmail.com
**Project Link**: https://github.com/laith-alskaf/ecommerce-app
