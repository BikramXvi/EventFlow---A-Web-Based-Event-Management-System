# EventFlow — Event Management System

A full-stack web-based event management platform built with Java EE, Jakarta Servlets, JSP, and MySQL.

---

## Tech Stack

- **Backend:** Java EE, Jakarta Servlets, JSP, JSTL
- **Server:** Apache Tomcat 10.1.x
- **Database:** MySQL 8.x
- **Build Tool:** Apache Maven
- **Security:** jBCrypt password hashing
- **IDE:** Eclipse IDE for Enterprise Java Developers

---

## Prerequisites

Make sure you have the following installed before running the project:

- Java JDK 17 or higher
- Apache Tomcat 10.1.x
- MySQL 8.x
- Eclipse IDE for Enterprise Java Developers (recommended)
- Maven 3.x

---

## Database Setup

1. Open MySQL Workbench or any MySQL client
2. Create the database:
   ```sql
   CREATE DATABASE event_management_db;
   ```
3. Select the database:
   ```sql
   USE event_management_db;
   ```
4. Import the schema and seed data:
   ```
   Run the file: database/schema.sql
   ```
   This will create all 9 tables and insert sample data including test user accounts.

---

## Project Setup

### Clone the Repository

```bash
git clone https://github.com/BikramXvi/EventFlow---A-Web-Based-Event-Management-System.git
```

### Configure Database Connection

Open the file:
```
src/main/java/com/eventflow/config/DBConfig.java
```

Update the connection details to match your local MySQL setup:

```java
private static final String URL  = "jdbc:mysql://localhost:3306/event_management_db";
private static final String USER = "root";         // your MySQL username
private static final String PASS = "yourpassword"; // your MySQL password
```

### Import into Eclipse

1. Open Eclipse → **File → Import → Existing Maven Projects**
2. Browse to the cloned project folder
3. Click **Finish**
4. Right-click the project → **Maven → Update Project**

### Configure Tomcat in Eclipse

1. Go to **Window → Show View → Servers**
2. Right-click in the Servers panel → **New → Server**
3. Select **Apache Tomcat 10.1** and point it to your Tomcat installation folder
4. Right-click the server → **Add and Remove** → add **EventFlow**
5. Double-click the server → set the port to **8090**

### Run the Project

1. Right-click the project → **Run As → Run on Server**
2. Select your configured Tomcat server
3. Click **Finish**

The application will be available at:
```
http://localhost:8090/EventFlow
```

---

## Default Login Credentials

Use these accounts to test the application:

| Role      | Email                    | Password   |
|-----------|--------------------------|------------|
| Admin     | admin@eventflow.com       | Admin@123   |
| Attendee  | central@gmail.com   | Admin@123    |
| Volunteer | bob@gmail.com   | Admin@123    |
| Vendor    | vendor@gmail.com      | Admin@123    |

> Passwords are BCrypt hashed in the database. Do not edit them directly — use the login form.

---

## Project Structure

```
EventFlow/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/eventflow/
│       │       ├── config/          # DBConfig.java
│       │       ├── controllers/     # All Servlet classes (19 servlets)
│       │       ├── filters/         # AuthFilter.java
│       │       ├── model/           # Data access classes (6 models)
│       │       └── util/            # GenerateHash.java
│       └── webapp/
│           ├── css/                 # style.css, landing.css
│           ├── js/                  # landing.js
│           ├── images/              # Static assets
│           ├── uploads/events/      # Uploaded event images
│           └── WEB-INF/
│               ├── pages/
│               │   ├── admin/       # Admin JSP pages
│               │   ├── attendee/    # Attendee JSP pages
│               │   ├── volunteer/   # Volunteer JSP pages
│               │   ├── vendor/      # Vendor JSP pages
│               │   ├── landing/     # Public landing page
│               │   └── shared/      # Login, register JSPs
│               └── web.xml
├── database/
│   └── event_management_db.sql                   # Full DB schema + seed data
├── pom.xml
└── README.md
```

---

## Features

### Public
- Landing page with event highlights, FAQ, contact form
- Browse all upcoming events without login
- Search and filter events by status and date

### Admin
- Create, edit, and delete events (with image upload)
- Manage all user accounts (activate/deactivate, lock/unlock)
- Assign volunteers to events
- Review and approve or reject vendor applications

### Attendee
- Browse and register for events
- View and cancel registrations
- Update profile information

### Volunteer
- View assigned events and tasks
- Update profile information

### Vendor
- Browse available events and submit applications with service descriptions
- Track application status (pending, approved, rejected)
- Update profile information

---

## Security

- Passwords hashed with BCrypt (jBCrypt)
- Session-based authentication with 30-minute timeout
- Account lockout after 5 failed login attempts in 15 minutes
- Role-based access control enforced on every request via AuthFilter
- Prepared statements used throughout to prevent SQL injection

---

## Notes

- Tomcat runs on port **8090** by default — change this in the server configuration if needed
- Event images are stored in `src/main/webapp/uploads/events/`
- If images are not loading, ensure `/EventFlow/uploads/` is in the AuthFilter public paths
- The context path is `/EventFlow` — all internal links use this prefix

---

## Module

**CS5003NI — Data Structures and Specialist Programming**
Islington College | London Metropolitan University
