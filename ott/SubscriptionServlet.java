package com.ott;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SubscriptionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        renderPage(request, response, null, "success");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = trim(request.getParameter("name"));
        String email = trim(request.getParameter("email"));
        String plan = trim(request.getParameter("plan"));
        String action = trim(request.getParameter("formAction"));
        String message;
        String messageType = "success";

        if (name.isEmpty() || email.isEmpty() || plan.isEmpty()) {
            message = "All fields are required.";
            messageType = "error";
        } else {
            List<Map<String, String>> subscriptions = getSubscriptions();
            if ("update".equalsIgnoreCase(action)) {
                String subscriptionId = trim(request.getParameter("id"));
                Map<String, String> item = findSubscription(subscriptionId, subscriptions);
                if (item != null) {
                        item.put("name", name);
                        item.put("email", email);
                        item.put("plan", plan);
                        SubscriptionXmlStore.save(getServletContext(), subscriptions);
                        String syncError = SubscriptionDbSync.upsert(item);
                        if (syncError == null) {
                            message = "Subscription updated successfully in XML and database.";
                        } else {
                            message = "Subscription updated in XML, but database sync failed.";
                            messageType = "error";
                        }
                } else {
                    message = "Unable to update the selected subscription.";
                    messageType = "error";
                }
            } else {
                Map<String, String> item = new HashMap<String, String>();
                item.put("id", SubscriptionXmlStore.nextId(subscriptions));
                item.put("name", name);
                item.put("email", email);
                item.put("plan", plan);
                subscriptions.add(item);
                SubscriptionXmlStore.save(getServletContext(), subscriptions);
                String syncError = SubscriptionDbSync.upsert(item);
                if (syncError == null) {
                    message = "Subscription saved successfully in XML and database.";
                } else {
                    message = "Subscription saved in XML, but database sync failed.";
                    messageType = "error";
                }
            }
        }

        renderPage(request, response, message, messageType);
    }

    private List<Map<String, String>> getSubscriptions() {
        return SubscriptionXmlStore.load(getServletContext());
    }

    private void renderPage(HttpServletRequest request, HttpServletResponse response, String message, String messageType)
            throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        String title = getServletConfig().getInitParameter("moduleTitle");
        List<Map<String, String>> subscriptions = getSubscriptions();
        List<Map<String, String>> plans = OttXmlConfig.getSubscriptionPlans(getServletContext());
        String editId = trim(request.getParameter("edit"));
        String viewId = trim(request.getParameter("view"));
        String syncAllError = SubscriptionDbSync.syncAll(subscriptions);
        if (syncAllError != null && message == null) {
            message = "Subscriptions loaded from XML, but database sync is currently unavailable.";
            messageType = "error";
        }

        if ("delete".equalsIgnoreCase(request.getParameter("action"))) {
            String deleteId = trim(request.getParameter("id"));
            if (removeSubscription(deleteId, subscriptions)) {
                SubscriptionXmlStore.save(getServletContext(), subscriptions);
                String syncError = SubscriptionDbSync.delete(deleteId);
                if (syncError == null) {
                    message = "Subscription deleted successfully from XML and database.";
                    messageType = "success";
                } else {
                    message = "Subscription deleted from XML, but database delete failed.";
                    messageType = "error";
                }
                editId = "";
                viewId = "";
            } else {
                message = "Invalid subscription selected for delete.";
                messageType = "error";
            }
        }

        Map<String, String> editItem = findSubscription(editId, subscriptions);
        Map<String, String> viewItem = findSubscription(viewId, subscriptions);

        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>" + title + "</title>");
        out.println("<meta charset=\"UTF-8\">");
        out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
        out.println("<style>");
        out.println("body{margin:0;font-family:Segoe UI,Arial,sans-serif;background:radial-gradient(circle at top right,rgba(255,183,3,.12),transparent 30%),linear-gradient(135deg,#0d111a,#171d2d 55%,#101010);color:#f3f4f6;padding:24px;}");
        out.println(".wrap{max-width:900px;margin:0 auto;}");
        out.println(".hero{background:linear-gradient(120deg,rgba(229,9,20,.2),rgba(255,183,3,.08));border:1px solid #2e2e2e;border-radius:16px;padding:22px;margin-bottom:18px;}");
        out.println(".hero-top{display:flex;align-items:center;gap:12px;}");
        out.println(".hero-icon{width:42px;height:42px;border-radius:13px;display:grid;place-items:center;background:linear-gradient(120deg,#e50914,#ffb703);color:#171717;font-weight:800;font-size:.82rem;}");
        out.println(".hero-note{display:flex;gap:10px;flex-wrap:wrap;margin-top:12px;}");
        out.println(".hero-note span{padding:7px 10px;border-radius:999px;background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.08);font-size:.83rem;color:#eceff6;}");
        out.println(".grid{display:grid;grid-template-columns:1.1fr .9fr;gap:18px;}");
        out.println(".card{background:#171717;border:1px solid #2e2e2e;border-radius:14px;padding:18px;}");
        out.println(".read-card{margin-bottom:18px;}");
        out.println(".section-head{display:flex;align-items:center;justify-content:space-between;gap:10px;margin-bottom:12px;}");
        out.println(".ghost-link{color:#9cc1ff;text-decoration:none;font-size:.9rem;}");
        out.println("label{display:block;margin:12px 0 6px;color:#c7cad1;font-size:.92rem;}");
        out.println("input,select{width:100%;padding:10px;border-radius:8px;border:1px solid #3a3a3a;background:#0e0e0e;color:#fff;}");
        out.println("button{margin-top:14px;padding:11px 14px;border:0;border-radius:8px;background:#e50914;color:#fff;font-weight:700;cursor:pointer;}");
        out.println(".msg{margin-top:12px;padding:10px 12px;border-radius:10px;display:inline-block;}");
        out.println(".msg.success{color:#9ef0b6;background:rgba(158,240,182,.12);border:1px solid rgba(158,240,182,.24);}");
        out.println(".msg.error{color:#ffd6d6;background:rgba(229,9,20,.12);border:1px solid rgba(229,9,20,.28);}");
        out.println(".sub{padding:12px 0;border-bottom:1px solid #2a2a2a;color:#d6d8de;}");
        out.println(".sub strong{display:block;margin-bottom:6px;color:#fff;}");
        out.println(".sub-meta{font-size:.88rem;color:#adb4c4;line-height:1.45;}");
        out.println(".sub-actions{display:flex;gap:8px;flex-wrap:wrap;margin-top:10px;}");
        out.println(".sub-actions a{padding:7px 10px;border-radius:8px;border:1px solid #383838;background:#1f1f1f;color:#fff;font-size:.82rem;text-decoration:none;}");
        out.println(".sub-actions a.delete{background:rgba(229,9,20,.14);border-color:rgba(229,9,20,.36);color:#ffd6d6;}");
        out.println(".plan-table{width:100%;border-collapse:collapse;margin-top:12px;background:#111;border:1px solid #2a2a2a;border-radius:12px;overflow:hidden;}");
        out.println(".plan-table th,.plan-table td{padding:10px;border-bottom:1px solid #252525;text-align:left;font-size:.9rem;}");
        out.println(".plan-table th{background:#1c1c1c;color:#fff;}");
        out.println(".plan-table td{color:#cfd5e2;}");
        out.println(".read-box{padding:14px;border-radius:12px;background:#111;border:1px solid #2a2a2a;}");
        out.println(".read-box p{margin:8px 0;color:#cfd5e2;line-height:1.5;}");
        out.println("a{color:#9cc1ff;text-decoration:none;}");
        out.println(".chatbot-float{position:fixed;right:20px;bottom:20px;width:64px;height:64px;border-radius:18px;display:grid;place-items:center;text-decoration:none;background:linear-gradient(135deg,#e50914,#ffb703);color:#151515;box-shadow:0 18px 30px rgba(0,0,0,.32);z-index:40}");
        out.println(".chatbot-float span{font-size:.78rem;font-weight:800;line-height:1.05;text-align:center}");
        out.println("@media (max-width: 760px){.grid{grid-template-columns:1fr;}}");
        out.println("</style></head><body>");
        out.println("<div class=\"wrap\">");
        out.println("<div class=\"hero\"><div class=\"hero-top\"><div class=\"hero-icon\">SB</div><div><h2>" + title + "</h2><p>This module is configured using entries in web.xml and plan values from ott-config.xml.</p></div></div><div class=\"hero-note\"><span>XML-configured</span><span>Offline form</span><span>Local servlet module</span></div></div>");
        if (viewItem != null) {
            out.println("<div class=\"card read-card\">");
            out.println("<div class=\"section-head\"><h3>Read Subscription</h3><a class=\"ghost-link\" href=\"subscription\">Clear selection</a></div>");
            out.println("<div class=\"read-box\">");
            out.println("<p><strong>Name:</strong> " + escapeHtml(viewItem.get("name")) + "</p>");
            out.println("<p><strong>Email:</strong> " + escapeHtml(viewItem.get("email")) + "</p>");
            out.println("<p><strong>Plan:</strong> " + escapeHtml(viewItem.get("plan")) + "</p>");
            out.println("</div></div>");
        }
        out.println("<div class=\"grid\">");
        out.println("<div class=\"card\">");
        out.println("<div class=\"section-head\"><h3>" + (editItem != null ? "Edit Subscription" : "Create Subscription") + "</h3>"
                + (editItem != null ? "<a class=\"ghost-link\" href=\"subscription\">Cancel edit</a>" : "") + "</div>");
        out.println("<form method=\"post\" action=\"subscription\">");
        out.println("<input type=\"hidden\" name=\"formAction\" value=\"" + (editItem != null ? "update" : "add") + "\">");
        if (editItem != null) {
            out.println("<input type=\"hidden\" name=\"id\" value=\"" + escapeHtml(editItem.get("id")) + "\">");
        }
        out.println("<label>Name</label><input type=\"text\" name=\"name\" placeholder=\"Subscriber name\" value=\""
                + (editItem != null ? escapeHtml(editItem.get("name")) : "") + "\">");
        out.println("<label>Email</label><input type=\"email\" name=\"email\" placeholder=\"subscriber@example.com\" value=\""
                + (editItem != null ? escapeHtml(editItem.get("email")) : "") + "\">");
        out.println("<label>Plan</label>");
        out.println("<select name=\"plan\">");
        for (Map<String, String> plan : plans) {
            out.println(option(plan, editItem));
        }
        out.println("</select>");
        out.println("<button type=\"submit\">" + (editItem != null ? "Update Subscription" : "Save Subscription") + "</button>");
        if (message != null) {
            out.println("<div class=\"msg " + ("error".equals(messageType) ? "error" : "success") + "\">" + escapeHtml(message) + "</div>");
        }
        out.println("</form>");
        out.println("<h3 style=\"margin-top:18px;\">Subscription Plans</h3>");
        out.println("<table class=\"plan-table\">");
        out.println("<thead><tr><th>Plan</th><th>Price</th><th>Quality</th><th>Screens</th></tr></thead>");
        out.println("<tbody>");
        for (Map<String, String> plan : plans) {
            out.println("<tr>");
            out.println("<td>" + escapeHtml(plan.get("name")) + "</td>");
            out.println("<td>" + escapeHtml(plan.get("currency")) + " " + escapeHtml(plan.get("price")) + "</td>");
            out.println("<td>" + escapeHtml(plan.get("quality")) + "</td>");
            out.println("<td>" + escapeHtml(plan.get("screens")) + "</td>");
            out.println("</tr>");
        }
        out.println("</tbody></table>");
        out.println("<p style=\"margin-top:16px;\"><a href=\"home.jsp\">Back to Dashboard</a></p>");
        out.println("</div>");
        out.println("<div class=\"card\">");
        out.println("<h3>Subscriptions Stored In XML</h3>");
        if (subscriptions.isEmpty()) {
            out.println("<p>No subscriptions yet.</p>");
        } else {
            out.println("<table class=\"plan-table\">");
            out.println("<thead><tr><th>ID</th><th>Name</th><th>Email</th><th>Plan</th><th>Actions</th></tr></thead>");
            out.println("<tbody>");
            for (Map<String, String> subscription : subscriptions) {
                String id = escapeHtml(subscription.get("id"));
                out.println("<tr>");
                out.println("<td>" + id + "</td>");
                out.println("<td>" + escapeHtml(subscription.get("name")) + "</td>");
                out.println("<td>" + escapeHtml(subscription.get("email")) + "</td>");
                out.println("<td>" + escapeHtml(subscription.get("plan")) + "</td>");
                out.println("<td><div class=\"sub-actions\">");
                out.println("<a href=\"subscription?view=" + id + "\">Read</a>");
                out.println("<a href=\"subscription?edit=" + id + "\">Edit</a>");
                out.println("<a class=\"delete\" href=\"subscription?action=delete&id=" + id
                        + "\" onclick=\"return confirm('Delete this subscription?');\">Delete</a>");
                out.println("</div></td>");
                out.println("</tr>");
            }
            out.println("</tbody></table>");
        }
        out.println("</div>");
        out.println("</div></div>");
        out.println("<a class=\"chatbot-float\" href=\"chatbot.jsp\" title=\"Open Helpline Chatbot\"><span>CHAT<br />BOT</span></a>");
        out.println("</body></html>");
    }

    private Map<String, String> findSubscription(String id, List<Map<String, String>> subscriptions) {
        if (id == null || id.isEmpty()) {
            return null;
        }
        for (Map<String, String> subscription : subscriptions) {
            if (id.equals(subscription.get("id"))) {
                return subscription;
            }
        }
        return null;
    }

    private boolean removeSubscription(String id, List<Map<String, String>> subscriptions) {
        Map<String, String> item = findSubscription(id, subscriptions);
        if (item == null) {
            return false;
        }
        subscriptions.remove(item);
        return true;
    }

    private String option(Map<String, String> plan, Map<String, String> editItem) {
        String planName = plan.get("name");
        String price = plan.get("price");
        String currency = plan.get("currency");
        boolean selected = editItem != null && planName.equals(editItem.get("plan"));
        return "<option value=\"" + escapeHtml(planName) + "\"" + (selected ? " selected" : "") + ">"
                + escapeHtml(planName) + " - " + escapeHtml(currency) + " " + escapeHtml(price) + "</option>";
    }

    private String escapeHtml(String value) {
        if (value == null) {
            return "";
        }
        return value
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
