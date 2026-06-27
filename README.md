# 🎬 NETSTREAM OTT Platform

A full-stack **Online OTT (Over-The-Top) Streaming Platform** developed using **JSP, Java Servlets, PHP, AJAX, XML, MySQL, HTML, CSS, and JavaScript**. The project demonstrates major Web Technology concepts including user authentication, content management, session tracking, cookies, XML configuration, payment processing, and an offline chatbot.

---

## 📌 Project Overview

NETSTREAM OTT Platform is a demonstration streaming portal built on **Apache Tomcat** with **JSP pages** and **Java Servlets**, supported by **PHP APIs** and **MySQL** running on **XAMPP**. The application allows users to register, log in, browse streaming content, manage subscriptions, perform mock payments, and interact with an offline chatbot.

This project was developed as part of a **Web Technologies Laboratory** to demonstrate the practical implementation of JSP, Servlets, XML, PHP, AJAX, Cookies, Sessions, and Database Connectivity.

---

## 🚀 Features

* User Registration and Login
* OTT Dashboard with Movies & Web Series
* Content Management (CRUD)
* Cookie Handling
* Session Tracking
* Subscription Management
* AJAX-based Payment Module
* Offline FAQ Chatbot
* XML-based Configuration
* MySQL Database Integration
* Admin Access Control

---

# 🛠️ Technology Stack

| Category        | Technologies                                    |
| --------------- | ----------------------------------------------- |
| Frontend        | HTML5, CSS3, JavaScript, AJAX, JSP              |
| Backend         | Java Servlets, PHP                              |
| Database        | MySQL (XAMPP/phpMyAdmin)                        |
| Server          | Apache Tomcat 10.1                              |
| Configuration   | XML (web.xml, ott-config.xml, support-info.xml) |
| IDE             | Visual Studio Code / Eclipse                    |
| Version Control | Git & GitHub                                    |

---

# 📂 Project Structure

```
NETSTREAM-OTT/
│
├── index.jsp
├── login.jsp
├── register.jsp
├── home.jsp
├── contentManagement.jsp
├── chatbot.jsp
├── payment.html
│
├── js/
│   ├── login.js
│   ├── register.js
│   └── payment.js
│
├── css/
│   └── style.css
│
├── php/
│   ├── create_payment.php
│   ├── confirm_payment.php
│   └── payments.php
│
├── servlet/
│   ├── LoginServlet.java
│   ├── SubscriptionServlet.java
│   ├── CookiesServlet.java
│   └── SessionTrackingServlet.java
│
├── xml/
│   ├── ott-config.xml
│   ├── support-info.xml
│   └── subscriptions-data.xml
│
├── database/
│   └── netstream.sql
│
└── README.md
```

---

# 📚 Project Modules

## 1. Login Module

Authenticates users before accessing the platform.

### Features

* User Login
* Credential Validation
* Session Creation
* Redirect to Dashboard

**Files**

```
login.jsp
login.js
```

---

## 2. Registration Module

Allows new users to create an account.

### Features

* User Registration
* Form Validation
* New Account Creation

**Files**

```
register.jsp
register.js
```

---

## 3. Dashboard Module

Displays the main OTT interface after successful login.

### Features

* Movie Listings
* Web Series Listings
* Navigation Menu
* Access to Platform Modules

**File**

```
home.jsp
```

---

## 4. Content Management Module

Admin module used to manage OTT content.

### Features

* Add Content
* View Content
* Update Content
* Delete Content

**Files**

```
contentManagement.jsp
PHP APIs
MySQL
```

---

## 5. Cookies Module

Demonstrates browser cookie handling.

### Features

* Store Visit Count
* Display User Visits

**Files**

```
CookiesServlet.java
web.xml
```

---

## 6. Session Tracking Module

Tracks active user sessions.

### Features

* Session Creation Time
* First Visit
* Last Access Time
* Session ID

**Files**

```
SessionTrackingServlet.java
web.xml
```

---

## 7. Subscription Module

Allows users to subscribe to OTT plans.

### Plans

* Basic
* Standard
* Premium

### Features

* Add Subscription
* Update Subscription
* Delete Subscription
* View Subscription

**Files**

```
SubscriptionServlet.java
ott-config.xml
subscriptions-data.xml
```

---

## 8. Payment Module

Processes subscription payments.

### Payment Methods

* UPI
* Credit/Debit Card
* Net Banking

### Technologies Used

* AJAX
* PHP
* MySQL

**Files**

```
payment.html
create_payment.php
confirm_payment.php
payments.php
```

---

## 9. Offline Chatbot Module

Provides user assistance using predefined FAQ responses.

### Features

* Login Help
* Payment Help
* Subscription Help
* General Queries

**Files**

```
chatbot.jsp
chatbot-faq.json
support-info.xml
```

---

## 10. XML Configuration Module

Stores application configuration in XML.

### Contains

* Subscription Plans
* User Roles
* Payment Methods
* Chatbot Topics
* Module Paths

**Files**

```
ott-config.xml
support-info.xml
```

---

## 11. Database Module

Stores all application data permanently.

### Database Tables

* users
* content_items
* payments
* subscriptions

---

## 12. Admin Module

Provides administrator-only functionality.

### Features

* Content Management
* Cookie Demonstration
* Session Tracking
* Restricted Page Access

---

# ⚙️ Installation

## Prerequisites

* Java JDK 17 or later
* Apache Tomcat 10.1
* XAMPP
* MySQL
* Visual Studio Code or Eclipse

---

## Setup Steps

1. Clone the repository.

```bash
git clone https://github.com/your-username/NETSTREAM-OTT.git
```

2. Import the project into Apache Tomcat.

3. Start Apache Tomcat Server.

4. Start Apache and MySQL using XAMPP.

5. Import the SQL database into phpMyAdmin.

6. Update database connection details if required.

7. Open your browser.

```
http://localhost:8080/NETSTREAM-OTT/
```

---

# 📷 Sample Workflow

```
User Registration
        ↓
Login
        ↓
Dashboard
        ↓
Browse Movies/Web Series
        ↓
Subscription
        ↓
Payment
        ↓
Watch Content
```

