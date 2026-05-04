package com.eventflow.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * LandingServlet
 * Handles requests for the homepage ("/")
 * Transfers flash messages from session to request scope
 */
@WebServlet(name = "LandingServlet", urlPatterns = {""})
public class LandingServlet extends HttpServlet {

    /**
     * Handles GET request for landing page
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get existing session (do not create new)
        HttpSession session = request.getSession(false);

        if (session != null) {

            // Retrieve flash messages from session
            Object successMsg = session.getAttribute("contactSuccess");
            Object errorMsg = session.getAttribute("contactError");

            // Move success message to request scope
            if (successMsg != null) {
                request.setAttribute("contactSuccess", successMsg.toString());
                session.removeAttribute("contactSuccess");
            }

            // Move error message to request scope
            if (errorMsg != null) {
                request.setAttribute("contactError", errorMsg.toString());
                session.removeAttribute("contactError");
            }
        }

        // Forward request to JSP (inside WEB-INF for security)
        request.getRequestDispatcher("/WEB-INF/pages/landing/index.jsp")
               .forward(request, response);
    }
}