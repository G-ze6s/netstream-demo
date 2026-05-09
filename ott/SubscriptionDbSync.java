package com.ott;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.List;
import java.util.Map;

public final class SubscriptionDbSync {
    private static final HttpClient CLIENT = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(5))
            .build();

    private SubscriptionDbSync() {
    }

    public static String upsert(Map<String, String> item) {
        String payload = "{"
                + "\"xml_id\":" + parseId(item.get("id")) + ","
                + "\"name\":\"" + escapeJson(item.get("name")) + "\","
                + "\"email\":\"" + escapeJson(item.get("email")) + "\","
                + "\"plan\":\"" + escapeJson(item.get("plan")) + "\""
                + "}";
        return post("http://localhost/ott-backend/api/subscription_upsert.php", payload);
    }

    public static String delete(String id) {
        String payload = "{\"xml_id\":" + parseId(id) + "}";
        return post("http://localhost/ott-backend/api/subscription_delete.php", payload);
    }

    public static String syncAll(List<Map<String, String>> subscriptions) {
        for (Map<String, String> item : subscriptions) {
            String error = upsert(item);
            if (error != null) {
                return error;
            }
        }
        return null;
    }

    private static String post(String url, String payload) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .timeout(Duration.ofSeconds(10))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(payload))
                    .build();

            HttpResponse<String> response = CLIENT.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() >= 200 && response.statusCode() < 300) {
                return null;
            }
            return response.body() == null || response.body().isEmpty()
                    ? "Database sync failed."
                    : response.body();
        } catch (Exception ex) {
            return ex.getMessage();
        }
    }

    private static int parseId(String value) {
        try {
            return Integer.parseInt(value);
        } catch (Exception ex) {
            return 0;
        }
    }

    private static String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
