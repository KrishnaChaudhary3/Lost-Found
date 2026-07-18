# Lost & Found Application

## Overview

The Lost & Found Application is a full-stack mobile application designed to simplify the process of reporting, searching, and recovering lost items within a campus environment. The platform enables users to report lost or found items, upload images, communicate with other users, and manage item reports through a secure and user-friendly interface.

The project was developed using Flutter for the frontend, Node.js and Express.js for the backend, and MongoDB as the database.

---

## Features

- User registration and authentication using JWT
- Secure password encryption with bcrypt
- Report lost items
- Report found items
- Search and browse reported items
- Upload item images
- View detailed information for each item
- User profile management
- In-app messaging between users
- Report management system
- RESTful API architecture

---

## Technology Stack

### Frontend
- Flutter
- Dart

### Backend
- Node.js
- Express.js

### Database
- MongoDB


### Authentication
- JSON Web Token (JWT)
- bcrypt.js
---

## Project Structure

```
lost-and-found-app/
│
├── frontend/
│   ├── lib/
│   ├── assets/
│   └── pubspec.yaml
│
├── backend/
│   ├── controllers/
│   ├── middleware/
│   ├── models/
│   ├── routes/
│   ├── uploads/
│   ├── server.js
│   └── package.json
│
└── README.md
```

---

## Installation

### Clone the repository

```bash
git clone https://github.com/your-username/lost-and-found-app.git
```

### Backend Setup

```bash
cd backend
npm install
npm start
```

### Frontend Setup

```bash
cd frontend
flutter pub get
flutter run
```

---

## API Modules

- Authentication
- Users
- Items
- Reports
- Messages
- File Uploads

---

## Security

- Password hashing using bcrypt
- JWT-based authentication
- Protected API routes
- Environment variable configuration

---

## Future Enhancements

- Push notifications
- Email verification
- Password reset
- Google Sign-In
- Admin dashboard
- Advanced search filters
- AI-based item matching
- Cloud image storage

---

## Screenshots

Screenshots of the application interface can be found below.

**login Page**
<img width="378" height="689" alt="Screenshot 2026-07-05 120737" src="https://github.com/user-attachments/assets/7b232cc3-cfce-4aa4-b208-86ac3a3f38dc" />

**Home Page**
<img width="365" height="698" alt="Screenshot 2026-07-05 120442" src="https://github.com/user-attachments/assets/684e659c-fde3-49ee-8155-17f965885360" />

**Report Item**
<img width="338" height="686" alt="Screenshot 2026-07-05 115716" src="https://github.com/user-attachments/assets/a7d2c342-f7fe-4d3e-b95d-d95bd8f7dd66" />

**Profile Page**
<img width="351" height="688" alt="Screenshot 2026-07-05 120917" src="https://github.com/user-attachments/assets/4c9ed00c-e021-479d-b5d3-83aa71940e5a" />

**Search Page**
<img width="351" height="688" alt="Screenshot 2026-07-05 120917" src="https://github.com/user-attachments/assets/8f76a2e7-ed06-40de-b838-9f93b4756352" />

**Settings**
<img width="342" height="685" alt="Screenshot 2026-07-05 120943" src="https://github.com/user-attachments/assets/7c89cf3b-5a2a-4798-9903-b4f13d8490b5" />







---

## Project Highlights

- Built using a modern full-stack architecture.
- Implements RESTful API design principles.
- Secure authentication and authorization.
- Image upload support.
- Modular backend architecture following MVC principles.
- Designed to improve the efficiency of lost-and-found management within educational institutions.

---

## Developer

**Krishna Kumari**

Computer Science Undergraduate  
GLA University

GitHub: https://github.com/KrishnaChaudhary3

LinkedIn: www.linkedin.com/in/krishna-kumari-97629027b
--

## License

This project is intended for educational and portfolio purposes.
