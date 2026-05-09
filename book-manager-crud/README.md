# Book Manager CRUD Project

This is a separate full stack CRUD project built with:

- Spring Boot
- Maven
- Spring Data JPA
- MySQL
- HTML, CSS, JavaScript

## Project Structure

```text
book-manager-crud/
├── pom.xml
├── README.md
└── src/
    └── main/
        ├── java/
        │   └── com/example/bookmanager/
        │       ├── BookManagerCrudApplication.java
        │       ├── controller/BookController.java
        │       ├── entity/Book.java
        │       ├── exception/GlobalExceptionHandler.java
        │       ├── repository/BookRepository.java
        │       └── service/BookService.java
        └── resources/
            ├── application.properties
            └── static/
                ├── index.html
                ├── script.js
                └── style.css
```

## Database Setup

1. Install MySQL and make sure it is running.
2. Open `src/main/resources/application.properties`.
3. Update the username and password:

```properties
spring.datasource.username=root
spring.datasource.password=your_mysql_password
```

4. The database `book_manager_db` will be created automatically if it does not exist.
5. The `books` table will be created automatically because `spring.jpa.hibernate.ddl-auto=update` is enabled.

## Run In VS Code

1. Open the `book-manager-crud` folder in VS Code.
2. Make sure Java Extension Pack and Maven are installed.
3. Open a terminal in that folder.
4. Run:

```bash
mvn spring-boot:run
```

5. Open your browser and go to:

```text
http://localhost:8080
```

## API Endpoints

- `POST /api/books`
- `GET /api/books`
- `GET /api/books/{id}`
- `PUT /api/books/{id}`
- `DELETE /api/books/{id}`
