package com.eventflow.controllers;

import com.eventflow.model.VendorModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/vendor/applications")
public class VendorApplicationsServlet extends HttpServlet {

    private final VendorModel vendorModel = new VendorModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        int vendorId = (int) session.getAttribute("userId");

        req.setAttribute("applications", vendorModel.getMyApplications(vendorId));
        req.getRequestDispatcher("/WEB-INF/pages/vendor/myApplications.jsp").forward(req, res);
    }
}