package com.eventflow.controllers;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import com.eventflow.model.EventModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/admin/createEvent")
@MultipartConfig(
    maxFileSize    = 5 * 1024 * 1024,
    maxRequestSize = 6 * 1024 * 1024
)
public class CreateEventServlet extends HttpServlet {

    private final EventModel eventModel = new EventModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/admin/createEvent.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(false);
        int adminId = (int) session.getAttribute("userId");

        String title       = trim(req.getParameter("title"));
        String description = trim(req.getParameter("description"));
        String location    = trim(req.getParameter("location"));
        String eventDate   = trim(req.getParameter("eventDate"));
        String startTime   = trim(req.getParameter("startTime"));
        String endTime     = trim(req.getParameter("endTime"));
        String capacity    = trim(req.getParameter("capacity"));
        String status      = trim(req.getParameter("status"));

        if (title.isEmpty() || location.isEmpty() || eventDate.isEmpty()
                || startTime.isEmpty() || endTime.isEmpty() || capacity.isEmpty()) {
            req.setAttribute("errorMsg", "All fields except image are required.");
            req.getRequestDispatcher("/WEB-INF/pages/admin/createEvent.jsp").forward(req, res);
            return;
        }

        String imagePath = null;
        Part filePart = req.getPart("eventImage");
        if (filePart != null && filePart.getSize() > 0) {
            imagePath = saveImage(filePart);
        }

        boolean created = eventModel.createEvent(
            title, description, location, eventDate,
            startTime, endTime, Integer.parseInt(capacity),
            status, adminId, imagePath
        );

        if (created) {
            req.getSession().setAttribute("successMsg", "Event created successfully.");
            res.sendRedirect(req.getContextPath() + "/admin/events");
        } else {
            req.setAttribute("errorMsg", "Failed to create event. Please try again.");
            req.getRequestDispatcher("/WEB-INF/pages/admin/createEvent.jsp").forward(req, res);
        }
    }

    private String saveImage(Part filePart) {
        try {
            String contentType = filePart.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) return null;

            String ext = contentType.contains("png") ? ".png"
                       : contentType.contains("gif") ? ".gif"
                       : ".jpg";

            String filename  = "evt_" + UUID.randomUUID().toString().replace("-", "").substring(0, 12) + ext;
            String uploadDir = getServletContext().getRealPath("/") + "uploads" + File.separator + "events";

            Files.createDirectories(Paths.get(uploadDir));

            try (InputStream in = filePart.getInputStream()) {
                Files.copy(in, Paths.get(uploadDir, filename), StandardCopyOption.REPLACE_EXISTING);
            }
            return filename;
        } catch (Exception e) {
            System.err.println("[CreateEventServlet] saveImage: " + e.getMessage());
            return null;
        }
    }

    private String trim(String s) {
        return s == null ? "" : s.trim();
    }
}