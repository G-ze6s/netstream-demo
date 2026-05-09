package com.ott;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import jakarta.servlet.ServletContext;

public final class OttXmlConfig {
    private OttXmlConfig() {
    }

    public static List<Map<String, String>> getSubscriptionPlans(ServletContext context) {
        List<Map<String, String>> plans = new ArrayList<Map<String, String>>();
        Document document = loadDocument(context);
        if (document == null) {
            plans.add(plan("Basic", "199.00", "INR"));
            plans.add(plan("Standard", "299.00", "INR"));
            plans.add(plan("Premium", "499.00", "INR"));
            return plans;
        }

        NodeList nodes = document.getElementsByTagName("plan");
        for (int i = 0; i < nodes.getLength(); i++) {
            Node node = nodes.item(i);
            if (!(node instanceof Element)) {
                continue;
            }
            Element planElement = (Element) node;
            if (!"subscription-plans".equals(planElement.getParentNode().getNodeName())) {
                continue;
            }

            Element priceElement = firstChild(planElement, "price");
            Map<String, String> plan = new HashMap<String, String>();
            plan.put("name", text(planElement, "name"));
            plan.put("price", priceElement != null ? priceElement.getTextContent().trim() : "");
            plan.put("currency", priceElement != null ? priceElement.getAttribute("currency") : "INR");
            plan.put("quality", text(planElement, "quality"));
            plan.put("screens", text(planElement, "screens"));
            plans.add(plan);
        }

        return plans;
    }

    public static List<String> getChatbotTopics(ServletContext context) {
        List<String> topics = new ArrayList<String>();
        Document document = loadDocument(context);
        if (document == null) {
            topics.add("login");
            topics.add("registration");
            topics.add("subscription");
            topics.add("payment");
            return topics;
        }

        NodeList nodes = document.getElementsByTagName("topic");
        for (int i = 0; i < nodes.getLength(); i++) {
            String value = nodes.item(i).getTextContent();
            if (value != null && !value.trim().isEmpty()) {
                topics.add(value.trim());
            }
        }
        return topics;
    }

    public static Map<String, String> getSupportInfo(ServletContext context) {
        Map<String, String> support = new HashMap<String, String>();
        support.put("helpline", "1800-123-OTT");
        support.put("email", "support@netstream.local");
        support.put("working-hours", "09:00 AM - 08:00 PM");
        support.put("office", "Chennai Support Center");

        Document document = loadSupportDocument(context);
        if (document == null) {
            return support;
        }

        support.put("helpline", text(document.getDocumentElement(), "helpline"));
        support.put("email", text(document.getDocumentElement(), "email"));
        support.put("working-hours", text(document.getDocumentElement(), "working-hours"));
        support.put("office", text(document.getDocumentElement(), "office"));
        return support;
    }

    private static Map<String, String> plan(String name, String price, String currency) {
        Map<String, String> plan = new HashMap<String, String>();
        plan.put("name", name);
        plan.put("price", price);
        plan.put("currency", currency);
        plan.put("quality", "HD");
        plan.put("screens", "1");
        return plan;
    }

    private static Document loadDocument(ServletContext context) {
        return loadDocument(context, "/WEB-INF/ott-config.xml");
    }

    private static Document loadSupportDocument(ServletContext context) {
        return loadDocument(context, "/WEB-INF/support-info.xml");
    }

    private static Document loadDocument(ServletContext context, String relativePath) {
        try {
            String path = context.getRealPath(relativePath);
            if (path == null) {
                return null;
            }

            File file = new File(path);
            if (!file.exists()) {
                return null;
            }

            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document document = builder.parse(file);
            document.getDocumentElement().normalize();
            return document;
        } catch (Exception ex) {
            return null;
        }
    }

    private static Element firstChild(Element parent, String tagName) {
        NodeList nodes = parent.getElementsByTagName(tagName);
        if (nodes.getLength() == 0) {
            return null;
        }
        Node node = nodes.item(0);
        return node instanceof Element ? (Element) node : null;
    }

    private static String text(Element parent, String tagName) {
        Element element = firstChild(parent, tagName);
        return element == null ? "" : element.getTextContent().trim();
    }
}
