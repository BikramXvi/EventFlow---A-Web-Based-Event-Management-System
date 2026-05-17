package com.eventflow.controllers;

import com.eventflow.model.VendorModel;
import com.eventflow.model.EventModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/vendor/apply")
public class VendorApplyServlet extends HttpServlet {

    private final VendorModel vendorModel = new VendorModel();
    private final EventModel  eventModel  = new EventModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        int vendorId = (int) session.getAttribute("userId");

        req.setAttribute("events",       eventModel.getAllEvents());
        req.setAttribute("applications", vendorModel.getMyApplications(vendorId));
        req.getRequestDispatcher("/WEB-INF/pages/vendor/applyEvent.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        int vendorId = (int) session.getAttribute("userId");
        int eventId  = Integer.parseInt(req.getParameter("eventId"));
        String serviceDescription = req.getParameter("serviceDescription");

        if (serviceDescription == null || serviceDescription.trim().isEmpty()) {
            req.getSession().setAttribute("errorMsg", "Please describe the service you will provide.");
            res.sendRedirect(req.getContextPath() + "/vendor/apply");
            return;
        }

        boolean success = vendorModel.apply(eventId, vendorId, serviceDescription.trim());
        req.getSession().setAttribute(
            success ? "successMsg" : "errorMsg",
            success ? "Application submitted successfully." : "Could not apply — you may have already applied for this event."
        );

        res.sendRedirect(req.getContextPath() + "/vendor/apply");
    }
}