<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    if (!"admin".equals(user)) {
        response.sendRedirect("home.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Content Management</title>
    <style>
        :root {
            --bg-main: #141414;
            --bg-panel: #1f1f1f;
            --line: #353535;
            --text-main: #f5f5f5;
            --text-soft: #b7b7b7;
            --red: #e50914;
            --red-dark: #b20710;
            --ok: #7bf1b2;
            --gold: #f9c74f;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; font-family: "Segoe UI", Arial, sans-serif; }
        body {
            background:
                linear-gradient(180deg, rgba(0, 0, 0, 0.75), rgba(20, 20, 20, 1)),
                radial-gradient(circle at top left, rgba(229, 9, 20, 0.15), transparent 45%),
                radial-gradient(circle at top right, rgba(249, 199, 79, 0.1), transparent 32%),
                var(--bg-main);
            color: var(--text-main);
            padding: 18px;
            min-height: 100vh;
        }
        .wrap { max-width: 1120px; margin: 0 auto; }
        .hero {
            background: linear-gradient(120deg, rgba(229, 9, 20, 0.18), rgba(249, 199, 79, 0.08));
            border: 1px solid var(--line);
            border-radius: 16px;
            padding: 18px;
            margin-bottom: 14px;
        }
        .hero-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
        }
        .title-line {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .icon-badge {
            width: 38px;
            height: 38px;
            border-radius: 12px;
            background: linear-gradient(120deg, var(--red), var(--gold));
            color: #161616;
            display: grid;
            place-items: center;
            font-weight: 800;
            font-size: 0.9rem;
        }
        .hero p {
            margin-top: 8px;
            color: var(--text-soft);
            line-height: 1.45;
        }
        .hero-tags {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 12px;
        }
        .hero-tags span {
            padding: 7px 10px;
            border-radius: 999px;
            background: rgba(255,255,255,0.04);
            border: 1px solid rgba(255,255,255,0.08);
            color: #eceff6;
            font-size: 0.83rem;
        }
        .back {
            text-decoration: none;
            color: #fff;
            background: #262626;
            border: 1px solid var(--line);
            border-radius: 8px;
            padding: 8px 11px;
        }
        .back:hover { background: #2f2f2f; }
        .panel {
            background: linear-gradient(180deg, #232323, #1a1a1a);
            border: 1px solid var(--line);
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 16px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.28);
        }
        .subhead {
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
        }
        .ghost-link {
            color: #9cc1ff;
            text-decoration: none;
            font-size: 0.88rem;
        }
        .ghost-link:hover {
            text-decoration: underline;
        }
        .msg {
            margin-bottom: 12px;
            border-radius: 8px;
            padding: 9px 11px;
            display: none;
        }
        .msg.success {
            color: var(--ok);
            background: rgba(123, 241, 178, 0.12);
            border: 1px solid rgba(123, 241, 178, 0.3);
        }
        .msg.error {
            color: #ffd5d9;
            background: rgba(229, 9, 20, 0.12);
            border: 1px solid rgba(229, 9, 20, 0.28);
        }
        .row {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr 1.4fr 1.5fr auto auto;
            gap: 10px;
        }
        input, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #4b4b4b;
            border-radius: 8px;
            background: #111;
            color: var(--text-main);
        }
        button {
            border: 0;
            border-radius: 8px;
            padding: 10px 14px;
            background: var(--red);
            color: #fff;
            cursor: pointer;
            font-weight: 700;
        }
        button:hover { background: var(--red-dark); }
        .secondary-btn {
            background: #2d2d2d;
            border: 1px solid #404040;
        }
        .secondary-btn:hover { background: #393939; }
        .details-grid {
            display: grid;
            grid-template-columns: 220px 1fr;
            gap: 18px;
            align-items: start;
        }
        .details-poster {
            width: 100%;
            height: 310px;
            object-fit: cover;
            border-radius: 12px;
            border: 1px solid #3a3a3a;
            background: #111;
        }
        .details-copy p {
            color: var(--text-soft);
            line-height: 1.5;
            margin-bottom: 10px;
        }
        .details-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin: 10px 0 12px;
        }
        .details-meta span {
            padding: 7px 10px;
            border-radius: 999px;
            background: rgba(255,255,255,0.04);
            border: 1px solid rgba(255,255,255,0.08);
            color: #eceff6;
            font-size: 0.83rem;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: linear-gradient(180deg, #232323, #1a1a1a);
            border: 1px solid var(--line);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.28);
        }
        thead { background: #2b2b2b; }
        th, td {
            text-align: left;
            padding: 10px;
            border-bottom: 1px solid #2f2f2f;
            vertical-align: top;
        }
        tbody tr:hover { background: #252525; }
        .tag {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 999px;
            font-size: 0.78rem;
            background: rgba(229, 9, 20, 0.18);
            border: 1px solid rgba(229, 9, 20, 0.42);
            color: #ffd9db;
        }
        .actions-cell {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }
        .table-link {
            text-decoration: none;
            color: #fff;
            padding: 7px 10px;
            border-radius: 8px;
            font-size: 0.82rem;
            border: 1px solid #404040;
            background: #242424;
            cursor: pointer;
        }
        .table-link.delete {
            background: rgba(229, 9, 20, 0.14);
            border-color: rgba(229, 9, 20, 0.38);
            color: #ffd5d9;
        }
        .empty {
            color: var(--text-soft);
            padding: 12px 0;
        }
        .note {
            margin-top: 12px;
            color: var(--text-soft);
            font-size: 0.9rem;
        }
        .chatbot-float {
            position: fixed;
            right: 20px;
            bottom: 20px;
            width: 64px;
            height: 64px;
            border-radius: 18px;
            display: grid;
            place-items: center;
            text-decoration: none;
            background: linear-gradient(135deg, var(--red), var(--gold));
            color: #161616;
            box-shadow: 0 18px 30px rgba(0, 0, 0, 0.3);
            z-index: 25;
        }
        .chatbot-float span {
            font-size: 0.78rem;
            font-weight: 800;
            line-height: 1.05;
            text-align: center;
        }
        @media (max-width: 920px) {
            .row { grid-template-columns: 1fr; }
            .details-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
<div class="wrap">
    <div class="hero">
        <div class="hero-top">
            <div class="title-line">
                <div class="icon-badge">CM</div>
                <h2>Content Management</h2>
            </div>
            <a class="back" href="home.jsp">Back to Dashboard</a>
        </div>
        <p>Manage titles, descriptions, posters, and content types from one control panel. All actions now go through the backend database.</p>
        <div class="hero-tags">
            <span>Backend CRUD</span>
            <span>MySQL persistence</span>
            <span>Shared with dashboard</span>
        </div>
    </div>

    <div id="messageBox" class="msg"></div>

    <div id="detailsPanel" class="panel" style="display:none;">
        <div class="subhead">
            <h3>Read Content</h3>
            <a class="ghost-link" href="#" onclick="clearView(); return false;">Clear selection</a>
        </div>
        <div class="details-grid">
            <img id="detailsPoster" class="details-poster" src="" alt="Poster" />
            <div class="details-copy">
                <h3 id="detailsTitle"></h3>
                <div class="details-meta">
                    <span id="detailsType"></span>
                    <span id="detailsGenre"></span>
                </div>
                <p id="detailsDescription"></p>
                <p><strong>Poster:</strong> <span id="detailsPosterText"></span></p>
            </div>
        </div>
    </div>

    <div class="panel">
        <div class="subhead">
            <h3 id="formTitle">Add Content</h3>
            <a class="ghost-link" href="#" onclick="resetForm(); return false;">Clear form</a>
        </div>
        <form id="contentForm">
            <input type="hidden" id="contentId" value="" />
            <div class="row">
                <input id="title" type="text" placeholder="Title" />
                <select id="type">
                    <option value="Movie">Movie</option>
                    <option value="Web Series">Web Series</option>
                    <option value="Documentary">Documentary</option>
                </select>
                <input id="genre" type="text" placeholder="Genre" />
                <input id="description" type="text" placeholder="Short description" />
                <input id="poster" type="text" placeholder="Poster URL (https://...)" />
                <button id="submitBtn" type="submit">Add</button>
                <button class="secondary-btn" type="button" onclick="resetForm()">Cancel</button>
            </div>
        </form>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Type</th>
                <th>Genre</th>
                <th>Description</th>
                <th>Poster</th>
                <th>Updated</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody id="contentTableBody">
            <tr><td colspan="8" class="empty">Loading content...</td></tr>
        </tbody>
    </table>

    <div class="note">Tip: any content you add, update, or delete here is stored in the backend and then reflected on the dashboard.</div>
</div>
<a class="chatbot-float" href="chatbot.jsp" title="Open Helpline Chatbot"><span>CHAT<br />BOT</span></a>

<script>
    const API_BASE = 'http://localhost/ott-backend/api';
    const tableBody = document.getElementById('contentTableBody');
    const messageBox = document.getElementById('messageBox');
    const detailsPanel = document.getElementById('detailsPanel');
    let contentItems = [];

    function escapeHtml(value) {
        return String(value || '')
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;');
    }

    function showMessage(message, type) {
        messageBox.className = 'msg ' + type;
        messageBox.textContent = message;
        messageBox.style.display = 'block';
    }

    function clearMessage() {
        messageBox.style.display = 'none';
        messageBox.textContent = '';
    }

    function getPoster(item) {
        return item.poster && item.poster.trim()
            ? item.poster
            : 'https://via.placeholder.com/500x750/1f1f1f/cccccc?text=No+Poster';
    }

    function renderTable() {
        if (!contentItems.length) {
            tableBody.innerHTML = '<tr><td colspan="8" class="empty">No content available.</td></tr>';
            return;
        }

        tableBody.innerHTML = contentItems.map((item) => `
            <tr>
                <td>\${escapeHtml(item.id)}</td>
                <td>\${escapeHtml(item.title)}</td>
                <td><span class="tag">\${escapeHtml(item.type)}</span></td>
                <td>\${escapeHtml(item.genre)}</td>
                <td>\${escapeHtml(item.description || '-')}</td>
                <td>\${item.poster ? 'Added' : '-'}</td>
                <td>\${escapeHtml(item.updated_at || item.created_at || '-')}</td>
                <td class="actions-cell">
                    <button class="table-link" type="button" onclick="readContent(\${item.id})">Read</button>
                    <button class="table-link" type="button" onclick="editContent(\${item.id})">Edit</button>
                    <button class="table-link delete" type="button" onclick="deleteContent(\${item.id})">Delete</button>
                </td>
            </tr>
        `).join('');
    }

    async function loadContent() {
        try {
            const res = await fetch(API_BASE + '/content_list.php');
            const data = await res.json();
            if (!res.ok) {
                throw new Error(data.error || 'Unable to load content');
            }
            contentItems = data.items || [];
            renderTable();
        } catch (error) {
            tableBody.innerHTML = '<tr><td colspan="8" class="empty">Failed to load backend content.</td></tr>';
            showMessage(error.message, 'error');
        }
    }

    function findItem(id) {
        return contentItems.find((item) => Number(item.id) === Number(id));
    }

    function readContent(id) {
        const item = findItem(id);
        if (!item) {
            return;
        }
        document.getElementById('detailsPoster').src = getPoster(item);
        document.getElementById('detailsTitle').textContent = item.title;
        document.getElementById('detailsType').textContent = 'Type: ' + item.type;
        document.getElementById('detailsGenre').textContent = 'Genre: ' + item.genre;
        document.getElementById('detailsDescription').textContent = item.description || 'No description available.';
        document.getElementById('detailsPosterText').textContent = item.poster || 'Not added';
        detailsPanel.style.display = 'block';
        detailsPanel.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }

    function clearView() {
        detailsPanel.style.display = 'none';
    }

    function editContent(id) {
        const item = findItem(id);
        if (!item) {
            return;
        }
        clearMessage();
        document.getElementById('contentId').value = item.id;
        document.getElementById('title').value = item.title || '';
        document.getElementById('type').value = item.type || 'Movie';
        document.getElementById('genre').value = item.genre || '';
        document.getElementById('description').value = item.description || '';
        document.getElementById('poster').value = item.poster || '';
        document.getElementById('formTitle').textContent = 'Edit Content';
        document.getElementById('submitBtn').textContent = 'Update';
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    function resetForm(clearStatus) {
        if (clearStatus) {
            clearMessage();
        }
        document.getElementById('contentForm').reset();
        document.getElementById('contentId').value = '';
        document.getElementById('formTitle').textContent = 'Add Content';
        document.getElementById('submitBtn').textContent = 'Add';
    }

    async function deleteContent(id) {
        if (!confirm('Delete this content item?')) {
            return;
        }

        try {
            const res = await fetch(API_BASE + '/content_delete.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ id: id })
            });
            const data = await res.json();
            if (!res.ok) {
                throw new Error(data.error || 'Unable to delete content');
            }
            showMessage(data.message || 'Content deleted successfully.', 'success');
            clearView();
            resetForm(false);
            await loadContent();
            tableBody.scrollIntoView({ behavior: 'smooth', block: 'start' });
        } catch (error) {
            showMessage(error.message, 'error');
        }
    }

    document.getElementById('contentForm').addEventListener('submit', async function (event) {
        event.preventDefault();
        clearMessage();

        const payload = {
            id: document.getElementById('contentId').value ? Number(document.getElementById('contentId').value) : 0,
            title: document.getElementById('title').value.trim(),
            type: document.getElementById('type').value,
            genre: document.getElementById('genre').value.trim(),
            description: document.getElementById('description').value.trim(),
            poster: document.getElementById('poster').value.trim()
        };

        if (!payload.title || !payload.type || !payload.genre) {
            showMessage('Title, type, and genre are required.', 'error');
            return;
        }

        try {
            const res = await fetch(API_BASE + '/content_save.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            });
            const data = await res.json();
            if (!res.ok) {
                throw new Error(data.error || 'Unable to save content');
            }
            const idText = data.id ? ' Row ID: ' + data.id + '.' : '';
            showMessage((data.message || 'Content saved successfully.') + idText, 'success');
            resetForm();
            await loadContent();
        } catch (error) {
            showMessage(error.message, 'error');
        }
    });

    loadContent();
</script>
</body>
</html>

