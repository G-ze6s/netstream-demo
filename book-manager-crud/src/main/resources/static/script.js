const apiUrl = "/api/books";

const bookForm = document.getElementById("bookForm");
const bookIdInput = document.getElementById("bookId");
const titleInput = document.getElementById("title");
const authorInput = document.getElementById("author");
const genreInput = document.getElementById("genre");
const priceInput = document.getElementById("price");
const availableCopiesInput = document.getElementById("availableCopies");
const searchInput = document.getElementById("searchInput");
const bookList = document.getElementById("bookList");
const alertBox = document.getElementById("alertBox");
const formTitle = document.getElementById("formTitle");
const submitButton = document.getElementById("submitButton");
const clearButton = document.getElementById("clearButton");

let books = [];

document.addEventListener("DOMContentLoaded", () => {
    fetchBooks();
});

bookForm.addEventListener("submit", async (event) => {
    event.preventDefault();

    const bookData = {
        title: titleInput.value.trim(),
        author: authorInput.value.trim(),
        genre: genreInput.value.trim(),
        price: Number(priceInput.value),
        availableCopies: Number(availableCopiesInput.value)
    };

    const bookId = bookIdInput.value;
    const requestMethod = bookId ? "PUT" : "POST";
    const requestUrl = bookId ? `${apiUrl}/${bookId}` : apiUrl;

    try {
        const response = await fetch(requestUrl, {
            method: requestMethod,
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(bookData)
        });

        const responseData = await response.json().catch(() => ({}));

        if (!response.ok) {
            throw new Error(responseData.message || "Unable to save book");
        }

        showAlert(bookId ? "Book updated successfully." : "Book added successfully.", "success");
        clearForm();
        fetchBooks();
    } catch (error) {
        showAlert(error.message, "error");
    }
});

clearButton.addEventListener("click", () => {
    clearForm();
    showAlert("Form cleared.", "success");
});

searchInput.addEventListener("input", () => {
    renderBooks(searchInput.value);
});

async function fetchBooks() {
    try {
        const response = await fetch(apiUrl);
        const responseData = await response.json().catch(() => []);

        if (!response.ok) {
            throw new Error(responseData.message || "Unable to load books");
        }

        books = responseData;
        renderBooks(searchInput.value);
    } catch (error) {
        showAlert(error.message, "error");
        bookList.innerHTML = `<div class="empty-state">Could not load books.</div>`;
    }
}

function renderBooks(searchText = "") {
    const query = searchText.trim().toLowerCase();
    const filteredBooks = books.filter((book) =>
        book.title.toLowerCase().includes(query) ||
        book.author.toLowerCase().includes(query) ||
        book.genre.toLowerCase().includes(query)
    );

    if (filteredBooks.length === 0) {
        bookList.innerHTML = `<div class="empty-state">No books found. Add a book to get started.</div>`;
        return;
    }

    bookList.innerHTML = filteredBooks.map((book) => `
        <article class="book-card">
            <h3>${escapeHtml(book.title)}</h3>
            <div class="book-meta">
                <span><strong>Author:</strong> ${escapeHtml(book.author)}</span>
                <span><strong>Genre:</strong> ${escapeHtml(book.genre)}</span>
                <span><strong>Price:</strong> Rs. ${Number(book.price).toFixed(2)}</span>
                <span><strong>Copies:</strong> ${book.availableCopies}</span>
            </div>
            <div class="action-row">
                <button class="edit-btn" onclick="editBook(${book.id})">Edit</button>
                <button class="delete-btn" onclick="deleteBook(${book.id})">Delete</button>
            </div>
        </article>
    `).join("");
}

function editBook(id) {
    const book = books.find((item) => item.id === id);

    if (!book) {
        showAlert("Book not found.", "error");
        return;
    }

    bookIdInput.value = book.id;
    titleInput.value = book.title;
    authorInput.value = book.author;
    genreInput.value = book.genre;
    priceInput.value = book.price;
    availableCopiesInput.value = book.availableCopies;
    formTitle.textContent = "Update Book";
    submitButton.textContent = "Update Book";
    window.scrollTo({ top: 0, behavior: "smooth" });
}

async function deleteBook(id) {
    const confirmed = window.confirm("Are you sure you want to delete this book?");

    if (!confirmed) {
        return;
    }

    try {
        const response = await fetch(`${apiUrl}/${id}`, {
            method: "DELETE"
        });

        const responseData = await response.json().catch(() => ({}));

        if (!response.ok) {
            throw new Error(responseData.message || "Unable to delete book");
        }

        showAlert("Book deleted successfully.", "success");
        if (bookIdInput.value === String(id)) {
            clearForm();
        }
        fetchBooks();
    } catch (error) {
        showAlert(error.message, "error");
    }
}

function clearForm() {
    bookForm.reset();
    bookIdInput.value = "";
    formTitle.textContent = "Add New Book";
    submitButton.textContent = "Save Book";
}

function showAlert(message, type) {
    alertBox.textContent = message;
    alertBox.className = `alert ${type}`;
    alertBox.classList.remove("hidden");

    setTimeout(() => {
        alertBox.classList.add("hidden");
    }, 3000);
}

function escapeHtml(value) {
    return String(value)
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}
