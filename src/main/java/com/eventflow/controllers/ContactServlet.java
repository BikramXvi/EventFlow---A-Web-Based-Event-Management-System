package com.eventflow.controllers;

import com.eventflow.model.ContactModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private final ContactModel contactModel = new ContactModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.sendRedirect(req.getContextPath() + "/#contact");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String name    = trim(req.getParameter("name"));
        String email   = trim(req.getParameter("email"));
        String subject = trim(req.getParameter("subject"));
        String message = trim(req.getParameter("message"));

        if (name.isEmpty() || message.isEmpty()) {
            req.getSession().setAttribute("contactError", "Name and message are required.");
            res.sendRedirect(req.getContextPath() + "/#contact");
            return;
        }

        if (name.length() > 100 || message.length() > 5000) {
            req.getSession().setAttribute("contactError", "Input is too long.");
            res.sendRedirect(req.getContextPath() + "/#contact");
            return;
        }

        boolean saved = contactModel.saveMessage(name, email, subject, message);

        if (saved) {
            req.getSession().setAttribute("contactSuccess", "true");
        } else {
            req.getSession().setAttribute("contactError", "Something went wrong. Please try again.");
        }

        res.sendRedirect(req.getContextPath() + "/#contact");
    }

    private String trim(String s) {
        return (s == null) ? "" : s.trim();
    }
}