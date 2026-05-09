package com.ott;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Optional;
import java.util.stream.Stream;
import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CookiesServlet extends HttpServlet {
    private static final DateTimeFormatter FORMATTER =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").withZone(ZoneId.systemDefault());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String user = session == null ? null : (String) session.getAttribute("user");
        if (!"admin".equals(user)) {
            response.sendRedirect("home.jsp");
            return;
        }

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        String now = FORMATTER.format(Instant.now());
        String visitValue = Long.toString(System.currentTimeMillis());
        Cookie visit = new Cookie("ott_visit", visitValue);
        visit.setMaxAge(60 * 60 * 24 * 7);
        visit.setPath("/");
        response.addCookie(visit);

        int totalVisits = 1;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            Optional<Cookie> countCookie = Stream.of(cookies)
                    .filter(c -> "ott_visit_count".equals(c.getName()))
                    .findFirst();
            if (countCookie.isPresent()) {
                try {
                    totalVisits = Integer.parseInt(countCookie.get().getValue()) + 1;
                } catch (NumberFormatException ignored) { }
            }
        }

        Cookie count = new Cookie("ott_visit_count", Integer.toString(totalVisits));
        count.setMaxAge(60 * 60 * 24 * 365);
        count.setPath("/");
        response.addCookie(count);

        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>Cookies</title>");
        out.println("<style>body{font-family:Segoe UI,Arial,sans-serif;background:#111;color:#f5f5f5;padding:20px}"
                + ".card{background:#1e1e1e;border:1px solid #333;padding:16px;border-radius:10px;max-width:720px}"
                + "a{color:#e50914;text-decoration:none}"
                + ".chatbot-float{position:fixed;right:20px;bottom:20px;width:64px;height:64px;border-radius:18px;display:grid;place-items:center;text-decoration:none;background:linear-gradient(135deg,#e50914,#ffb703);color:#151515;box-shadow:0 18px 30px rgba(0,0,0,.32);z-index:40}"
                + ".chatbot-float span{font-size:.78rem;font-weight:800;line-height:1.05;text-align:center}</style></head><body>");
        out.println("<div class=\"card\">");
        out.println("<h2>Cookies Demo</h2>");
        out.println("<p>Cookie ott_visit stores timestamp; ott_visit_count totals visits.</p>");

        if (cookies == null || cookies.length == 0) {
            out.println("<p>No cookies found.</p>");
        } else {
            out.println("<ul>");
            for (Cookie c : cookies) {
                out.println("<li><strong>" + c.getName() + "</strong> = " + c.getValue() + "</li>");
            }
            out.println("</ul>");
        }

        out.println("<p>Total visits tracked: " + totalVisits + "</p>");

        out.println("<p><a href=\"home.jsp\">Back to Dashboard</a></p>");
        out.println("<a class=\"chatbot-float\" href=\"chatbot.jsp\" title=\"Open Helpline Chatbot\"><span>CHAT<br />BOT</span></a>");
        out.println("</div></body></html>");
    }
}
