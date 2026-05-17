package com.eventflow.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@WebServlet("/admin/upload-image")
@MultipartConfig(
    maxFileSize    = 5 * 1024 * 1024,
    maxRequestSize = 6 * 1024 * 1024
)
public class EventImageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        Part filePart = req.getPart("eventImage");
        if (filePart == null || filePart.getSize() == 0) {
            res.getWriter().write("");
            return;
        }

        String contentType = filePart.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            res.setStatus(400);
            res.getWriter().write("error:not_an_image");
            return;
        }

        String ext = contentType.contains("png") ? ".png"
                   : contentType.contains("gif") ? ".gif"
                   : ".jpg";

        String filename  = "evt_" + UUID.randomUUID().toString().replace("-", "").substring(0, 12) + ext;
        String uploadDir = getServletContext().getRealPath("/") + "uploads" + File.separator + "events";

        Files.createDirectories(Paths.get(uploadDir));

        try (InputStream in = filePart.getInputStream()) {
            Files.copy(in, Paths.get(uploadDir, filename), StandardCopyOption.REPLACE_EXISTING);
        }

        res.getWriter().write(filename);
    }
}