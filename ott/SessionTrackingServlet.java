package com.ott;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class SessionTrackingServlet extends HttpServlet {
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

        Instant now = Instant.now();

        Long firstVisit = (Long) session.getAttribute("firstVisit");
        if (firstVisit == null) {
            firstVisit = now.toEpochMilli();
            session.setAttribute("firstVisit", firstVisit);
        }

        String nowStr = FORMATTER.format(now);
        String createdStr = FORMATTER.format(Instant.ofEpochMilli(session.getCreationTime()));
        String lastStr = FORMATTER.format(Instant.ofEpochMilli(session.getLastAccessedTime()));
        String firstStr = FORMATTER.format(Instant.ofEpochMilli(firstVisit));

        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>Session Tracking</title>");
        out.println("<style>body{font-family:Segoe UI,Arial,sans-serif;background:#111;color:#f5f5f5;padding:20px}"
                + ".card{background:#1e1e1e;border:1px solid #333;padding:16px;border-radius:10px;max-width:720px}"
                + "table{width:100%;border-collapse:collapse;margin-top:10px}"
                + "td{padding:6px;border-bottom:1px solid #2b2b2b}"
                + "a{color:#e50914;text-decoration:none}"
                + ".chatbot-float{position:fixed;right:20px;bottom:20px;width:64px;height:64px;border-radius:18px;display:grid;place-items:center;text-decoration:none;background:linear-gradient(135deg,#e50914,#ffb703);color:#151515;box-shadow:0 18px 30px rgba(0,0,0,.32);z-index:40}"
                + ".chatbot-float span{font-size:.78rem;font-weight:800;line-height:1.05;text-align:center}</style></head><body>");
        out.println("<div class=\"card\">");
        out.println("<h2>Session Tracking</h2>");
        out.println("<p>Current date/time: <strong>" + nowStr + "</strong></p>");
        out.println("<table>");
        out.println("<tr><td>Session ID</td><td>" + session.getId() + "</td></tr>");
        out.println("<tr><td>Session Created</td><td>" + createdStr + "</td></tr>");
        out.println("<tr><td>Last Accessed</td><td>" + lastStr + "</td></tr>");
        out.println("<tr><td>First Visit</td><td>" + firstStr + "</td></tr>");
        out.println("</table>");
        out.println("<p><a href=\"home.jsp\">Back to Dashboard</a></p>");
        out.println("</div>");
        out.println("<a class=\"chatbot-float\" href=\"chatbot.jsp\" title=\"Open Helpline Chatbot\"><span>CHAT<br />BOT</span></a>");
        out.println("</body></html>");
    }
}
