
# Parking App

Parking App is a Flutter application designed to manage parking reservations. This project demonstrates the use of Riverpod for state management, a backend for data handling, and Arduino for hardware integration. The app supports two types of users: Admin and Client.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Introduction

The Parking App is created to provide a convenient way for users to reserve parking slots. The primary focus of this project was to practice and implement:
- User roles (Admin and Client).
- Backend integration for data management.
- Arduino integration for hardware control.
- Payment functionality using points.

## Features

- **Admin and Client roles**: Different functionalities for admin and client users.
- **Backend Integration**: Manage data with a backend service.
- **Reservation System**: Users can reserve a parking slot, select the time, and pay with points.

## Technologies Used

- **Flutter**: The core framework for developing the app.
- **Riverpod**: Used for state management.
- **Backend**: Used for data storage and retrieval.
- **SocketIO**: Used for hardware integration.

## Installation

To get started with this project, follow these steps:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/AhmedNasserZakii/Parking-App.git
   ```

2. **Navigate to the project directory:**
   ```bash
   cd Parking-App
   ```

3. **Install dependencies:**
   ```bash
   flutter pub get
   ```

## Usage

1. **Run the application:**
   ```bash
   flutter run
   ```

2. **User Roles:**
   - **Admin**: Manage the parking slots, view reservations, and manage users.
   - **Client**: Reserve a parking slot, select the time, and pay with points.

## Project Structure

The project structure follows a modular approach, making it easier to manage and scale:

```css
lib/
├── backend/
├── models/
├── providers/
├── screens/
├── widgets/
├── main.dart
```
- **arduino/**: Contains Arduino-related files.
- **backend/**: Contains backend service files.
- **models/**: Contains data models.
- **providers/**: Contains Riverpod providers.
- **screens/**: Contains UI screens.
- **widgets/**: Contains reusable widgets.

## Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are greatly appreciated.

1. **Fork the Project**
2. **Create your Feature Branch (`git checkout -b feature/AmazingFeature`)**
3. **Commit your Changes (`git commit -m 'Add some AmazingFeature'`)**
4. **Push to the Branch (`git push origin feature/AmazingFeature`)**
5. **Open a Pull Request**

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Contact

Ahmed Nasser Zakii - ahmednasserzakii@outlook.com - [LinkedIn](https://linkedin.com/in/ahmednasserzakii)

Project Link: [https://github.com/AhmedNasserZakii/Parking-App](https://github.com/AhmedNasserZakii/Parking-App)
