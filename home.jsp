<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.time.*, java.time.format.DateTimeFormatter" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    boolean isAdmin = "admin".equals(user);

    Long sessionStart = (Long) session.getAttribute("sessionStart");
    if (sessionStart == null) {
        sessionStart = System.currentTimeMillis();
        session.setAttribute("sessionStart", sessionStart);
    }

    long nowMs = System.currentTimeMillis();
    long elapsedMs = nowMs - sessionStart;
    long elapsedSeconds = elapsedMs / 1000;
    long minutes = elapsedSeconds / 60;
    long seconds = elapsedSeconds % 60;

    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").withZone(ZoneId.systemDefault());
    String nowTime = dtf.format(Instant.ofEpochMilli(nowMs));

    List<Map<String, String>> contentList = (List<Map<String, String>>) application.getAttribute("contentList");
    if (contentList == null || contentList.size() < 30) {
        contentList = new ArrayList<Map<String, String>>();
        Map<String, String> c1 = new HashMap<String, String>();
        c1.put("title", "Inception");
        c1.put("type", "Movie");
        c1.put("genre", "Sci-Fi");
        c1.put("description", "A thief enters dreams to steal secrets and is offered a chance at redemption.");
        c1.put("poster", "https://image.tmdb.org/t/p/w500/edv5CZvWj09upOsy2Y6IwDhK8bt.jpg");
        contentList.add(c1);

        Map<String, String> c2 = new HashMap<String, String>();
        c2.put("title", "Interstellar");
        c2.put("type", "Movie");
        c2.put("genre", "Sci-Fi");
        c2.put("description", "Explorers travel through a wormhole to secure humanity's future.");
        c2.put("poster", "https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg");
        contentList.add(c2);

        Map<String, String> c3 = new HashMap<String, String>();
        c3.put("title", "The Dark Knight");
        c3.put("type", "Movie");
        c3.put("genre", "Action");
        c3.put("description", "Batman faces the Joker, who pushes Gotham into chaos.");
        c3.put("poster", "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg");
        contentList.add(c3);

        Map<String, String> c4 = new HashMap<String, String>();
        c4.put("title", "Avatar");
        c4.put("type", "Movie");
        c4.put("genre", "Fantasy");
        c4.put("description", "A marine on Pandora is torn between orders and protecting a new world.");
        c4.put("poster", "https://image.tmdb.org/t/p/w500/kyeqWdyUXW608qlYkRqosgbbJyK.jpg");
        contentList.add(c4);

        Map<String, String> c5 = new HashMap<String, String>();
        c5.put("title", "Titanic");
        c5.put("type", "Movie");
        c5.put("genre", "Romance");
        c5.put("description", "A love story unfolds aboard the ill-fated RMS Titanic.");
        c5.put("poster", "https://image.tmdb.org/t/p/w500/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg");
        contentList.add(c5);

        Map<String, String> c6 = new HashMap<String, String>();
        c6.put("title", "The Matrix");
        c6.put("type", "Movie");
        c6.put("genre", "Sci-Fi");
        c6.put("description", "A hacker discovers reality is a simulation and joins a rebellion.");
        c6.put("poster", "https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg");
        contentList.add(c6);

        Map<String, String> c7 = new HashMap<String, String>();
        c7.put("title", "Joker");
        c7.put("type", "Movie");
        c7.put("genre", "Drama");
        c7.put("description", "A struggling comedian descends into madness in Gotham City.");
        c7.put("poster", "https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg");
        contentList.add(c7);

        Map<String, String> c8 = new HashMap<String, String>();
        c8.put("title", "Dune");
        c8.put("type", "Movie");
        c8.put("genre", "Sci-Fi");
        c8.put("description", "A noble family fights for survival on the dangerous desert planet Arrakis.");
        c8.put("poster", "https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg");
        contentList.add(c8);

        Map<String, String> c9 = new HashMap<String, String>();
        c9.put("title", "The Shawshank Redemption");
        c9.put("type", "Movie");
        c9.put("genre", "Drama");
        c9.put("description", "Two imprisoned men bond over years, finding hope and redemption.");
        c9.put("poster", "https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg");
        contentList.add(c9);

        Map<String, String> c10 = new HashMap<String, String>();
        c10.put("title", "Forrest Gump");
        c10.put("type", "Movie");
        c10.put("genre", "Drama");
        c10.put("description", "An ordinary man witnesses and influences decades of American history.");
        c10.put("poster", "https://image.tmdb.org/t/p/w500/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg");
        contentList.add(c10);

        Map<String, String> c11 = new HashMap<String, String>();
        c11.put("title", "Gladiator");
        c11.put("type", "Movie");
        c11.put("genre", "Action");
        c11.put("description", "A betrayed Roman general fights as a gladiator to avenge his family.");
        c11.put("poster", "https://image.tmdb.org/t/p/w500/ty8TGRuvJLPUmAR1H1nRIsgwvim.jpg");
        contentList.add(c11);

        Map<String, String> c12 = new HashMap<String, String>();
        c12.put("title", "The Godfather");
        c12.put("type", "Movie");
        c12.put("genre", "Crime");
        c12.put("description", "The aging patriarch of a crime dynasty transfers control to his reluctant son.");
        c12.put("poster", "https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg");
        contentList.add(c12);

        Map<String, String> c13 = new HashMap<String, String>();
        c13.put("title", "The Godfather Part II");
        c13.put("type", "Movie");
        c13.put("genre", "Crime");
        c13.put("description", "Parallel stories of Michael Corleone and young Vito deepen a family saga.");
        c13.put("poster", "https://image.tmdb.org/t/p/w500/hek3koDUyRQk7FIhPXsa6mT2Zc3.jpg");
        contentList.add(c13);

        Map<String, String> c14 = new HashMap<String, String>();
        c14.put("title", "Pulp Fiction");
        c14.put("type", "Movie");
        c14.put("genre", "Crime");
        c14.put("description", "Interwoven tales of crime and redemption in Los Angeles.");
        c14.put("poster", "https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg");
        contentList.add(c14);

        Map<String, String> c15 = new HashMap<String, String>();
        c15.put("title", "Fight Club");
        c15.put("type", "Movie");
        c15.put("genre", "Drama");
        c15.put("description", "An insomniac and a soap maker create an underground fight movement.");
        c15.put("poster", "https://image.tmdb.org/t/p/w500/bptfVGEQuv6vDTIMVCHjJ9Dz8PX.jpg");
        contentList.add(c15);

        Map<String, String> c16 = new HashMap<String, String>();
        c16.put("title", "The Lord of the Rings: The Fellowship of the Ring");
        c16.put("type", "Movie");
        c16.put("genre", "Fantasy");
        c16.put("description", "A hobbit begins a perilous quest to destroy a powerful ring.");
        c16.put("poster", "https://image.tmdb.org/t/p/w500/6oom5QYQ2yQTMJIbnvbkBL9cHo6.jpg");
        contentList.add(c16);

        Map<String, String> c17 = new HashMap<String, String>();
        c17.put("title", "The Lord of the Rings: The Two Towers");
        c17.put("type", "Movie");
        c17.put("genre", "Fantasy");
        c17.put("description", "The fellowship is broken as war rises across Middle-earth.");
        c17.put("poster", "https://image.tmdb.org/t/p/w500/5VTN0pR8gcqV3EPUHHfMGnJYN9L.jpg");
        contentList.add(c17);

        Map<String, String> c18 = new HashMap<String, String>();
        c18.put("title", "The Lord of the Rings: The Return of the King");
        c18.put("type", "Movie");
        c18.put("genre", "Fantasy");
        c18.put("description", "Final battles decide the fate of Middle-earth.");
        c18.put("poster", "https://image.tmdb.org/t/p/w500/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg");
        contentList.add(c18);

        Map<String, String> c19 = new HashMap<String, String>();
        c19.put("title", "Avengers: Endgame");
        c19.put("type", "Movie");
        c19.put("genre", "Superhero");
        c19.put("description", "The Avengers unite for a final stand after devastating loss.");
        c19.put("poster", "https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg");
        contentList.add(c19);

        Map<String, String> c20 = new HashMap<String, String>();
        c20.put("title", "Avengers: Infinity War");
        c20.put("type", "Movie");
        c20.put("genre", "Superhero");
        c20.put("description", "Earth's heroes confront Thanos as he seeks the Infinity Stones.");
        c20.put("poster", "https://image.tmdb.org/t/p/w500/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg");
        contentList.add(c20);

        Map<String, String> c21 = new HashMap<String, String>();
        c21.put("title", "Spider-Man: No Way Home");
        c21.put("type", "Movie");
        c21.put("genre", "Superhero");
        c21.put("description", "Multiverse chaos erupts after Spider-Man's identity is revealed.");
        c21.put("poster", "https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg");
        contentList.add(c21);

        Map<String, String> c22 = new HashMap<String, String>();
        c22.put("title", "Black Panther");
        c22.put("type", "Movie");
        c22.put("genre", "Superhero");
        c22.put("description", "T'Challa returns home to lead Wakanda and defend its future.");
        c22.put("poster", "https://image.tmdb.org/t/p/w500/uxzzxijgPIY7slzFvMotPv8wjKA.jpg");
        contentList.add(c22);

        Map<String, String> c23 = new HashMap<String, String>();
        c23.put("title", "Mad Max: Fury Road");
        c23.put("type", "Movie");
        c23.put("genre", "Action");
        c23.put("description", "In a post-apocalyptic wasteland, rebels flee a tyrant in a road war.");
        c23.put("poster", "https://image.tmdb.org/t/p/w500/hA2ple9q4qnwxp3hKVNhroipsir.jpg");
        contentList.add(c23);

        Map<String, String> c24 = new HashMap<String, String>();
        c24.put("title", "John Wick");
        c24.put("type", "Movie");
        c24.put("genre", "Action");
        c24.put("description", "A retired assassin returns to the underworld for revenge.");
        c24.put("poster", "https://image.tmdb.org/t/p/w500/fZPSd91yGE9fCcCe6OoQr6E3Bev.jpg");
        contentList.add(c24);

        Map<String, String> c25 = new HashMap<String, String>();
        c25.put("title", "Top Gun: Maverick");
        c25.put("type", "Movie");
        c25.put("genre", "Action");
        c25.put("description", "Maverick trains elite pilots for a high-risk mission.");
        c25.put("poster", "https://image.tmdb.org/t/p/w500/62HCnUTziyWcpDaBO2i1DX17ljH.jpg");
        contentList.add(c25);

        Map<String, String> c26 = new HashMap<String, String>();
        c26.put("title", "Oppenheimer");
        c26.put("type", "Movie");
        c26.put("genre", "Biography");
        c26.put("description", "The life of J. Robert Oppenheimer and the creation of the atomic bomb.");
        c26.put("poster", "https://image.tmdb.org/t/p/w500/ptpr0kGAckfQkJeJIt8st5dglvd.jpg");
        contentList.add(c26);

        Map<String, String> c27 = new HashMap<String, String>();
        c27.put("title", "Barbie");
        c27.put("type", "Movie");
        c27.put("genre", "Comedy");
        c27.put("description", "Barbie and Ken journey from Barbie Land to the real world.");
        c27.put("poster", "https://image.tmdb.org/t/p/w500/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg");
        contentList.add(c27);

        Map<String, String> c28 = new HashMap<String, String>();
        c28.put("title", "The Batman");
        c28.put("type", "Movie");
        c28.put("genre", "Crime");
        c28.put("description", "Batman investigates corruption and a serial killer known as the Riddler.");
        c28.put("poster", "https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg");
        contentList.add(c28);

        Map<String, String> c29 = new HashMap<String, String>();
        c29.put("title", "No Time to Die");
        c29.put("type", "Movie");
        c29.put("genre", "Action");
        c29.put("description", "James Bond returns from retirement for one last dangerous mission.");
        c29.put("poster", "https://image.tmdb.org/t/p/w500/iUgygt3fscRoKWCV1d0C7FbM9TP.jpg");
        contentList.add(c29);

        Map<String, String> c30 = new HashMap<String, String>();
        c30.put("title", "The Prestige");
        c30.put("type", "Movie");
        c30.put("genre", "Mystery");
        c30.put("description", "Two rival magicians obsess over one final illusion.");
        c30.put("poster", "https://image.tmdb.org/t/p/w500/5MXyQfz8xUP3dIFPTubhTsbFY6N.jpg");
        contentList.add(c30);

        Map<String, String> c31 = new HashMap<String, String>();
        c31.put("title", "Whiplash");
        c31.put("type", "Movie");
        c31.put("genre", "Drama");
        c31.put("description", "A young drummer and a ruthless mentor push each other to extremes.");
        c31.put("poster", "https://image.tmdb.org/t/p/w500/7fn624j5lj3xTme2SgiLCeuedmO.jpg");
        contentList.add(c31);

        Map<String, String> c32 = new HashMap<String, String>();
        c32.put("title", "Parasite");
        c32.put("type", "Movie");
        c32.put("genre", "Thriller");
        c32.put("description", "A poor family infiltrates a wealthy household with unexpected consequences.");
        c32.put("poster", "https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg");
        contentList.add(c32);

        application.setAttribute("contentList", contentList);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>OTT Dashboard</title>
    <style>
        :root {
            --bg-main: #141414;
            --bg-panel: #1f1f1f;
            --bg-card: #242424;
            --text-main: #f5f5f5;
            --text-soft: #b3b3b3;
            --brand-red: #e50914;
            --brand-red-dark: #b20710;
            --line: #343434;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; font-family: "Segoe UI", Arial, sans-serif; }
        body {
            background:
                linear-gradient(180deg, rgba(0, 0, 0, 0.7), rgba(20, 20, 20, 1)),
                radial-gradient(circle at top right, rgba(229, 9, 20, 0.15), transparent 40%),
                var(--bg-main);
            color: var(--text-main);
            min-height: 100vh;
        }
        .nav {
            background: linear-gradient(90deg, #090909, #1a1a1a);
            border-bottom: 1px solid var(--line);
            color: #fff;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 20px;
            position: sticky;
            top: 0;
            z-index: 5;
        }
        .nav-left {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .brand {
            color: var(--brand-red);
            font-size: 1.2rem;
            letter-spacing: 0.6px;
        }
        .menu-toggle {
            width: 42px;
            height: 42px;
            border: 1px solid #3b3b3b;
            border-radius: 10px;
            background: #181818;
            color: #fff;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            gap: 4px;
        }
        .menu-toggle span {
            width: 18px;
            height: 2px;
            background: #fff;
            border-radius: 999px;
            display: block;
        }
        .menu-toggle:hover {
            background: #222;
            transform: translateY(-1px);
        }
        .actions {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }
        .user {
            color: var(--text-soft);
            font-size: 0.9rem;
            margin-right: 6px;
        }
        .btn-link {
            color: #fff;
            text-decoration: none;
            font-size: 0.9rem;
            border: 1px solid var(--line);
            padding: 8px 12px;
            border-radius: 6px;
            background: #212121;
            transition: background 0.2s ease, border-color 0.2s ease;
        }
        .btn-link:hover {
            background: #2b2b2b;
            border-color: #4a4a4a;
        }
        .btn-link.danger {
            background: var(--brand-red);
            border-color: var(--brand-red-dark);
        }
        .btn-link.danger:hover {
            background: var(--brand-red-dark);
        }
        .side-menu {
            position: fixed;
            top: 0;
            left: -320px;
            width: 290px;
            height: 100vh;
            background: linear-gradient(180deg, #111111, #1a1a1a);
            border-right: 1px solid #2f2f2f;
            z-index: 20;
            padding: 22px 18px;
            transition: left 0.25s ease;
            box-shadow: 20px 0 40px rgba(0, 0, 0, 0.28);
        }
        .side-menu.open {
            left: 0;
        }
        .menu-head {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 18px;
        }
        .menu-title {
            color: #fff;
            font-size: 1rem;
            letter-spacing: 0.4px;
        }
        .menu-close {
            border: 1px solid #383838;
            background: #161616;
            color: #fff;
            border-radius: 8px;
            width: 34px;
            height: 34px;
            cursor: pointer;
        }
        .menu-links {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .menu-links a {
            color: #fff;
            text-decoration: none;
            padding: 11px 12px;
            border: 1px solid #303030;
            border-radius: 10px;
            background: #1c1c1c;
            transition: background 0.2s ease, border-color 0.2s ease;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .menu-links a:hover {
            background: #252525;
            border-color: #4a4a4a;
            transform: translateX(4px);
        }
        .menu-icon {
            width: 28px;
            height: 28px;
            border-radius: 9px;
            display: grid;
            place-items: center;
            background: linear-gradient(120deg, rgba(229, 9, 20, 0.95), rgba(255, 184, 0, 0.92));
            color: #181818;
            font-size: 0.72rem;
            font-weight: 800;
            flex-shrink: 0;
        }
        .menu-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.5);
            opacity: 0;
            pointer-events: none;
            z-index: 15;
            transition: opacity 0.2s ease;
        }
        .menu-overlay.show {
            opacity: 1;
            pointer-events: auto;
        }
        .container { max-width: 1100px; margin: 26px auto; padding: 0 18px 30px; }
        .hero {
            background: linear-gradient(120deg, rgba(229, 9, 20, 0.2), rgba(0, 0, 0, 0.2));
            border: 1px solid var(--line);
            border-radius: 14px;
            padding: 22px;
            margin-bottom: 20px;
            position: relative;
            overflow: hidden;
        }
        .hero::after {
            content: "";
            position: absolute;
            inset: auto -80px -80px auto;
            width: 220px;
            height: 220px;
            background: radial-gradient(circle, rgba(255, 183, 3, 0.14), transparent 60%);
            pointer-events: none;
        }
        .hero-top {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 8px;
        }
        .hero-icon {
            width: 50px;
            height: 50px;
            border-radius: 16px;
            display: grid;
            place-items: center;
            background: linear-gradient(120deg, #e50914, #ffb703);
            color: #1c1c1c;
            font-size: 0.95rem;
            font-weight: 800;
            box-shadow: 0 10px 24px rgba(229, 9, 20, 0.28);
        }
        .hero h2 { margin-bottom: 8px; font-size: 1.6rem; }
        .hero p { color: var(--text-soft); }
        .hero-strip {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 14px;
        }
        .hero-pill {
            padding: 8px 11px;
            border-radius: 999px;
            border: 1px solid rgba(255, 255, 255, 0.08);
            background: rgba(255, 255, 255, 0.04);
            color: #eceff7;
            font-size: 0.84rem;
        }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(230px, 1fr)); gap: 14px; }
        .card {
            background: linear-gradient(180deg, #2a2a2a, #202020);
            border: 1px solid var(--line);
            border-radius: 12px;
            padding: 10px;
            transition: transform 0.2s ease, border-color 0.2s ease;
            position: relative;
            overflow: hidden;
            cursor: pointer;
        }
        .card:hover {
            transform: translateY(-5px);
            border-color: #5a5a5a;
            box-shadow: 0 18px 28px rgba(0, 0, 0, 0.28);
        }
        .card::before {
            content: "";
            position: absolute;
            inset: 0;
            background: linear-gradient(180deg, rgba(255,255,255,0.05), transparent 30%);
            pointer-events: none;
        }
        .poster {
            width: 100%;
            height: 290px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 10px;
            border: 1px solid #3a3a3a;
            background: #111;
        }
        .title { font-size: 1.06rem; margin-bottom: 8px; font-weight: 700; }
        .title-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
        }
        .fav {
            width: 32px;
            height: 32px;
            display: grid;
            place-items: center;
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.08);
            background: rgba(255, 255, 255, 0.03);
            color: #ffcc66;
            font-size: 0.88rem;
        }
        .chip {
            display: inline-block;
            font-size: 0.78rem;
            color: #fff;
            background: rgba(229, 9, 20, 0.85);
            border-radius: 20px;
            padding: 3px 9px;
            margin-bottom: 8px;
        }
        .meta { color: #d4d4d4; font-size: 0.9rem; }
        .desc {
            color: var(--text-soft);
            font-size: 0.88rem;
            line-height: 1.35;
            margin-top: 8px;
            min-height: 54px;
        }
        .hint {
            margin-top: 10px;
            color: #ffcc66;
            font-size: 0.78rem;
            letter-spacing: 0.2px;
        }
        .modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.72);
            display: none;
            align-items: center;
            justify-content: center;
            padding: 20px;
            z-index: 50;
            backdrop-filter: blur(8px);
        }
        .modal-overlay.show {
            display: flex;
        }
        .movie-modal {
            width: min(900px, 96vw);
            background: linear-gradient(180deg, #181818, #101010);
            border: 1px solid #383838;
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 28px 60px rgba(0, 0, 0, 0.48);
        }
        .movie-modal-body {
            display: grid;
            grid-template-columns: 280px 1fr;
            gap: 20px;
            padding: 20px;
        }
        .movie-modal-poster {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 14px;
            border: 1px solid #313131;
            background: #111;
        }
        .movie-modal-content {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        .movie-modal-top {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 12px;
        }
        .movie-modal-title {
            font-size: 2rem;
            line-height: 1.1;
            margin-bottom: 8px;
        }
        .movie-modal-close {
            width: 38px;
            height: 38px;
            border-radius: 10px;
            border: 1px solid #3b3b3b;
            background: #171717;
            color: #fff;
            cursor: pointer;
        }
        .movie-modal-close:hover {
            background: #222;
        }
        .movie-meta-row {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        .movie-badge {
            padding: 8px 12px;
            border-radius: 999px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.08);
            color: #f2f2f2;
            font-size: 0.84rem;
        }
        .movie-modal-desc {
            color: #d2d2d2;
            line-height: 1.65;
            font-size: 0.97rem;
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.06);
            border-radius: 14px;
            padding: 16px;
        }
        .movie-modal-copy {
            color: #aaaaaa;
            font-size: 0.88rem;
        }
        .chatbot-float {
            position: fixed;
            right: 22px;
            bottom: 22px;
            width: 66px;
            height: 66px;
            border-radius: 20px;
            display: grid;
            place-items: center;
            text-decoration: none;
            background: linear-gradient(135deg, #e50914, #ffb703);
            color: #161616;
            box-shadow: 0 18px 34px rgba(0, 0, 0, 0.34);
            z-index: 40;
        }
        .chatbot-float span {
            font-size: 0.8rem;
            font-weight: 800;
            line-height: 1.05;
            text-align: center;
        }
        .session-corner {
            position: fixed;
            top: 16px;
            right: 16px;
            z-index: 10;
            background: rgba(18, 18, 18, 0.9);
            border: 1px solid #2f2f2f;
            border-radius: 10px;
            padding: 10px 12px;
            min-width: 210px;
            font-size: 0.82rem;
            color: #e5e5e5;
            box-shadow: 0 10px 18px rgba(0, 0, 0, 0.35);
            backdrop-filter: blur(8px);
        }
        .session-corner strong { color: #fff; }
        .session-corner .label { color: #a7a7a7; }
        .session-corner .value { margin-top: 4px; }
        .grid .card {
            animation: riseIn 0.45s ease both;
        }
        .grid .card:nth-child(2n) { animation-delay: 0.04s; }
        .grid .card:nth-child(3n) { animation-delay: 0.08s; }
        @keyframes riseIn {
            from { opacity: 0; transform: translateY(18px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @media (max-width: 760px) {
            .nav { flex-direction: column; align-items: flex-start; gap: 10px; }
            .actions { width: 100%; }
            .poster { height: 240px; }
            .session-corner { position: static; margin: 12px 0; }
            .side-menu { width: 260px; }
            .movie-modal-body { grid-template-columns: 1fr; }
            .movie-modal-poster { height: 300px; }
        }
    </style>
</head>
<body>
<div id="menuOverlay" class="menu-overlay" onclick="toggleMenu(false)"></div>
<aside id="sideMenu" class="side-menu">
    <div class="menu-head">
        <div class="menu-title">Quick Menu</div>
        <button class="menu-close" type="button" onclick="toggleMenu(false)">x</button>
    </div>
    <div class="menu-links">
        <% if (isAdmin) { %>
        <a href="contentManagement.jsp"><span class="menu-icon">CM</span><span>Content Management</span></a>
        <a href="cookies"><span class="menu-icon">CK</span><span>Cookies Demo</span></a>
        <a href="session-tracking"><span class="menu-icon">ST</span><span>Session Tracking</span></a>
        <% } %>
        <a href="subscription"><span class="menu-icon">SB</span><span>Subscription Module</span></a>
        <a href="chatbot.jsp"><span class="menu-icon">CB</span><span>Helpline Chatbot</span></a>
        <a href="http://localhost/ott-backend/public/payment.html" target="_blank" rel="noopener"><span class="menu-icon">PY</span><span>Payment</span></a>
        <a href="logout.jsp"><span class="menu-icon">LO</span><span>Logout</span></a>
    </div>
</aside>
<div class="session-corner">
    <div class="label">Session Tracking</div>
    <div class="value"><strong>Now:</strong> <span id="session-now"><%= nowTime %></span></div>
    <div class="value"><strong>Duration:</strong> <span id="session-duration"><%= minutes %>m <%= seconds %>s</span></div>
</div>
<div class="nav">
    <div class="nav-left">
        <button class="menu-toggle" type="button" onclick="toggleMenu(true)" aria-label="Open menu">
            <span></span>
            <span></span>
            <span></span>
        </button>
        <div class="brand"><strong>NETSTREAM</strong></div>
    </div>
    <div class="actions">
        <span class="user">Logged in as <%= user %></span>
    </div>
</div>

<div class="container">
    <div class="hero">
        <div class="hero-top">
            <div class="hero-icon">OTT</div>
            <div>
                <h2>Dashboard</h2>
                <p>Browse currently available content.</p>
            </div>
        </div>
        <div class="hero-strip">
            <div class="hero-pill">32+ seeded titles</div>
            <div class="hero-pill">Offline support chatbot</div>
            <div class="hero-pill">Subscription + payment modules</div>
            <% if (isAdmin) { %><div class="hero-pill">Admin tools enabled</div><% } %>
        </div>
    </div>

    <div id="contentGrid" class="grid">
        <% for (Map<String, String> item : contentList) { %>
            <div
                class="card"
                onclick="openMovieDetails(this)"
                data-title="<%= item.get("title") %>"
                data-type="<%= item.get("type") %>"
                data-genre="<%= item.get("genre") %>"
                data-description="<%= item.get("description") != null ? item.get("description").replace("\"", "&quot;") : "No description available." %>"
                data-poster="<%= item.get("poster") != null ? item.get("poster") : "https://via.placeholder.com/500x750/1f1f1f/cccccc?text=No+Poster" %>"
            >
                <img class="poster" src="<%= item.get("poster") != null ? item.get("poster") : "https://via.placeholder.com/500x750/1f1f1f/cccccc?text=No+Poster" %>" alt="<%= item.get("title") %> poster" />
                <div class="title-row">
                    <div class="title"><%= item.get("title") %></div>
                    <div class="fav">+</div>
                </div>
                <div class="chip"><%= item.get("type") %></div>
                <div class="meta">Type: <%= item.get("type") %></div>
                <div class="meta">Genre: <%= item.get("genre") %></div>
                <div class="desc"><%= item.get("description") != null ? item.get("description") : "No description available." %></div>
                <div class="hint">Click for details</div>
            </div>
        <% } %>
    </div>
</div>
<a class="chatbot-float" href="chatbot.jsp" title="Open Helpline Chatbot"><span>CHAT<br />BOT</span></a>
<div id="movieModalOverlay" class="modal-overlay" onclick="closeMovieDetails(event)">
    <div class="movie-modal" onclick="event.stopPropagation()">
        <div class="movie-modal-body">
            <img id="movieModalPoster" class="movie-modal-poster" src="" alt="Movie poster" />
            <div class="movie-modal-content">
                <div class="movie-modal-top">
                    <div>
                        <div id="movieModalTitle" class="movie-modal-title"></div>
                        <div class="movie-meta-row">
                            <span id="movieModalType" class="movie-badge"></span>
                            <span id="movieModalGenre" class="movie-badge"></span>
                        </div>
                    </div>
                    <button class="movie-modal-close" type="button" onclick="closeMovieDetails()">x</button>
                </div>
                <div class="movie-modal-copy">Title details from the OTT catalogue</div>
                <div id="movieModalDesc" class="movie-modal-desc"></div>
            </div>
        </div>
    </div>
</div>
<script>
    (function () {
        const startMs = <%= sessionStart %>;
        const nowEl = document.getElementById("session-now");
        const durationEl = document.getElementById("session-duration");
        const sideMenu = document.getElementById("sideMenu");
        const menuOverlay = document.getElementById("menuOverlay");
        const movieModalOverlay = document.getElementById("movieModalOverlay");
        const movieModalPoster = document.getElementById("movieModalPoster");
        const movieModalTitle = document.getElementById("movieModalTitle");
        const movieModalType = document.getElementById("movieModalType");
        const movieModalGenre = document.getElementById("movieModalGenre");
        const movieModalDesc = document.getElementById("movieModalDesc");
        const contentGrid = document.getElementById("contentGrid");

        function pad(n) { return n < 10 ? "0" + n : "" + n; }
        function tick() {
            const now = new Date();
            const elapsed = Math.max(0, Math.floor((Date.now() - startMs) / 1000));
            const mins = Math.floor(elapsed / 60);
            const secs = elapsed % 60;
            nowEl.textContent =
                now.getFullYear() + "-" +
                pad(now.getMonth() + 1) + "-" +
                pad(now.getDate()) + " " +
                pad(now.getHours()) + ":" +
                pad(now.getMinutes()) + ":" +
                pad(now.getSeconds());
            durationEl.textContent = mins + "m " + secs + "s";
        }
        tick();
        setInterval(tick, 1000);

        window.toggleMenu = function (show) {
            sideMenu.classList.toggle("open", show);
            menuOverlay.classList.toggle("show", show);
        };

        window.openMovieDetails = function (card) {
            movieModalPoster.src = card.dataset.poster;
            movieModalPoster.alt = card.dataset.title + " poster";
            movieModalTitle.textContent = card.dataset.title;
            movieModalType.textContent = "Type: " + card.dataset.type;
            movieModalGenre.textContent = "Genre: " + card.dataset.genre;
            movieModalDesc.textContent = card.dataset.description;
            movieModalOverlay.classList.add("show");
            document.body.style.overflow = "hidden";
        };

        window.closeMovieDetails = function () {
            movieModalOverlay.classList.remove("show");
            document.body.style.overflow = "";
        };

        function escapeHtml(value) {
            return String(value || "")
                .replace(/&/g, "&amp;")
                .replace(/</g, "&lt;")
                .replace(/>/g, "&gt;")
                .replace(/"/g, "&quot;")
                .replace(/'/g, "&#39;");
        }

        function renderContent(items) {
            if (!items || !items.length) {
                contentGrid.innerHTML = "<div class=\"card\"><div class=\"title\">No content available.</div><div class=\"desc\">Backend content is empty right now.</div></div>";
                return;
            }

            contentGrid.innerHTML = items.map(function (item) {
                const poster = item.poster && item.poster.trim()
                    ? item.poster
                    : "https://via.placeholder.com/500x750/1f1f1f/cccccc?text=No+Poster";
                const description = item.description && item.description.trim()
                    ? item.description
                    : "No description available.";

                return `
                    <div
                        class="card"
                        onclick="openMovieDetails(this)"
                        data-title="\${escapeHtml(item.title)}"
                        data-type="\${escapeHtml(item.type)}"
                        data-genre="\${escapeHtml(item.genre)}"
                        data-description="\${escapeHtml(description)}"
                        data-poster="\${escapeHtml(poster)}"
                    >
                        <img class="poster" src="\${escapeHtml(poster)}" alt="\${escapeHtml(item.title)} poster" />
                        <div class="title-row">
                            <div class="title">\${escapeHtml(item.title)}</div>
                            <div class="fav">+</div>
                        </div>
                        <div class="chip">\${escapeHtml(item.type)}</div>
                        <div class="meta">Type: \${escapeHtml(item.type)}</div>
                        <div class="meta">Genre: \${escapeHtml(item.genre)}</div>
                        <div class="desc">\${escapeHtml(description)}</div>
                        <div class="hint">Click for details</div>
                    </div>
                `;
            }).join("");
        }

        function loadBackendContent() {
            fetch("http://localhost/ott-backend/api/content_list.php")
                .then(function (response) { return response.json().then(function (data) { return { ok: response.ok, data: data }; }); })
                .then(function (result) {
                    if (!result.ok) {
                        return;
                    }
                    renderContent(result.data.items || []);
                })
                .catch(function () {
                    // Keep the server-rendered fallback cards if backend is unavailable.
                });
        }

        document.addEventListener("keydown", function (event) {
            if (event.key === "Escape") {
                window.closeMovieDetails();
                window.toggleMenu(false);
            }
        });

        loadBackendContent();
    })();
</script>
</body>
</html>

