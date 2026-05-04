package com.eventflow.controllers;

import com.eventflow.model.VendorModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/vendors")
public class ManageVendorsServlet extends HttpServlet {

    private final VendorModel vendorModel = new VendorModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("vendors",      vendorModel.getAllVendors());
        req.setAttribute("applications", vendorModel.getAllApplications());
        req.getRequestDispatcher("/WEB-INF/pages/admin/manageVendors.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action        = req.getParameter("action");
        int    applicationId = Integer.parseInt(req.getParameter("applicationId"));

        if ("approve".equals(action)) {
            vendorModel.updateStatus(applicationId, "approved");
        } else if ("reject".equals(action)) {
            vendorModel.updateStatus(applicationId, "rejected");
        }

        res.sendRedirect(req.getContextPath() + "/admin/vendors");
    }
}