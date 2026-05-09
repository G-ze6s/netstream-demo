package com.ott;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import jakarta.servlet.ServletContext;

public final class SubscriptionXmlStore {
    private SubscriptionXmlStore() {
    }

    public static synchronized List<Map<String, String>> load(ServletContext context) {
        List<Map<String, String>> subscriptions = new ArrayList<Map<String, String>>();
        Document document = loadDocument(context);
        if (document == null) {
            return subscriptions;
        }

        NodeList nodes = document.getElementsByTagName("subscription");
        for (int i = 0; i < nodes.getLength(); i++) {
            if (!(nodes.item(i) instanceof Element)) {
                continue;
            }
            Element element = (Element) nodes.item(i);
            Map<String, String> item = new HashMap<String, String>();
            item.put("id", element.getAttribute("id"));
            item.put("name", text(element, "name"));
            item.put("email", text(element, "email"));
            item.put("plan", text(element, "plan"));
            subscriptions.add(item);
        }
        return subscriptions;
    }

    public static synchronized void save(ServletContext context, List<Map<String, String>> subscriptions) {
        try {
            File file = ensureFile(context);
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document document = builder.newDocument();

            Element root = document.createElement("subscriptions");
            document.appendChild(root);

            for (Map<String, String> subscription : subscriptions) {
                Element item = document.createElement("subscription");
                item.setAttribute("id", value(subscription.get("id")));
                append(document, item, "name", subscription.get("name"));
                append(document, item, "email", subscription.get("email"));
                append(document, item, "plan", subscription.get("plan"));
                root.appendChild(item);
            }

            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            transformer.setOutputProperty(OutputKeys.INDENT, "yes");
            transformer.setOutputProperty(OutputKeys.METHOD, "xml");
            transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
            transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "4");
            transformer.transform(new DOMSource(document), new StreamResult(file));
        } catch (Exception ex) {
            throw new RuntimeException("Failed to save subscriptions XML", ex);
        }
    }

    public static synchronized String nextId(List<Map<String, String>> subscriptions) {
        int max = 0;
        for (Map<String, String> item : subscriptions) {
            try {
                max = Math.max(max, Integer.parseInt(value(item.get("id"))));
            } catch (Exception ignored) {
            }
        }
        return String.valueOf(max + 1);
    }

    private static Document loadDocument(ServletContext context) {
        try {
            File file = ensureFile(context);
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document document = builder.parse(file);
            document.getDocumentElement().normalize();
            return document;
        } catch (Exception ex) {
            return null;
        }
    }

    private static File ensureFile(ServletContext context) throws Exception {
        String realPath = context.getRealPath("/WEB-INF/subscriptions-data.xml");
        File file = new File(realPath);
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document document = builder.newDocument();
            Element root = document.createElement("subscriptions");
            document.appendChild(root);
            Transformer transformer = TransformerFactory.newInstance().newTransformer();
            transformer.setOutputProperty(OutputKeys.INDENT, "yes");
            transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
            transformer.transform(new DOMSource(document), new StreamResult(file));
        }
        return file;
    }

    private static void append(Document document, Element parent, String name, String value) {
        Element child = document.createElement(name);
        child.setTextContent(value(value));
        parent.appendChild(child);
    }

    private static String text(Element parent, String tagName) {
        NodeList nodes = parent.getElementsByTagName(tagName);
        if (nodes.getLength() == 0) {
            return "";
        }
        return value(nodes.item(0).getTextContent());
    }

    private static String value(String input) {
        return input == null ? "" : input;
    }
}
