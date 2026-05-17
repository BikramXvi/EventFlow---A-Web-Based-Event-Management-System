package com.eventflow.controllers;

import com.eventflow.model.EventModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.*;
import java.util.UUID;
import java.io.File;

@WebServlet("/admin/editEvent")
@MultipartConfig(
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 6 * 1024 * 1024
)
public class EditEventServlet extends HttpServlet {

    private final EventModel eventModel = new EventModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        String[] event = eventModel.getEventById(id);

        if (event == null) {
            res.sendRedirect(req.getContextPath() + "/admin/events");
            return;
        }

        req.setAttribute("event", event);
        req.getRequestDispatcher("/WEB-INF/pages/admin/editEvent.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        int id = Integer.parseInt(req.getParameter("id"));

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

            req.setAttribute("errorMsg", "All fields are required.");
            doGet(req, res);
            return;
        }

        // OPTIONAL IMAGE UPDATE (safe way)
        Part filePart = req.getPart("eventImage");
        String imagePath = null;

        if (filePart != null && filePart.getSize() > 0) {
            imagePath = saveImage(filePart);
            eventModel.updateImagePath(id, imagePath);
        }

        boolean updated = eventModel.updateEvent(
                id,
                title,
                description,
                location,
                eventDate,
                startTime,
                endTime,
                Integer.parseInt(capacity),
                status,
                null // imagePath ignored in your updateEvent anyway
        );

        if (updated) {
            res.sendRedirect(req.getContextPath() + "/admin/events");
        } else {
            req.setAttribute("errorMsg", "Failed to update event.");
            doGet(req, res);
        }
    }

    private String saveImage(Part filePart) {
        try {
            String contentType = filePart.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) return null;

            String ext = contentType.contains("png") ? ".png"
                    : contentType.contains("gif") ? ".gif"
                    : ".jpg";

            String filename = "evt_" + UUID.randomUUID().toString().replace("-", "").substring(0, 12) + ext;

            String uploadDir = getServletContext().getRealPath("/")
                    + "uploads" + File.separator + "events";

            Files.createDirectories(Paths.get(uploadDir));

            try (InputStream in = filePart.getInputStream()) {
                Files.copy(in, Paths.get(uploadDir, filename), StandardCopyOption.REPLACE_EXISTING);
            }

            return filename;

        } catch (Exception e) {
            System.out.println("Image upload error: " + e.getMessage());
            return null;
        }
    }

    private String trim(String s) {
        return s == null ? "" : s.trim();
    }
}